import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as https;
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../widgets/profile/profile_widget.dart';
import '../authentication screen/login_screen.dart';
import '../products categories screen/model/profile_model.dart';
import '../products categories screen/providers/product_categories_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Future<ProfileModel> fetchUserDetail() async {
  final response = await https.get(Uri.parse(
      'https://spiceshackus.com/wp-json/custom-plugin/login?username=$emailStateData&password=$passwordStateData'));

  if (response.statusCode == 200) {
    print(jsonDecode(response.body)["data"]["ID"]);
    return ProfileModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

String _emailProfile = "";

String get emailProfile => _emailProfile;

String _nameProfile = "";

String get nameProfile => _nameProfile;

class _ProfileScreenState extends State<ProfileScreen> {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      height: 40.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: GradientsConstants.blackGradient,
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/backgrounds/profle.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(.4),
                              Colors.black.withOpacity(.2),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
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
                                    "Account Details",
                                    style: AppTextStyle.spiceShackFonts(
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.silver,
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
                    Positioned(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 3.h,
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: Center(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 40.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                        Colors.black.withOpacity(.4),
                                        Colors.black.withOpacity(.5),
                                      ],
                                    ),
                                    border: Border.all(
                                        width: 2, color: MyColors.silver),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        if(valueProvider.stateEmail.isEmpty)...[
                                          ProfileWidgets(
                                              text1: "Name ",
                                              text2:valueProvider.temp!.nick),
                                          ProfileWidgets(
                                              text1: "Email ",
                                              text2: valueProvider.temp!.email,),
                                        ],
                                        if(valueProvider.stateEmail.isNotEmpty)...[
                                          ProfileWidgets(
                                              text1: "Name ",
                                              text2:valueProvider.stateName,),
                                          ProfileWidgets(
                                            text1: "Email ",
                                            text2: valueProvider.stateEmail,),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 10.h,
                                child: SizedBox(
                                  height: 20.h,
                                  width: 20.h,
                                  child: Lottie.asset(
                                      'assets/images/lottie/my.json'),
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
            ],
          ),
        ),
      );
    });
  }
}
