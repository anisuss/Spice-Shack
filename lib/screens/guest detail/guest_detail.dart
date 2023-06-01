import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:spice_shack/screens/guest%20detail/guestCheckoutScreen.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';
import '../../utils/resources/toast_message.dart';
import '../../widgets/input text fields/input_text_field.dart';
import '../products categories screen/providers/product_categories_provider.dart';

class GuestDetailScreen extends StatefulWidget {
  const GuestDetailScreen({Key? key}) : super(key: key);

  @override
  State<GuestDetailScreen> createState() => _GuestDetailScreenState();
}
String _firstnameSignupGuest = "";

String get firstnameSignupGuest => _firstnameSignupGuest;

String _lastNameSignupGuest = "";

String get lastNameSignupGuest => _lastNameSignupGuest;

String _userNameSignupGuest = "";

String get userNameSignupGuest => _userNameSignupGuest;

String _emailSignupGuest = "";

String get emailSignupGuest => _emailSignupGuest;


class _GuestDetailScreenState extends State<GuestDetailScreen> {
  set firstnameSignupGuest(String value) {
    _firstnameSignupGuest = value;
  }

  set lastNameSignupGuest(String value) {
    _lastNameSignupGuest = value;
  }

  set emailSignupGuest(String value) {
    _emailSignupGuest = value;
  }

  set userNameSignupGuest(String value) {
    _userNameSignupGuest = value;
  }
  bool isEmailValid(String email) {
    // Regular expression to validate email format
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Check if the email matches the regular expression
    return emailRegex.hasMatch(email);
  }
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
                child: Column(
                  children: [
                    appBarWidget(context),
                    Expanded(
                      flex: 10,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Center(
                                child: Container(
                                  color: Colors.transparent,
                                  height:
                                  MediaQuery.of(context).size.height * 0.2,
                                  width: double.infinity,
                                  child: Lottie.asset(
                                      'assets/images/lottie/forgotPassword.json'),
                                ),
                              ),
                            ),
                            //Text Fields
                            InputTextField(
                              hintText: MyText.fName,
                              textController: valueProvider.guestF,
                              prefixIcon: Icon(
                                CupertinoIcons.pencil_ellipsis_rectangle,
                                color: MyColors.brown,
                              ),
                              obscure: false,
                              textInputType: TextInputType.text,
                              validator: (inputValue) {
                                if (inputValue.isEmpty) {
                                  return "Please Enter Email!";
                                } else {
                                  return null;
                                }
                              },
                            ),

                            InputTextField(
                              hintText: MyText.lName,
                              textController: valueProvider.guestL,
                              prefixIcon: Icon(
                                CupertinoIcons.pencil_ellipsis_rectangle,
                                color: MyColors.brown,
                              ),
                              obscure: false,
                              textInputType: TextInputType.text,
                              validator: (inputValue) {
                                if (inputValue.isEmpty) {
                                  return "Please Enter Email!";
                                } else {
                                  return null;
                                }
                              },
                            ),

                            InputTextField(
                              hintText: MyText.email,
                              textController: valueProvider.guestEmail,
                              prefixIcon: Icon(
                                CupertinoIcons.mail,
                                color: MyColors.brown,
                              ),
                              obscure: false,
                              textInputType: TextInputType.emailAddress,
                              validator: (inputValue) {
                                if (inputValue.isEmpty) {
                                  return "Please Enter Email!";
                                } else {
                                  return null;
                                }
                              },
                            ),

                            //Username Text Field
                            InputTextField(
                              hintText: MyText.phoneNumber,
                              textController: valueProvider.guestPhone,
                              prefixIcon: Icon(
                                CupertinoIcons.phone,
                                color: MyColors.brown,
                              ),
                              obscure: false,
                              textInputType: TextInputType.number,
                              validator: (inputValue) {
                                if (inputValue.isEmpty || inputValue.length < 8) {
                                  ToastMessage().toastMessage("message");
                                  return "Password Must Contain at least 8 character!";
                                } else {
                                  return null;
                                }
                              },
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60.0, vertical: 20),
                              child: InkWell(
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (valueProvider.guestF.text.isNotEmpty &&
                                      valueProvider.guestL.text.isNotEmpty &&
                                      valueProvider.guestEmail.text.isNotEmpty && isEmailValid(valueProvider.guestEmail.text) &&
                                      valueProvider.guestPhone.text.isNotEmpty) {
                                    firstnameSignupGuest = valueProvider.guestF.text;
                                    lastNameSignupGuest = valueProvider.guestL.text;
                                    emailSignupGuest = valueProvider.guestEmail.text;
                                    userNameSignupGuest = valueProvider.guestPhone.text;
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const GuestCheckOutScreen(),
                                      ),
                                    );
                                  }else{
                                    Fluttertoast.showToast(
                                      msg: 'Please enter all details',
                                      toastLength: Toast.LENGTH_SHORT, // Duration for which the toast message should be displayed
                                      gravity: ToastGravity.BOTTOM, // Position of the toast message on the screen
                                      backgroundColor: Colors.black45, // Background color of the toast message
                                      textColor: Colors.white, // Text color of the toast message
                                      fontSize: 16.0, // Font size of the toast message
                                    );

                                  }
                                },
                                child: Container(
                                  height:
                                  MediaQuery.of(context).size.height * 0.05,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: GradientsConstants.redGradient,
                                  ),
                                  child: Center(
                                    child: AutoSizeText(
                                      "Proceed to checkout",
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
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget appBarWidget(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: GradientsConstants.redGradient,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              "Enter personal detail",
              textAlign: TextAlign.start,
              style: AppTextStyle.spiceShackFonts(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: MyColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
