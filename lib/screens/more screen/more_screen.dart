import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/screens/more%20screen/about_us.dart';
import 'package:spice_shack/screens/more%20screen/privacy_policy.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';
import '../../widgets/buttons/legal_buttons_widget.dart';
import '../../widgets/navigation bar/navigation_bar_widget.dart';
import '../products categories screen/providers/product_categories_provider.dart';
import 'contact.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductCategoriesProvider>(
        builder: (context, valueProvider, child) {
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
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                  //   child: Card(
                  //     color: Colors.transparent,
                  //     shape: BeveledRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Container(
                  //         height: MediaQuery.of(context).size.height * 0.05,
                  //         width: double.infinity,
                  //         decoration: BoxDecoration(
                  //           border: Border.all(color: MyColors.silver),
                  //           gradient: GradientsConstants.blackGradient,
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(
                  //               vertical: 8.0, horizontal: 15.0),
                  //           child: AutoSizeText(
                  //             MyText.other,
                  //             textAlign: TextAlign.start,
                  //             style: AppTextStyle.spiceShackFonts(
                  //               style: TextStyle(
                  //                 fontSize: 20,
                  //                 fontWeight: FontWeight.w600,
                  //                 color: MyColors.white,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: LegalScreenWidgets(
                      onTap: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutUsScreen(),),
                      );},
                      text: MyText.aboutUs,
                    ),
                  ),
                  // LegalScreenWidgets(
                  //   onTap: () {},
                  //   text: MyText.helpFaqs,
                  // ),
                  LegalScreenWidgets(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactUsScreen(),),
                      );
                    },
                    text: MyText.contactUs,
                  ),
                  LegalScreenWidgets(
                    onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen(),),
                    );},
                    text: MyText.privacy,
                  ),


                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Lottie.asset(
                        'assets/images/lottie/mores.json'),
                  ),



                  // LegalScreenWidgets(
                  //   onTap: () {},
                  //   text: MyText.termsConditions,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: SizedBox(
                  //     height: MediaQuery.of(context).size.height * 0.06,
                  //     width: MediaQuery.of(context).size.width * 0.6,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Image.asset('assets/images/logo/facebook-icon.png'),
                  //         Image.asset('assets/images/logo/instagram-icon.png'),
                  //         Image.asset('assets/images/logo/twitter-icon.png'),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
    });
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NavigationBarWidget(),
                  ),
                );
              },
              icon: Icon(
                Icons.home_filled,
                size: 3.h,
                color: MyColors.silver,
              ),
            ),
          ),
          Center(
            child: AutoSizeText(
              MyText.more,
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

  Widget checkStatus(bool val) {
    return const SizedBox();
  }
}
