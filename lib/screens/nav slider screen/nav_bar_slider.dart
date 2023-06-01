import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spice_shack/cattering%20screen/screen/cattering_screen.dart';
import 'package:spice_shack/resources/colors/gradient_colors.dart';
import 'package:spice_shack/screens/home%20screen/home_screen.dart';
import 'package:spice_shack/screens/menu%20screen/menu_screen.dart';
import 'package:spice_shack/screens/more%20screen/more_screen.dart';
import 'package:spice_shack/screens/profile%20screen/profile_screen.dart';
import 'package:spice_shack/screens/resturants%20screen/resturants_screen.dart';
import '../../cart data/database/db_helper.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';
import '../cart screen/cart_screen.dart';
import '../products categories screen/providers/product_categories_provider.dart';

class NavBarSlider extends StatefulWidget {
  const NavBarSlider({Key? key}) : super(key: key);

  @override
  State<NavBarSlider> createState() => _NavBarSliderState();
}

class _NavBarSliderState extends State<NavBarSlider> {
  DBHelper dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductCategoriesProvider>(
        builder: (context, valueProvider, child) {
      return SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(0),
            ),
          ),
          child: Drawer(
            backgroundColor: MyColors.greyLight,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(0),
              ),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: double.infinity,
              child: Column(
                children: [
                  if(valueProvider.stateEmail.isNotEmpty)...[
                    UserAccountsDrawerHeader(
                      accountName: AutoSizeText(
                        valueProvider.stateName,
                        textAlign: TextAlign.start,
                        style: AppTextStyle.spiceShackFonts(
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      accountEmail: AutoSizeText(
                        valueProvider.stateEmail,
                        textAlign: TextAlign.start,
                        style: AppTextStyle.spiceShackFonts(
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      currentAccountPicture: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Lottie.asset('assets/images/lottie/home.json'),
                      ),
                      decoration: BoxDecoration(
                        gradient: GradientsConstants.redGradient,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(0),
                        ),
                        /*image: const DecorationImage(
                      image: AssetImage('assets/images/backgrounds/check.jpg'),
                      fit: BoxFit.cover,
                    ),*/
                      ),
                    ),
                  ],
                  if(valueProvider.stateEmail.isEmpty)...[
                    UserAccountsDrawerHeader(
                      accountName: AutoSizeText(
                        valueProvider.temp!.nick,
                        textAlign: TextAlign.start,
                        style: AppTextStyle.spiceShackFonts(
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      accountEmail: AutoSizeText(
                        valueProvider.temp!.email,
                        //valueProvider.encodedMapEmail,
                        textAlign: TextAlign.start,
                        style: AppTextStyle.spiceShackFonts(
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      currentAccountPicture: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Lottie.asset('assets/images/lottie/home.json'),
                      ),
                      decoration: BoxDecoration(
                        gradient: GradientsConstants.redGradient,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(0),
                        ),
                      ),
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MenuScreen(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.menu_open_rounded,
                          color: MyColors.brown,
                        ),
                        title: AutoSizeText(
                          MyText.menu,
                          textAlign: TextAlign.start,
                          style: AppTextStyle.spiceShackFonts(
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: MyColors.brown,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RestaurantScreen(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.location_history,
                          color: MyColors.brown,
                        ),
                        title: AutoSizeText(
                          MyText.location,
                          textAlign: TextAlign.start,
                          style: AppTextStyle.spiceShackFonts(
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: MyColors.brown,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.shopping_cart_outlined,
                          color: MyColors.brown,
                        ),
                        title: AutoSizeText(
                          MyText.cart,
                          textAlign: TextAlign.start,
                          style: AppTextStyle.spiceShackFonts(
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: MyColors.brown,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CateringScreen(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.local_mall_outlined,
                          color: MyColors.brown,
                        ),
                        title: AutoSizeText(
                          "Catering",
                          textAlign: TextAlign.start,
                          style: AppTextStyle.spiceShackFonts(
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: MyColors.brown,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MoreScreen()));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.more_outlined,
                          color: MyColors.brown,
                        ),
                        title: AutoSizeText(
                          MyText.more,
                          textAlign: TextAlign.start,
                          style: AppTextStyle.spiceShackFonts(
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: MyColors.brown,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  checkStatus(valueProvider.isLogin),
                  if (valueProvider.isLogin == true ||
                      valueProvider.log == 200) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                            color: MyColors.brown,
                          ),
                          title: AutoSizeText(
                            MyText.profile,
                            textAlign: TextAlign.start,
                            style: AppTextStyle.spiceShackFonts(
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: MyColors.brown,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () async {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                            return const HomeScreen();
                          }), (r){
                            return false;
                          });
                          dbHelper!.dropTableIfExistsThenReCreate();
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("email", "");
                          prefs.setString("password", "");
                          prefs.setInt('cart_item', 0);
                          prefs.setDouble('total_price', 0);

                          ProductCategoriesProvider.clearSharedPref();
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.logout_rounded,
                            color: MyColors.red1,
                          ),
                          title: AutoSizeText(
                            MyText.logOut,
                            textAlign: TextAlign.start,
                            style: AppTextStyle.spiceShackFonts(
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: MyColors.red1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]else...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () async {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                            return const HomeScreen();
                          }), (r){
                            return false;
                          });
                          dbHelper!.dropTableIfExistsThenReCreate();
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          prefs.setString("email", "");
                          prefs.setString("password", "");
                          prefs.setInt('cart_item', 0);
                          prefs.setDouble('total_price', 0);
                          ProductCategoriesProvider.clearSharedPref();
                          valueProvider.phoneControll.clear();
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.logout_rounded,
                            color: MyColors.red1,
                          ),
                          title: AutoSizeText(
                            MyText.signUpLogIn,
                            textAlign: TextAlign.start,
                            style: AppTextStyle.spiceShackFonts(
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: MyColors.red1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Lottie.asset('assets/images/lottie/drawer.json'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget checkStatus(bool val) {
    return const SizedBox();
  }
}
