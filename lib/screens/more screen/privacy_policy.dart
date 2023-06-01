import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/widgets/text/heading.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../widgets/text/text.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

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

                TextHeading(text: 'Privacy Policy',),
                TextWidgetSimple(text: 'Spice Shack built the Spice Shack Us app as a Commercial app. This SERVICE is provided by Spice Shack and is intended for use as is.This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Spice Shack Us unless otherwise defined in this Privacy Policy.',),

                TextHeading(text: 'Information Collection and Use',),

                TextWidgetSimple(text: 'For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to location. The information that we request will be retained by us and used as described in this privacy policy.',),


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
              "Privacy Policy",
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
