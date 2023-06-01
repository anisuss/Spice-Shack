import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';

class ButtonWidget extends StatelessWidget {
  String text;
  Function onTap;
  ButtonWidget({super.key, required this.onTap,required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: GradientsConstants.redGradient,
        ),
        child: Center(
          child: AutoSizeText(
            text,
            textAlign: TextAlign.center,
            style: AppTextStyle.spiceShackFonts(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: MyColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
