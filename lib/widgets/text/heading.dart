import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';

class TextHeading extends StatelessWidget {
  String text;
   TextHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AutoSizeText(
        text,
        textAlign: TextAlign.start,
        style: AppTextStyle.spiceShackFonts(
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: MyColors.white,
          ),
        ),
      ),
    );
  }
}
