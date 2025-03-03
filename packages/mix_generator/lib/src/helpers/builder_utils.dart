// ignore_for_file: unnecessary-trailing-comma

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:mix_annotations/mix_annotations.dart';
// ignore_for_file: prefer_relative_imports
import 'package:mix_generator/src/helpers/field_info.dart';
import 'package:source_gen/source_gen.dart';

class MixHelperRef {
  MixHelperRef._();

  static String get _refName => 'MixHelpers';

  static String get deepEquality => '$_refName.deepEquality';

  static String get lerpDouble => '$_refName.lerpDouble';

  static String get mergeList => '${_refName}.mergeList';

  static String get lerpStrutStyle => '$_refName.lerpStrutStyle';

  static String get lerpMatrix4 => '$_refName.lerpMatrix4';

  static String get lerpTextStyle => '$_refName.lerpTextStyle';
}

Future<List<ClassElement>> getAnnotatedClasses(
  BuildStep buildStep,
  TypeChecker annotationTypeChecker,
) async {
  final resolver = buildStep.resolver;
  final libraryElement = await resolver.libraryFor(buildStep.inputId);

  return libraryElement.units
      .expand((unit) => unit.classes)
      .where((classElement) =>
          annotationTypeChecker.hasAnnotationOfExact(classElement))
      .toList();
}

abstract class AnnotationContext<T> {
  final ClassElement element;

  AnnotationContext({
    required this.element,
  });

  late final formatter = DartFormatter(pageWidth: 80, fixes: StyleFix.all);

  String get name => element.name;

  String get generatedName => '_\$${name}';

  String generate(String contents) {
    return formatter.format(contents);
  }
}

sealed class ClassVisitorAnnotationContext<T> extends AnnotationContext {
  final List<ParameterInfo> fields;

  final T annotation;
  ClassVisitorAnnotationContext({
    required super.element,
    required this.fields,
    required this.annotation,
  });
}

class SpecAnnotationContext extends ClassVisitorAnnotationContext<MixableSpec> {
  SpecAnnotationContext({
    required super.element,
    required super.fields,
    required super.annotation,
  });

  String get attributeClassName => '${name}Attribute';
}

class DtoAnnotationContext extends ClassVisitorAnnotationContext<MixableDto> {
  DtoAnnotationContext({
    required super.element,
    required super.fields,
    required super.annotation,
  });
}

class EnumUtilityAnnotationContext extends AnnotationContext {
  final EnumElement enumElement;
  final bool generateCallMethod;
  EnumUtilityAnnotationContext({
    required super.element,
    required this.enumElement,
    required this.generateCallMethod,
  });
}

class ClassUtilityAnnotationContext extends AnnotationContext {
  final ClassElement valueElement;
  final ClassElement? mappingElement;
  final bool generateCallMethod;
  ClassUtilityAnnotationContext({
    required super.element,
    required this.valueElement,
    required this.mappingElement,
    required this.generateCallMethod,
  });
}

extension EnumElementX on EnumElement {
  List<String> get values {
    final valuesField = getField('values');
    final valuesObject = valuesField?.computeConstantValue();

    if (valuesObject != null && valuesObject.toListValue() != null) {
      return valuesObject
          .toListValue()!
          .map((obj) {
            final enumField = obj.getField('_name');
            return enumField?.toStringValue();
          })
          .whereType<String>()
          .toList();
    }
    return [];
  }
}

extension ClassElementX on ClassElement {
  bool get isConst => unnamedConstructor?.isConst ?? false;

  bool get hasUnamedConstructor => unnamedConstructor != null;

  DartType? getGenericTypeOfSuperclass() {
    final supertype = this.supertype;
    if (supertype != null) {
      return supertype.typeArguments.firstOrNull;
    }
    return null;
  }

  bool get isDto => _isMixType('Dto');

  bool get isSpec => _isMixType('Spec');

  bool get isMixUtiilty => _isMixType('MixUtility');

  bool _isMixType(String className) {
    return allSupertypes.any((type) {
      final mixPackageUri = Uri(scheme: 'package', path: 'mix/');
      final hasType = type.element.name == className;
      final isMixPackage =
          type.element.source.uri.scheme == mixPackageUri.scheme &&
              type.element.source.uri.path.startsWith(mixPackageUri.path);

      return hasType && isMixPackage;
    });
  }
}

Future<ClassElement?> getClassElementForTypeName(
  BuildStep buildStep,
  String typeName,
) async {
  final libraryElement = await buildStep.inputLibrary;

  // Look for the type in the current library
  var classElement = libraryElement.getClass(typeName);
  if (classElement != null) {
    return classElement;
  }

  // If not found, search in the imported libraries
  for (var importedLibrary in libraryElement.importedLibraries) {
    classElement = importedLibrary.getClass(typeName);
    if (classElement != null) {
      return classElement;
    }
  }

  // Type not found in the current library or its imports
  return null;
}

String kDefaultValueRef = 'defaultValue';

extension InterfaceTypeX on InterfaceType {
  String get typeName => element.name;

  ClassElement? get _classElement =>
      (element is ClassElement) ? element as ClassElement : null;

  bool get isDto => _classElement?.isDto ?? false;

  bool get isSpec => _classElement?.isSpec ?? false;
}

extension DartTypeX on DartType {
  String getTypeAsString() {
    final thisElement = this.element;

    // Check if element is a list
    if (thisElement is ClassElement &&
        !isDartCoreList &&
        !isDartCoreMap &&
        !isDartCoreSet &&
        !isDartCoreObject) {
      return thisElement.name;
    }
    return getDisplayString(withNullability: false);
  }

  ClassElement? get classElement {
    return this.element is ClassElement ? this.element as ClassElement : null;
  }

  InterfaceType? get interfaceType {
    return this is InterfaceType ? this as InterfaceType : null;
  }

  bool get isDto => interfaceType?.isDto ?? false;

  bool get isSpec => interfaceType?.isSpec ?? false;
  DartType? tryGetTypeGeneric() {
    if (this is ParameterizedType) {
      final type = this as ParameterizedType;
      if (type.typeArguments.isNotEmpty) {
        return type.typeArguments.firstOrNull;
      }
    }
    return null;
  }

  DartType getGenericType() {
    final type = tryGetTypeGeneric();
    if (type != null) {
      return type;
    }
    throw Exception(type?.getTypeAsString() ?? '' + 'has no type generic');
  }
}

DartType? extractDtoTypeArgument(ClassElement classElement) {
  // Check if the class itself is Dto<T>
  if (classElement.name == 'Dto' && classElement.typeParameters.length == 1) {
    DartType typeArgument = classElement.thisType.typeArguments.first;
    return resolveTypeArgument(typeArgument);
  }

  // Traverse the class hierarchy
  for (InterfaceType interface in classElement.allSupertypes) {
    if (interface.element.name == 'Dto') {
      List<DartType> typeArguments = interface.typeArguments;
      if (typeArguments.length == 1) {
        DartType typeArgument = typeArguments.first;
        return resolveTypeArgument(typeArgument);
      }
    }
  }

  return null; // Type argument not found
}

DartType? resolveTypeArgument(DartType type) {
  if (type is TypeParameterType) {
    // If the type is a generic type parameter, resolve its bound
    var bound = type.element.bound;
    if (bound != null) {
      return resolveTypeArgument(bound);
    }
  } else if (type is InterfaceType) {
    // If the type is an interface type, return it as the resolved type
    return type;
  }

  return null;
}
