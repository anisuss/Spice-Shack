import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';
import '../delivery screen/delivery_screen.dart';
import '../products categories screen/providers/product_categories_provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool showButtons = true;

  @override
  void initState() {
    super.initState();
    _checkSharedPrefsData();
  }

  Future<void> _checkSharedPrefsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool sharedData = prefs.getBool('sharedData') ?? false;
    if (sharedData) {
      setState(() {
        showButtons = false;
      });
    }
  }

  Future<void> _saveToSharedPrefs() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // // await prefs.setBool('sharedData', true);
    //
    // print("PKPKPKPKPKPKPKPKPKPKPKP");
    // print(prefs.getBool('sharedData'));
    setState(() {
      showButtons = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    bool serviceEnabled;
    LocationPermission permission;
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            MyText.dots,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.spiceShackFonts(
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Image.asset(
                                  'assets/images/logo/pan-icon.png'),
                            ),
                          ),
                          AutoSizeText(
                            MyText.dots,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.spiceShackFonts(
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AutoSizeText(
                      MyText.startYourOrder,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.spiceShackFonts(
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                    AutoSizeText(
                      MyText.selectYourOrderOption,
                      style: AppTextStyle.spiceShackFonts(
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Lottie.asset('assets/images/lottie/person.json'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // showButtons ?

                    Padding(
                      padding: const EdgeInsets.only(
                          right: 60.0, left: 60.0, bottom: 20),
                      child: InkWell(
                        onTap: () async {
                          permission = await Geolocator.checkPermission();
                          if(permission == LocationPermission.denied)
                            {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Location Permission'),
                                  content: const Text('We need your location permission to get food delivered to your doorstep. Tap on “ok” to move ahead.'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Don\'t Allow'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Ok'),
                                      onPressed: () async {
                                        valueProvider.loadData();
                                        // _saveToSharedPrefs();
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        // await prefs.setBool('sharedData', true);


                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const DeliveryScreen(),
                                          ),
                                        );
                                        valueProvider.position = await valueProvider.getGeoLocationPosition(context);
                                        valueProvider.location = 'Lat: ${valueProvider.position.latitude} , Long: ${valueProvider.position.longitude}';
                                        valueProvider
                                            .getAddressFromLatLong(valueProvider.position);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }else{
                            valueProvider.loadData();
                            // _saveToSharedPrefs();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            // await prefs.setBool('sharedData', true);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DeliveryScreen(),
                              ),
                            );
                            valueProvider.position = await valueProvider.getGeoLocationPosition(context);
                            valueProvider.location = 'Lat: ${valueProvider.position.latitude} , Long: ${valueProvider.position.longitude}';
                            valueProvider
                                .getAddressFromLatLong(valueProvider.position);
                          }
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
                              MyText.delivery,
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

                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       right: 60.0, left: 60.0, bottom: 20),
                    //   child: InkWell(
                    //     onTap: () async {
                    //       valueProvider.loadData();
                    //
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const DeliveryScreen(),
                    //         ),
                    //       );
                    //       valueProvider.position =
                    //       await valueProvider.getGeoLocationPosition(context);
                    //       valueProvider.location =
                    //       'Lat: ${valueProvider.position.latitude} , Long: ${valueProvider.position.longitude}';
                    //       valueProvider
                    //           .getAddressFromLatLong(valueProvider.position);
                    //
                    //     },
                    //     child: Container(
                    //       height: MediaQuery.of(context).size.height * 0.05,
                    //       width: double.infinity,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(20),
                    //         gradient: GradientsConstants.redGradient,
                    //       ),
                    //       child: Center(
                    //         child: AutoSizeText(
                    //           MyText.delivery,
                    //           textAlign: TextAlign.center,
                    //           style: AppTextStyle.spiceShackFonts(
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w800,
                    //               color: MyColors.white,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 60.0, left: 60.0, bottom: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: GradientsConstants.blackGradient,
                            border: Border.all(
                              width: 1.0,
                              color: MyColors.silver,
                            ),
                          ),
                          child: Center(
                            child: AutoSizeText(
                              "Return to Back",
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
      );
    });
  }
}
