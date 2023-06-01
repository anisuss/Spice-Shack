import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:spice_shack/screens/authentication%20screen/link_forgotPassword.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';
import '../../widgets/input text fields/input_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Top Text -- Forgot Your Password?
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 74),
                  child: Text(
                    "Forgot Your \nPassword?",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontStyle: FontStyle.normal,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),

                //Forgot Your Password? Code Bottom Text
                const Padding(
                  padding: EdgeInsets.only(left: 24, top: 5),
                  child: Text(
                    "Enter your registered email below to \nreceive password reset instruction",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),

                //Animated Image
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                      child: Lottie.asset(
                          'assets/images/lottie/forgotPassword.json'),
                    ),
                  ),
                ),

                //Email Text Field
                InputTextField(
                  hintText: MyText.email,
                  textController: _emailController,
                  prefixIcon: Icon(
                    CupertinoIcons.mail,
                    color: MyColors.silver,
                  ),
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Email!";
                    } else {
                      return null;
                    }
                  },
                ),

                //Send code Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60.0, vertical: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LinkForgotPassword(),
                        ),
                      );
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
                          "Send Resend Link",
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
          ),
        ),
      ),
    );
  }
}
