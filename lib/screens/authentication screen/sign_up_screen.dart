import 'package:flutter/foundation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/resources/colors/colors_resources.dart';
import 'package:spice_shack/resources/colors/gradient_colors.dart';
import 'package:spice_shack/screens/authentication%20screen/login_screen.dart';
import 'package:spice_shack/spice%20shack%20usable/api%20model/customer_model.dart';
import 'package:spice_shack/spice%20shack%20usable/utitlies/api_services.dart';
import 'package:spice_shack/widgets/input%20text%20fields/input_text_field.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';
import '../../utils/resources/toast_message.dart';
import '../products categories screen/providers/product_categories_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

String _firstnameSignup = "";

String get firstnameSignup => _firstnameSignup;

String _lastNameSignup = "";

String get lastNameSignup => _lastNameSignup;

String _userNameSignup = "";

String get userNameSignup => _userNameSignup;

String _emailSignup = "";

String get emailSignup => _emailSignup;

String _passwordSignup = "";

String get passwordSignup => _passwordSignup;

class _SignUpScreenState extends State<SignUpScreen> {
  set firstnameSignup(String value) {
    _firstnameSignup = value;
  }

  set lastNameSignup(String value) {
    _lastNameSignup = value;
  }

  set emailSignup(String value) {
    _emailSignup = value;
  }

  set userNameSignup(String value) {
    _userNameSignup = value;
  }

  set passwordSignup(String value) {
    _passwordSignup = value;
  }

  late APIService apiService;
  late CustomerModel customerModel;
  bool hidePassword = true;
  bool isApiCallProcess = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final userNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmailValid(String email) {
      // Regular expression to validate email format
      final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

      // Check if the email matches the regular expression
      return emailRegex.hasMatch(email);
    }
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
                    child: Form(
                      key: _formKey,
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
                            textController: fNameController,
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
                            textController: lNameController,
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
                            textController: emailController,
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
                            hintText: MyText.username,
                            textController: userNameController,
                            prefixIcon: Icon(
                              CupertinoIcons.person,
                              color: MyColors.brown,
                            ),
                            obscure: false,
                            textInputType: TextInputType.text,
                            validator: (inputValue) {
                              if (inputValue.isEmpty || inputValue.length < 8) {
                                ToastMessage().toastMessage("message");
                                return "Password Must Contain at least 8 character!";
                              } else {
                                return null;
                              }
                            },
                          ),

                          //Password Text Field
                          InputTextField(
                            hintText: MyText.password,
                            textController: passwordController,
                            prefixIcon: Icon(
                              CupertinoIcons.lock_slash,
                              color: MyColors.brown,
                            ),
                            obscure: true,
                            textInputType: TextInputType.text,
                            validator: (inputValue) {
                              if (inputValue.isEmpty || inputValue.length < 6) {
                                return "Password Must Contain at least 6 character!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: AutoSizeText(
                              MyText.passwordText,
                              textAlign: TextAlign.start,
                              style: AppTextStyle.spiceShackFonts(
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.grey,
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 18.0,
                              horizontal: 8.0,
                            ),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: MyText.haveAnAccount,
                                style: AppTextStyle.spiceShackFonts(
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: MyColors.silver,
                                  ),
                                ),
                                children: [
                                  TextSpan(
                                    text: MyText.sign,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen(),
                                          ),
                                        );
                                      },
                                    style: AppTextStyle.spliceSans(
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: MyColors.yellow,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60.0, vertical: 20),
                            child: InkWell(
                              onTap: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (fNameController.text.isNotEmpty &&
                                    lNameController.text.isNotEmpty &&
                                    userNameController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty && isEmailValid(emailController.text) &&
                                    emailController.text.isNotEmpty) {
                                  firstnameSignup =
                                      fNameController.text.toString();
                                  lastNameSignup =
                                      lNameController.text.toString();
                                  userNameSignup =
                                      userNameController.text.toString();
                                  emailSignup = emailController.text.toString();
                                  passwordSignup =
                                      passwordController.text.toString();
                                  //makePostRequest();
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: SizedBox(
                                            height: 30.h,
                                            width: 30.h,
                                            child: Lottie.asset(
                                                'assets/images/lottie/loader.json'),
                                          ),
                                        );
                                      });
                                  await valueProvider.signUpWithApi();
                                  Navigator.pop(context);
                                  if (valueProvider.logSignup == 200 ||
                                      valueProvider.logSignup == 201) {
                                    if (kDebugMode) {
                                      print(
                                          "SignUp log = ${valueProvider.loadingSignUp}");
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const LoginScreen(),
                                      ),
                                    );
                                    // SharedPreferences prefs = await SharedPreferences.getInstance();
                                    // prefs.setString("email", emailController.text);
                                    // prefs.setString("password", passwordController.text);
                                    ToastMessage()
                                        .toastMessage("SignUp Successfully");
                                  }
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
                        ],
                      ),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.highlight_remove_rounded,
                color: MyColors.white,
                size: MediaQuery.of(context).size.width * 0.08,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            AutoSizeText(
              MyText.signup,
              textAlign: TextAlign.start,
              style: AppTextStyle.spiceShackFonts(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: MyColors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
