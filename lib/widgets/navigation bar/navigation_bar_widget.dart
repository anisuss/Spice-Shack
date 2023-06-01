import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:spice_shack/cattering%20screen/screen/cattering_screen.dart';
import 'package:spice_shack/screens/more%20screen/more_screen.dart';
import 'package:spice_shack/screens/resturants%20screen/resturants_screen.dart';
import '../../cattering screen/main screen/main_catering_screen.dart';
import '../../del/del.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';
import '../../screens/gift card screen/gift card.dart';
import '../../screens/products categories screen/product categories/categories_screen.dart';
import '../../screens/products categories screen/providers/product_categories_provider.dart';
import 'navigation_bar_provider.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({Key? key}) : super(key: key);

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {


  final screens = [
     const ProductCategoriesScreen(),
    const MainCateringScreen(),
    // const CateringScreen(),
    const GiftCardScreen(),
    // MyHomePage(),
    const RestaurantScreen(),
    const MoreScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    //provider instance
    final navigationBar = Provider.of<ProductCategoriesProvider>(context, listen: true);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: screens[navigationBar.selectedIndexByNav],
      bottomNavigationBar: DotNavigationBar(
        currentIndex: navigationBar.selectedIndexByNav,
        backgroundColor: Colors.white70,
        curve: Curves.easeInQuad,
        dotIndicatorColor: Colors.transparent,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.red,
        onTap: navigationBar.updateIndexNavBarBy,
        items: [
          DotNavigationBarItem(
            icon: const Icon(Iconsax.home),
          ),
          DotNavigationBarItem(
            icon: const Icon(Iconsax.shop),
          ),
          DotNavigationBarItem(
            icon: const Icon(
              Iconsax.gift,
            ),
          ),
          DotNavigationBarItem(
            icon: const Icon(Iconsax.location),
          ),
          DotNavigationBarItem(
            icon: const Icon(
              Iconsax.more,
            ),
          ),
        ],
      ),
    );
  }
}
