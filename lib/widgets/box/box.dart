import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';

class BoxWidget extends StatelessWidget {
  String image;
  String price;
  String productName;
   BoxWidget({super.key, required this.image,required this.price,required this.productName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 30.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.silver),
              borderRadius: BorderRadius.circular(30),),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(.4),
                        Colors.brown.withOpacity(.5),
                      ],
                    ),
                  ),
                ),
                imageUrl: image,
                fit: BoxFit.cover,
                key: UniqueKey(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.5),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Center(
                  child: AutoSizeText(
                    productName,
                    style: AppTextStyle.spiceShackFonts(
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: MyColors.silver,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38.0),
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
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.5),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Center(
                  child: AutoSizeText(
                    "Price \$ $price",
                    style: AppTextStyle.spiceShackFonts(
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: MyColors.silver,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
