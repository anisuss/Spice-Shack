import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';

class ButtonToBuy extends StatelessWidget {
  Function onTap;
  ButtonToBuy({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: TextButton(
        onPressed: ()=> onTap(),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: MyColors.silver),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(.4),
                  Colors.black.withOpacity(.5),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          child: Container(
            height: 8.h,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.red.withOpacity(.4),
                    Colors.red.withOpacity(.5),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                color: Colors.red),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 6.h,
                    width: 6.h,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius
                            .circular(
                            10),
                        color:
                        Colors.white),
                    child: Padding(
                      padding:
                      const EdgeInsets
                          .all(8.0),
                      child: Lottie.asset(
                          'assets/images/lottie/cart.json'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      "Add to cart",
                      style: AppTextStyle.spiceShackFonts(
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: MyColors.silver,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
