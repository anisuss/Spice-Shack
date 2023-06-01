import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';

class TextWidgetSimple extends StatelessWidget {
  String text;
  TextWidgetSimple({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16,),
      child: Center(
        child: AutoSizeText(
          text,
          textAlign: TextAlign.justify,
          style: AppTextStyle.spiceShackFonts(
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: MyColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
