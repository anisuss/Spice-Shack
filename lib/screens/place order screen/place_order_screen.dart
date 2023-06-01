import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/widgets/navigation%20bar/navigation_bar_widget.dart';
import '../../cart data/database/db_helper.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../categories list screen/model/db_helper_categories.dart';
import '../products categories screen/providers/product_categories_provider.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  DBHelper dbHelper = DBHelper();
  DBHelperStatic dbHelper1 = DBHelperStatic();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ProductCategoriesProvider>(context);

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Image.asset('assets/images/logo/spice-logo.png'),
              ),
              if(cart.orderId != null)...[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 28.0.sp,horizontal: 58.0.sp),
                    child: Lottie.asset('assets/images/lottie/placeOrder.json'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: AutoSizeText(
                      "Your Order has been placed 😃",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.spiceShackFonts(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: AutoSizeText(
                      "Your Order Id is ${cart.orderId}",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.spiceShackFonts(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
              ]else if( cart.orderId == null)...[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 28.0.sp,horizontal: 58.0.sp),
                  child: Lottie.asset('assets/images/lottie/placeOrder.json'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.0),
                  child: CircularProgressIndicator(),
                  // child: AutoSizeText(
                  //   "Unfortunately Order was not place at this moment! ",
                  //   textAlign: TextAlign.center,
                  //   style: AppTextStyle.spiceShackFonts(
                  //     style: TextStyle(
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w800,
                  //       color: MyColors.white,
                  //     ),
                  //   ),
                  // ),
                ),
              ]else...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 48.0, horizontal: 20.0),
                  child: SizedBox(
                    height: 40.h,
                    width: 40.h,
                    child: Lottie.asset('assets/images/lottie/loader.json'),
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: GradientsConstants.redGradient,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(width: 1, color: MyColors.silver),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                    ),
                    child: TextButton(
                      onPressed: () async {
                        dbHelper!.dropTableIfExistsThenReCreate();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setInt("item_quantity", 0);
                        prefs.setInt('cart_items', 0);
                        prefs.setDouble('total_price', 0.0);
                        dbHelper1!.dropTableIfExistsThenReCreate();

                        setState(() {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavigationBarWidget(),
                            ),
                          );
                          cart.orderId=int.parse('');
                        });
                      },
                      child: AutoSizeText(
                        "Home",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.spiceShackFonts(
                          style: TextStyle(
                            fontSize: 18,
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
    );
  }
}
