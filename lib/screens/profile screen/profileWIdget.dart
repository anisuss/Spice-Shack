import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';

class ProfileWidget extends StatelessWidget {
  String title;
  String value;
  ProfileWidget({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 8.h,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(.4),
              Colors.black.withOpacity(.5),
            ],
          ),
          border: Border.all(width: 1,color: Colors.brown, ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: AutoSizeText(
                  title,
                  textAlign: TextAlign.left,
                  style: AppTextStyle.spiceShackFonts(
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: MyColors.silver,
                    ),
                  ),
                ),
              ),
              Expanded(child: Center(
                child: AutoSizeText(
                  value,
                  textAlign: TextAlign.right,
                  style: AppTextStyle.spiceShackFonts(
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: MyColors.silver,
                    ),
                  ),
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
