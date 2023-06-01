import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spice_shack/resources/colors/gradient_colors.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';

class ProfileWidgets extends StatelessWidget {
  String text1;
  String text2;
   ProfileWidgets({super.key,required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: MyColors.grey,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: AutoSizeText(
                  text1,
                  textAlign: TextAlign.start,
                  style: AppTextStyle.spiceShackFonts(
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: MyColors.white,
                    ),
                  ),
                ),
              ),
              Expanded(flex: 4,
                child: AutoSizeText(
                  text2,
                  textAlign: TextAlign.start,
                  style: AppTextStyle.spiceShackFonts(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: MyColors.white,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
