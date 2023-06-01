import 'package:flutter/cupertino.dart';

import 'colors_resources.dart';

class GradientsConstants {
  static var goldGradient = LinearGradient(
    colors: [
      MyColors.gold,
      MyColors.gold1,
      MyColors.gold2,
      MyColors.gold3,
    ],
  );

  static var goldShadeGradient = LinearGradient(
    colors: [
      MyColors.gold,
      MyColors.gold1,
      MyColors.gold2,
      MyColors.gold3,
    ],
  );

  static var blackGradient = LinearGradient(
    colors: [
      MyColors.black,
      MyColors.black1,
      MyColors.black2,
    ],
  );

  static var redGradient = LinearGradient(
    colors: [
      MyColors.red,
      MyColors.red3,
      MyColors.red1,
      MyColors.red2,
    ],
  );
}