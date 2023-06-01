import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spice_shack/screens/authentication%20screen/sign_up_screen.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';
import '../products categories screen/product categories/categories_screen.dart';

class GetAheadScreen extends StatelessWidget {
  const GetAheadScreen({Key? key}) : super(key: key);

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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48.0,horizontal: 20.0),
                  child: AutoSizeText(
                    MyText.getHead,
                    textAlign: TextAlign.start,
                    style: AppTextStyle.spiceShackFonts(
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: MyColors.white,
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Lottie.asset('assets/images/lottie/bike.json'),
                  ),
                ),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60.0, vertical: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen(),),);
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
                              MyText.createAccount,
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 60.0,left: 60.0,bottom: 20),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductCategoriesScreen(),),);
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
                              MyText.startNewOrder,
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
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
