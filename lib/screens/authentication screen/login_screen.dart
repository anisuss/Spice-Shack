import 'package:flutter/foundation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/resources/colors/colors_resources.dart';
import 'package:spice_shack/resources/colors/gradient_colors.dart';
import 'package:spice_shack/screens/authentication%20screen/forgot_password_screen.dart';
import 'package:spice_shack/screens/authentication%20screen/sign_up_screen.dart';

import '../../model/api data model/prdoucts_model.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';
import '../../widgets/navigation bar/navigation_bar_widget.dart';
import '../../utils/resources/toast_message.dart';
import '../coupons data/coupons_data_model.dart';
import '../products APi Functions/products_Functions_api.dart';
import '../products categories screen/model/api_data_model.dart';
import '../products categories screen/providers/product_categories_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String _emailStateData = "";

String get emailStateData => _emailStateData;

String _passwordStateData = "";

String get passwordStateData => _passwordStateData;

List _idList = [];
List get idList => _idList;
class _LoginScreenState extends State<LoginScreen> {
  set idList(List value) {
    _idList = value;
  }

  set emailStateData(String value) {
    _emailStateData = value;
  }

  set passwordStateData(String value) {
    _passwordStateData = value;
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void validatorLogin() {
    if (_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  var isLoading = false;

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (isValid!) {
      return;
    }
    _formKey.currentState?.save();
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
              Expanded(
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
                        MyText.logIn,
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
              ),
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Center(
                            child: Container(
                              color: Colors.transparent,
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: double.infinity,
                              child: Lottie.asset(
                                  'assets/images/lottie/forgotPassword.json'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: TextFormField(
                            style: TextStyle(color: MyColors.silver),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: MyColors.silver,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: MyColors.grey),
                              ),
                              hintText: MyText.email,
                              prefixIcon: Icon(
                                CupertinoIcons.mail,
                                color: MyColors.brown,
                              ),
                              hintStyle: TextStyle(color: MyColors.grey),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            onFieldSubmitted: (value) {
                              //Validator
                            },
                            validator: (value) {
                              if (value == null ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                return 'Enter a valid email!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: TextFormField(
                            style: TextStyle(color: MyColors.silver),
                            obscureText: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: MyColors.silver,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: MyColors.grey),
                              ),
                              hintText: MyText.password,
                              prefixIcon: Icon(
                                CupertinoIcons.lock_slash,
                                color: MyColors.brown,
                              ),
                              hintStyle: TextStyle(color: MyColors.grey),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: passwordController,
                            onFieldSubmitted: (value) {
                              //Validator
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Enter a valid password!';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Consumer<ProductCategoriesProvider>(
                          builder: (context, valueProvider, child) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60.0, vertical: 20),
                              child: InkWell(
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  _submit();
                                  if (emailController.text.toString() != "" &&
                                      passwordController.text.isNotEmpty && isEmailValid(emailController.text)&&
                                      emailController.text.isNotEmpty) {
                                    emailStateData =
                                        emailController.text.toString();
                                    passwordStateData =
                                        passwordController.text.toString();
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
                                    await valueProvider.loginWithApi();
                                    await valueProvider.fetchUserDetail();
                                    await valueProvider.loginDataFromApi();
                                    Navigator.pop(context);
                                    if (kDebugMode) {
                                      print("my log = ${valueProvider.log}");
                                    }

                                    if (valueProvider.log == 200) {
                                      if (kDebugMode) {
                                        print("my log = ${valueProvider.log}");
                                      }
                                      //valueProvider.temp;
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                                        return const NavigationBarWidget();
                                      }), (r){
                                        return false;
                                      });
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          "email", emailController.text);
                                      prefs.setString(
                                          "password", passwordController.text);
                                      ToastMessage()
                                          .toastMessage("Login Successfully");
                                    }

                                    //Categories products list
                                    List<ProductListModel> productData =
                                        await ProductsFunctionsApi()
                                            .getListOfProductsByCategories();
                                    valueProvider
                                        .updateDataProductCategoriesListModel(
                                            productData);

                                    /*//Coupons list
                                    List<CouponsModel> coupons =
                                    await ProductsFunctionsApi()
                                        .getCouponsData();
                                    valueProvider
                                        .updateCoupon(
                                        coupons);*/


                                    //Categories list
                                    List<CartItemModel> myData =
                                        await ProductsFunctionsApi()
                                            .getCategories();
                                    valueProvider
                                        .updateDataProductCategoriesModel(
                                            myData);

                                    //Catering list
                                    List<CartItemModel> myCatering =
                                        await ProductsFunctionsApi()
                                            .getCatering();
                                    valueProvider
                                        .updateDataCateringModel(myCatering);
                                  } else {
                                    if (kDebugMode) {
                                      print("Enter values");
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
                                      MyText.logIn,
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
                            );
                          },
                        ),
                        Consumer<ProductCategoriesProvider>(
                            builder: (context, valueProvider, child) {
                          if (valueProvider.loginLoader == 1) {
                            return const CircularProgressIndicator();
                          }
                          return const Text("");
                        }),
                        /*InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: AutoSizeText(
                            MyText.forgotPassword,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.spiceShackFonts(
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 18.0,
                            horizontal: 8.0,
                          ),
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: MyText.notHaveAnAccount,
                              style: AppTextStyle.spiceShackFonts(
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.silver,
                                ),
                              ),
                              children: [
                                TextSpan(
                                  text: MyText.signup,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen(),
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
  }
}
