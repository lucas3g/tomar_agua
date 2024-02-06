import 'package:flutter/material.dart';

class Constants {}

extension ContextExtensions on BuildContext {
  ColorScheme get appTheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
}
