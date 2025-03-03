// ignore_for_file: prefer-named-boolean-parameters

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../core/attribute.dart';
import '../core/factory/mix_data.dart';
import '../core/modifier.dart';
import '../core/utility.dart';
import '../internal/diagnostic_properties_builder_ext.dart';

/// A modifier that wraps a widget with the [AspectRatio] widget.
///
/// The [AspectRatio] widget sizes its child to match a given aspect ratio.
final class AspectRatioModifierAttribute extends WidgetModifierAttribute<
    AspectRatioModifierAttribute, AspectRatioModifierSpec> {
  /// The aspect ratio to use when sizing the child.
  ///
  /// For example, a 16:9 aspect ratio would have a value of 16.0 / 9.0.
  final double aspectRatio;
  const AspectRatioModifierAttribute(this.aspectRatio);

  @override
  AspectRatioModifierAttribute merge(AspectRatioModifierAttribute? other) {
    return AspectRatioModifierAttribute(other?.aspectRatio ?? aspectRatio);
  }

  @override
  AspectRatioModifierSpec resolve(MixData mix) {
    return AspectRatioModifierSpec(aspectRatio);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.addUsingDefault('aspectRatio', aspectRatio);
  }

  @override
  get props => [aspectRatio];
}

final class AspectRatioModifierSpec
    extends WidgetModifierSpec<AspectRatioModifierSpec> {
  final double aspectRatio;
  const AspectRatioModifierSpec(this.aspectRatio);

  @override
  AspectRatioModifierSpec lerp(AspectRatioModifierSpec? other, double t) {
    return AspectRatioModifierSpec(
      lerpDouble(aspectRatio, other?.aspectRatio, t) ?? aspectRatio,
    );
  }

  @override
  AspectRatioModifierSpec copyWith({double? aspectRatio}) {
    return AspectRatioModifierSpec(aspectRatio ?? this.aspectRatio);
  }

  @override
  get props => [aspectRatio];

  @override
  Widget build(Widget child) {
    return AspectRatio(aspectRatio: aspectRatio, child: child);
  }
}

final class AspectRatioUtility<T extends Attribute>
    extends MixUtility<T, AspectRatioModifierAttribute> {
  const AspectRatioUtility(super.builder);
  T call(double value) {
    return builder(AspectRatioModifierAttribute(value));
  }
}
