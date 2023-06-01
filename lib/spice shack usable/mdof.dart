import 'package:flutter/material.dart';
extension MediaQueryValues on BuildContext {
  double get widthMedia => MediaQuery.of(this).size.width;
  double get heightMedia => MediaQuery.of(this).size.height;
}