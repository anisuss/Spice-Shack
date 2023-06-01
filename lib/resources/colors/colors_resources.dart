import 'package:flutter/cupertino.dart';

class MyColors{
  static Color pink = const Color(0xFFFF4081);
  static Color white = const Color(0xFFFFFFFF);
  static Color checkOutColor = const Color(0xFFFFE0B2);
  static Color brown = const Color(0xFF763E01);
  static Color greyLight = const Color(0xFFF3F3F3);
  static Color grey = const Color(0xFFA5A5A5);
  static Color blue = const Color(0xFF1877F1);
  static Color black = const Color(0xFF212121);
  static Color red3 = const Color(0xFFC62828);
  static Color yellow = const Color(0xFFFF9100);
  static Color silver = const Color(0xFFE8EAF6);
  static Color lightGrey = const Color(0xFFE0E0E0);
  static Color gold = const Color(0xFF8B7831);
  static Color gold1 = const Color(0xFFC0A343);
  static Color gold2 = const Color(0xFFE5D177);
  static Color gold3 = const Color(0xFF947F30);
  static Color gold4 = const Color(0xFFE1D897);
  static Color black1 = const Color(0xFF3E3E3E);
  static Color black2 = const Color(0xFF121315);
  static Color red = const Color(0xFF6A060E);
  static Color red1 = const Color(0xFFD2000C);
  static Color red2 = const Color(0xFF6A060E);
  static Color green = const Color(0xFF2AD045);
  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;
    const lowDivisor = 6;
    const highDivisor = 5;
    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;
    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }
}