import 'package:remix/helpers/variant.dart';

interface class ISpinnerVariant extends RemixVariant {
  const ISpinnerVariant(String name) : super('spinner.$name');
}

class SpinnerSize extends ISpinnerVariant {
  const SpinnerSize(String name) : super('size.$name');

  static const small = SpinnerSize('small');
  static const medium = SpinnerSize('medium');
  static const large = SpinnerSize('large');

  static List<SpinnerSize> get values => [small, medium, large];
}

class SpinnerVariant extends ISpinnerVariant {
  const SpinnerVariant(String name) : super('variant.$name');

  static const solid = SpinnerVariant('solid');
  static const dotted = SpinnerVariant('dotted');

  static List<SpinnerVariant> get values => [dotted, solid];
}
