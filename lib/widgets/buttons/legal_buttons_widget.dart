import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';

class LegalScreenWidgets extends StatelessWidget {
  Function onTap;
  String text;

  LegalScreenWidgets({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 5.0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 1,
              color: MyColors.grey,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AutoSizeText(
                    text,
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
                Center(
                  child: Icon(
                    Icons.arrow_forward,
                    color: MyColors.white,
                    size: MediaQuery.of(context).size.height * 0.03,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
