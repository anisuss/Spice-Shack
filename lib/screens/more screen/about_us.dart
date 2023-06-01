import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/widgets/text/heading.dart';
import 'package:spice_shack/widgets/text/text.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

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

                TextHeading(text: 'We invite you to visit our restaurant'),
                TextWidgetSimple(text: 'Spice Shack which was previously known as I -Grill and was popular in the town and the neighborhood cities for its phenomenal taste. It was Started back in the Year 2000 by an Indian -American Entrepreneur named Ather Jameel who was passionate about Food and Taste. He left his job as an IT Manager and started working persuasively towards his passion and love for Food.'),
                TextWidgetSimple(text: 'Taj Grill, I-Grill & Kabobs were some of the restaurants located in the different cities.'),
                TextWidgetSimple(text: 'Working towards his goals he has started with some different concept where he wants to bring cultural taste for the American citizens and serving the community with rich flavours of taste.'),
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
              "About Us",
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
