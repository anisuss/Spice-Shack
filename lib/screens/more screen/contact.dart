import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/widgets/text/heading.dart';
import 'package:spice_shack/widgets/text/text.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/backgrounds/app.jpg',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: MediaQuery.of(context).padding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                appBarWidget(context),

                TextHeading(text: 'Contact info'),
                TextWidgetSimple(text: 'Call: 612-404-7841'),
                TextWidgetSimple(text: 'Email:  order@spiceshackus.com'),

                TextHeading(text: 'Locations in Minneapolis'),
                TextWidgetSimple(text: 'Bloomington'),
                TextWidgetSimple(text: 'Downtown'),
                TextWidgetSimple(text: 'North town Mall'),
                TextWidgetSimple(text: 'Oakdale'),
                TextWidgetSimple(text: 'Ramada Hotel'),


              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget appBarWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: GradientsConstants.redGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.sp),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.backspace_outlined,
                size: 3.h,
                color: MyColors.silver,
              ),
            ),
          ),
          Center(
            child: AutoSizeText(
              "Contact Us",
              textAlign: TextAlign.start,
              style: AppTextStyle.spiceShackFonts(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: MyColors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8.h,
          ),
        ],
      ),
    );
  }
}
