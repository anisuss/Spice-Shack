import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/cattering%20screen/ramadan/ramadan_categories.dart';
import 'package:spice_shack/cattering%20screen/ramadan/ramadan_model.dart';
import 'package:badges/src/badge.dart' as badge;

import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../screens/cart screen/cart_screen.dart';
import '../../screens/categories list screen/model/cartCategroiesModel.dart';
import '../../screens/categories list screen/model/db_helper_categories.dart';
import '../../screens/products categories screen/providers/product_categories_provider.dart';
import '../../widgets/box/box.dart';
import '../../widgets/box/button.dart';
import '../../widgets/box/checkBox.dart';

class RamadanBox4 extends StatefulWidget {
  final String nameTitle;
  final String image;
  final String price;
  final String id;

  const RamadanBox4(
      {super.key,
      required this.nameTitle,
      required this.image,
      required this.price,
      required this.id,
      });

  @override
  State<RamadanBox4> createState() => _RamadanBox4State();
}

class _RamadanBox4State extends State<RamadanBox4> {
  DBHelperStatic? dbHelper = DBHelperStatic();
  late CheckboxModel checkbox;

  double priceValue = 0.0;
  @override
  Widget build(BuildContext context) {
    final valueProvider =
        Provider.of<ProductCategoriesProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Container(
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
            children: [
              Stack(
                children: [
                  Container(
                    height: 30.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: GradientsConstants.blackGradient,
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/backgrounds/ramadan.jpg',
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
                                 widget.nameTitle,
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
                            Icons.backspace_outlined,
                            size: 3.h,
                            color: MyColors.silver,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartScreen(),
                              ),
                            );
                          },
                          child: badge.Badge(
                            badgeContent: Text(
                                valueProvider.getCounter().toString(),
                                style: const TextStyle(color: Colors.white)),
                            showBadge: true,
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 3.h,
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                // height: MediaQuery.of(context).size.height * 2.8,
                // width: double.infinity,
                //color: Colors.pink,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 30.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: MyColors.silver),
                                borderRadius: BorderRadius.circular(30),),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        colors: [
                                          Colors.white.withOpacity(.4),
                                          Colors.brown.withOpacity(.5),
                                        ],
                                      ),
                                    ),
                                  ),
                                  imageUrl: widget.image,
                                  fit: BoxFit.cover,
                                  key: UniqueKey(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
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
                                      widget.nameTitle,
                                      style: AppTextStyle.spiceShackFonts(
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.silver,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 38.0),
                              child: Container(
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
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if (valueProvider.isNaan ==
                                            false) ...[
                                          AutoSizeText(
                                            "Price \$ ${valueProvider.price.toStringAsFixed(2)}",
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.silver,
                                              ),
                                            ),
                                          ),
                                        ] else ...[
                                          AutoSizeText(
                                            "Price \$ ${priceValue.toStringAsFixed(2)}",
                                            // "Price \$ ${double.parse(widget.price) + valueProvider.naanAddOns}",
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.silver,
                                              ),
                                            ),
                                          ),


                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  "Appetizers - I",
                                  textAlign: TextAlign.start,
                                  style: AppTextStyle.spiceShackFonts(
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.silver,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white70,
                                  ),
                                  child: Center(
                                    child: Consumer<ProductCategoriesProvider>(
                                      builder: (context, provider, child) {
                                        return Column(
                                          children: provider.checkboxes
                                              .asMap()
                                              .map(
                                                (index, checkbox) => MapEntry(
                                                  index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor:
                                                          Colors.red,
                                                      checkboxTheme:
                                                          CheckboxThemeData(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyle
                                                            .spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value:
                                                          checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider
                                                            .updateSelectedCheckbox(
                                                                index);
                                                        print(checkbox.label);
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30), // set the same border radius as the container
                                                      ),
                                                    ),
                                                  ),
                                                  // CheckboxListTile(
                                                  //   title: Text(checkbox.label),
                                                  //   value: checkbox.isSelected,
                                                  //   onChanged: (value) {
                                                  //     provider.updateSelectedCheckbox(index);
                                                  //   },
                                                  // ),
                                                ),
                                              )
                                              .values
                                              .toList(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  "Appetizers - II",
                                  textAlign: TextAlign.start,
                                  style: AppTextStyle.spiceShackFonts(
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.silver,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white70,
                                  ),
                                  child: Center(
                                    child: Consumer<ProductCategoriesProvider>(
                                      builder: (context, provider, child) {
                                        return Column(
                                          children: provider.checkApIIR4
                                              .asMap()
                                              .map(
                                                (index, checkbox) => MapEntry(
                                                  index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor:
                                                          Colors.red,
                                                      checkboxTheme:
                                                          CheckboxThemeData(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyle
                                                            .spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value:
                                                          checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider
                                                            .updateSelectedCheckApIIR4(
                                                                index);
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30), // set the same border radius as the container
                                                      ),
                                                    ),
                                                  ),
                                                  // CheckboxListTile(
                                                  //   title: Text(checkbox.label),
                                                  //   value: checkbox.isSelected,
                                                  //   onChanged: (value) {
                                                  //     provider.updateSelectedCheckbox(index);
                                                  //   },
                                                  // ),
                                                ),
                                              )
                                              .values
                                              .toList(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  "Entrée - I",
                                  textAlign: TextAlign.start,
                                  style: AppTextStyle.spiceShackFonts(
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.silver,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white70,
                                  ),
                                  child: Center(
                                    child: Consumer<ProductCategoriesProvider>(
                                      builder: (context, provider, child) {
                                        return Column(
                                          children: provider.checkE1R4
                                              .asMap()
                                              .map(
                                                (index, checkbox) => MapEntry(
                                                  index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor:
                                                          Colors.red,
                                                      checkboxTheme:
                                                          CheckboxThemeData(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyle
                                                            .spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value:
                                                          checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider
                                                            .updateSelectedCheckE1R4(
                                                                index);
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30), // set the same border radius as the container
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .values
                                              .toList(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  "Entrée - II",
                                  textAlign: TextAlign.start,
                                  style: AppTextStyle.spiceShackFonts(
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.silver,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white70,
                                  ),
                                  child: Center(
                                    child: Consumer<ProductCategoriesProvider>(
                                      builder: (context, provider, child) {
                                        return Column(
                                          children: provider.checkE2R4
                                              .asMap()
                                              .map(
                                                (index, checkbox) => MapEntry(
                                                  index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor:
                                                          Colors.red,
                                                      checkboxTheme:
                                                          CheckboxThemeData(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyle
                                                            .spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value:
                                                          checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider
                                                            .updateSelectedCheckE2R4(
                                                                index);
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30), // set the same border radius as the container
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .values
                                              .toList(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  "Entrée - III",
                                  textAlign: TextAlign.start,
                                  style: AppTextStyle.spiceShackFonts(
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.silver,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white70,
                                  ),
                                  child: Center(
                                    child: Consumer<ProductCategoriesProvider>(
                                      builder: (context, provider, child) {
                                        return Column(
                                          children: provider.checkE3R4
                                              .asMap()
                                              .map(
                                                (index, checkbox) => MapEntry(
                                                  index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor:
                                                          Colors.red,
                                                      checkboxTheme:
                                                          CheckboxThemeData(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyle
                                                            .spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value:
                                                          checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider
                                                            .updateSelectedCheckE3R4(
                                                                index);
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30), // set the same border radius as the container
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .values
                                              .toList(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  "Bread",
                                  textAlign: TextAlign.start,
                                  style: AppTextStyle.spiceShackFonts(
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.silver,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white70,
                                  ),
                                  child: Center(
                                    child: Consumer<ProductCategoriesProvider>(
                                      builder: (context, provider, child) {
                                        return Column(
                                          children: provider.checkBreadR4
                                              .asMap()
                                              .map(
                                                (index, checkbox) => MapEntry(
                                                  index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor:
                                                          Colors.red,
                                                      checkboxTheme:
                                                          CheckboxThemeData(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyle
                                                            .spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value:
                                                          checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider
                                                            .updateSelectedCheckBreadR4(
                                                                index);
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30), // set the same border radius as the container
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .values
                                              .toList(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  "Condiments - I",
                                  textAlign: TextAlign.start,
                                  style: AppTextStyle.spiceShackFonts(
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.silver,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white70,
                                  ),
                                  child: Center(
                                    child: Consumer<ProductCategoriesProvider>(
                                      builder: (context, provider, child) {
                                        return Column(
                                          children: provider.checkC1R4
                                              .asMap()
                                              .map(
                                                (index, checkbox) => MapEntry(
                                                  index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor:
                                                          Colors.red,
                                                      checkboxTheme:
                                                          CheckboxThemeData(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyle
                                                            .spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value:
                                                          checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider
                                                            .updateSelectedCheckC1R4(
                                                                index);
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30), // set the same border radius as the container
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .values
                                              .toList(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  "Condiments - II",
                                  textAlign: TextAlign.start,
                                  style: AppTextStyle.spiceShackFonts(
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.silver,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white70,
                                  ),
                                  child: Center(
                                    child: Consumer<ProductCategoriesProvider>(
                                      builder: (context, provider, child) {
                                        return Column(
                                          children: provider.checkC2R4
                                              .asMap()
                                              .map(
                                                (index, checkbox) => MapEntry(
                                                  index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor:
                                                          Colors.red,
                                                      checkboxTheme:
                                                          CheckboxThemeData(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyle
                                                            .spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value:
                                                          checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider
                                                            .updateSelectedCheckC2R4(
                                                                index);
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30), // set the same border radius as the container
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .values
                                              .toList(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  "Desserts",
                                  textAlign: TextAlign.start,
                                  style: AppTextStyle.spiceShackFonts(
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.silver,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white70,
                                  ),
                                  child: Center(
                                    child: Consumer<ProductCategoriesProvider>(
                                      builder: (context, provider, child) {
                                        return Column(
                                          children: provider.checkDessertsR4
                                              .asMap()
                                              .map(
                                                (index, checkbox) => MapEntry(
                                                  index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor:
                                                          Colors.red,
                                                      checkboxTheme:
                                                          CheckboxThemeData(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyle
                                                            .spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value:
                                                          checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider
                                                            .updateSelectedCheckDessertsR4(
                                                                index);
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30), // set the same border radius as the container
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .values
                                              .toList(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  "Add Ons",
                                  textAlign: TextAlign.start,
                                  style: AppTextStyle.spiceShackFonts(
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.silver,
                                    ),
                                  ),
                                ),
                              ),

                              Row(
                                children: [
                                  Expanded(
                                   flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          color: Colors.white70,
                                        ),
                                        child: Center(
                                          child: Consumer<
                                              ProductCategoriesProvider>(
                                              builder:
                                                  (context, provider, child) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: AutoSizeText(
                                                          "Plate, Spoon, Plate, Spoon (+\$${valueProvider.platesAddOns})",
                                                          textAlign: TextAlign.start,
                                                          style: AppTextStyle
                                                              .spiceShackFonts(
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              color: MyColors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: valueProvider
                                                                .decrementPlates,
                                                            icon: Icon(Icons.remove),
                                                          ),
                                                          Text(valueProvider
                                                              .counterPlatesAddOns
                                                              .toString()),
                                                          // Text("-"),
                                                          // if (valueProvider.isNaan ==
                                                          //     false) ...[
                                                          //   Text(
                                                          //       "${double.parse(widget.price)}"),
                                                          // ] else ...[
                                                          //   Text(
                                                          //       "${double.parse(widget.price) + valueProvider.naanAddOns}"),
                                                          // ],
                                                          IconButton(
                                                            onPressed:
                                                              valueProvider
                                                                  .incrementPlates,
                                                            icon: Icon(Icons.add),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Consumer<ProductCategoriesProvider>(
                                        builder: (context, provider, child) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                                color: valueProvider.isPlates
                                                    ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                              ),
                                              child: TextButton(
                                                onPressed: (){
                                                  valueProvider.togglePlates();
                                                  setState(() {
                                                    priceValue = (double.parse(widget.price) + valueProvider.platesAddOns);
                                                  });
                                                },
                                                child: Consumer<
                                                    ProductCategoriesProvider>(
                                                    builder:
                                                        (context, provider, child) {
                                                      return AutoSizeText(
                                                        valueProvider.isPlates ? "Added" : "Add",
                                                        textAlign: TextAlign.start,
                                                        style: AppTextStyle
                                                            .spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 10.sp,
                                                            fontWeight: FontWeight.w600,
                                                            color: valueProvider.isPlates ?  Colors.white : MyColors.black,
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          color: Colors.white70,
                                        ),
                                        child: Center(
                                          child: Consumer<
                                              ProductCategoriesProvider>(
                                              builder:
                                                  (context, provider, child) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: AutoSizeText(
                                                          "Bottled Water (+\$${valueProvider.bottleAddOns})",
                                                          textAlign: TextAlign.start,
                                                          style: AppTextStyle
                                                              .spiceShackFonts(
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              color: MyColors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: valueProvider
                                                                .decrementBottle,
                                                            icon: Icon(Icons.remove),
                                                          ),
                                                          Text(valueProvider
                                                              .counterBottleAddOns
                                                              .toString()),
                                                          // Text("-"),
                                                          // if (valueProvider.isNaan ==
                                                          //     false) ...[
                                                          //   Text(
                                                          //       "${double.parse(widget.price)}"),
                                                          // ] else ...[
                                                          //   Text(
                                                          //       "${double.parse(widget.price) + valueProvider.naanAddOns}"),
                                                          // ],
                                                          IconButton(
                                                            onPressed:
                                                              valueProvider
                                                                  .incrementBottle,
                                                            icon: Icon(Icons.add),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                  flex: 1,
                                    child: Consumer<ProductCategoriesProvider>(
                                      builder: (context, provider, child) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              color: valueProvider.isBottle
                                                  ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                            ),
                                            child: TextButton(
                                              onPressed: (){
                                                valueProvider.toggleBottle();
                                                setState(() {
                                                  priceValue = (double.parse(widget.price) + valueProvider.bottleAddOns);
                                                });
                                              },
                                              child: Consumer<
                                                  ProductCategoriesProvider>(
                                                  builder:
                                                      (context, provider, child) {
                                                    return AutoSizeText(
                                                      valueProvider.isBottle ? "Added" : "Add",
                                                      textAlign: TextAlign.start,
                                                      style: AppTextStyle
                                                          .spiceShackFonts(
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: valueProvider.isBottle ?  Colors.white : MyColors.black,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        );
                                      }),),
                                ],
                              ),


                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          color: Colors.white70,
                                        ),
                                        child: Center(
                                          child: Consumer<
                                              ProductCategoriesProvider>(
                                              builder:
                                                  (context, provider, child) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: AutoSizeText(
                                                          "Mango Juice (+\$${valueProvider.mangoAddOns})",
                                                          textAlign: TextAlign.start,
                                                          style: AppTextStyle
                                                              .spiceShackFonts(
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              color: MyColors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: valueProvider
                                                                .decrementMango,
                                                            icon: Icon(Icons.remove),
                                                          ),
                                                          Text(valueProvider
                                                              .counterMangoAddOns
                                                              .toString()),
                                                          // Text("-"),
                                                          // if (valueProvider.isNaan ==
                                                          //     false) ...[
                                                          //   Text(
                                                          //       "${double.parse(widget.price)}"),
                                                          // ] else ...[
                                                          //   Text(
                                                          //       "${double.parse(widget.price) + valueProvider.naanAddOns}"),
                                                          // ],
                                                          IconButton(
                                                            onPressed:
                                                              valueProvider
                                                                  .incrementMango,
                                                            icon: Icon(Icons.add),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Consumer<ProductCategoriesProvider>(
                                      builder: (context, provider, child) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              color: valueProvider.isMango
                                                  ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                            ),
                                            child: TextButton(
                                              onPressed: (){
                                                valueProvider.toggleMango();
                                                setState(() {
                                                  priceValue = (double.parse(widget.price) + valueProvider.mangoAddOns);
                                                });
                                              },
                                              child: Consumer<
                                                  ProductCategoriesProvider>(
                                                  builder:
                                                      (context, provider, child) {
                                                    return AutoSizeText(
                                                      valueProvider.isMango ? "Added" : "Add",
                                                      textAlign: TextAlign.start,
                                                      style: AppTextStyle
                                                          .spiceShackFonts(
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: valueProvider.isMango ?  Colors.white : MyColors.black,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        );
                                      }),),
                                ],
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white70,
                                        ),
                                        child: Center(
                                          child: Consumer<
                                                  ProductCategoriesProvider>(
                                              builder:
                                                  (context, provider, child) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: AutoSizeText(
                                                      "Naan (+\$${valueProvider.naanAddOns.toString()})",
                                                      textAlign: TextAlign.start,
                                                      style: AppTextStyle
                                                          .spiceShackFonts(
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: MyColors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: valueProvider
                                                            .decrement,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterAddOns
                                                          .toString()),
                                                      // Text("-"),
                                                      // if (valueProvider.isNaan ==
                                                      //     false) ...[
                                                      //   Text(
                                                      //       "${double.parse(widget.price)}"),
                                                      // ] else ...[
                                                      //   Text(
                                                      //       "${double.parse(widget.price) + valueProvider.naanAddOns}"),
                                                      // ],
                                                      IconButton(
                                                        onPressed: () {
                                                          valueProvider
                                                              .increment();
                                                        },
                                                        icon: Icon(Icons.add),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                  flex: 1,
                                    child: Consumer<ProductCategoriesProvider>(
                                      builder: (context, provider, child) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              color: valueProvider.isNaan
                                                  ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                            ),
                                            child: TextButton(
                                              onPressed: (){
                                                valueProvider.toggleNaan();
                                                setState(() {
                                                  priceValue = (double.parse(widget.price) + valueProvider.naanAddOns + (valueProvider.isMango? 10 : 0));
                                                });
                                              },
                                              child: Consumer<
                                                  ProductCategoriesProvider>(
                                                  builder:
                                                      (context, provider, child) {
                                                    return AutoSizeText(
                                                      valueProvider.isNaan ? "Added" : "Add",
                                                      textAlign: TextAlign.start,
                                                      style: AppTextStyle
                                                          .spiceShackFonts(
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: valueProvider.isNaan ?  Colors.white : MyColors.black,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        );
                                      }),),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      ButtonToBuy(
                        onTap: () {

                          dbHelper!.insert(
                            ProductModel(
                              id: 4,
                              productId: widget.id,
                              name: widget.nameTitle,
                              initialPrice: valueProvider.price,
                              productPrice: valueProvider.price,
                              quantity: 1,
                              image: widget.image,
                              varData: '',
                            ),
                          )
                              .then((value) async {


                            print(valueProvider.checkboxes
                                .asMap()
                                .map(
                                  (index, checkbox) => MapEntry(
                                  index,
                                  checkbox.label

                              ),
                            )
                                .values);


                            valueProvider.addTotalPrice(valueProvider.price);
                            valueProvider.addCounter();
                            setState(() {});


                            final SharedPreferences prefs = await SharedPreferences.getInstance();

                            if(valueProvider.checkboxes.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkboxes.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("ApIR4", "Appetizer - I");
                              prefs.setString("ApIR4Value", valueProvider.checkboxes.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkApIIR4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkApIIR4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("ApIIR4", "Appetizer - II");
                              prefs.setString("ApIIR4Value", valueProvider.checkApIIR4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE1R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE1R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E1R4", "Entree - I");
                              prefs.setString("E1R4Value", valueProvider.checkE1R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE2R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE2R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E2R4", "Entree - II");
                              prefs.setString("E2R4Value", valueProvider.checkE2R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE3R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE3R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E3R4", "Entree - III");
                              prefs.setString("E3R4Value", valueProvider.checkE3R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkBreadR4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkBreadR4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("BreadR4", "Bread");
                              prefs.setString("BreadR4Value", valueProvider.checkBreadR4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkC1R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC1R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("C1R4", "Condiments - I");
                              prefs.setString("C1R4Value", valueProvider.checkC1R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkC2R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC2R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("C2R4", "Condiments - II");
                              prefs.setString("C2R4Value", valueProvider.checkC2R4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkDessertsR4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkDessertsR4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("DessertsR4", "Desserts");
                              prefs.setString("DessertsR4Value", valueProvider.checkDessertsR4.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }



                            if(valueProvider.isPlates == true){
                              prefs.setString("PlatesAddOnsR4", "Spoon, Fork, Napkins (+\$0.25)");
                              prefs.setString("PlatesAddOnsQuantityR4", valueProvider.counterPlatesAddOns.toString());
                            }
                            if(valueProvider.isBottle == true){
                              prefs.setString("BottleAddOnsR4", "Bottled Water (+\$0.50)");
                              prefs.setString("BottleAddOnsQuantityR4", valueProvider.counterBottleAddOns.toString());
                            }
                            if(valueProvider.isMango == true){
                              prefs.setString("MangoAddOnsR4", "Mango Juice (+\$1.00)");
                              prefs.setString("MangoAddOnsQuantityR4", valueProvider.counterMangoAddOns.toString());
                            }
                            if(valueProvider.isNaan == true){
                              prefs.setString("NaanAddOnsR4", "Naan (+\$0.50)");
                              prefs.setString("NaanAddOnsQuantityR4", valueProvider.counterAddOns.toString());
                            }

                            valueProvider.plateAddOnsR4Check = (prefs.getString('PlatesAddOnsR4') ?? '');
                            valueProvider.plateQuantityR4Check = (prefs.getString('PlatesAddOnsQuantityR4') ?? '');
                            valueProvider.bottleAddOnsR4Check = (prefs.getString('BottleAddOnsR4') ?? '');
                            valueProvider.bottleQuantityR4Check = (prefs.getString('BottleAddOnsQuantityR4') ?? '');
                            valueProvider.mangoAddOnsR4Check = (prefs.getString('MangoAddOnsR4') ?? '');
                            valueProvider.mangoQuantityR4Check = (prefs.getString('MangoAddOnsQuantityR4') ?? '');
                            valueProvider.naanAddOnsR4Check = (prefs.getString('NaanAddOnsR4') ?? '');
                            valueProvider.naanQuantityR4Check = (prefs.getString('NaanAddOnsQuantityR4') ?? '');
                            valueProvider.apIR4 = (prefs.getString("ApIR4") ?? '');
                            valueProvider.apIR4Value = (prefs.getString("ApIR4Value") ?? '');
                            valueProvider.apIIR4 = (prefs.getString("ApIIR4") ?? '');
                            valueProvider.apIIR4Value = (prefs.getString("ApIIR4Value") ?? '');
                            valueProvider.e1R4 = (prefs.getString("E1R4") ?? '');
                            valueProvider.e1R4Value = (prefs.getString("E1R4Value") ?? '');
                            valueProvider.e2R4 = (prefs.getString("E2R4") ?? '');
                            valueProvider.e2R4Value = (prefs.getString("E2R4Value") ?? '');
                            valueProvider.e3R4 = (prefs.getString("E3R4") ?? '');
                            valueProvider.e3R4Value = (prefs.getString("E3R4Value") ?? '');
                            valueProvider.breadR4 = (prefs.getString("BreadR4") ?? '');
                            valueProvider.breadR4Value = (prefs.getString("BreadR4Value") ?? '');
                            valueProvider.c1R4 = (prefs.getString("C1R4") ?? '');
                            valueProvider.c1R4Value = (prefs.getString("C1R4Value") ?? '');
                            valueProvider.c2R4 = (prefs.getString("C2R4") ?? '');
                            valueProvider.c2R4Value = (prefs.getString("C2R4Value") ?? '');
                            valueProvider.dessertsR4 = (prefs.getString("DessertsR4") ?? '');
                            valueProvider.dessertsR4Value = (prefs.getString("DessertsR4Value") ?? '');
                            print(valueProvider.apIR4);
                            print(valueProvider.apIR4Value);
                            print(valueProvider.apIIR4);
                            print(valueProvider.apIIR4Value);
                            print(valueProvider.e1R4);
                            print(valueProvider.e1R4Value);
                            print(valueProvider.e2R4);
                            print(valueProvider.e2R4Value);
                            print(valueProvider.e3R4);
                            print(valueProvider.e3R4Value);
                            print(valueProvider.breadR4);
                            print(valueProvider.breadR4Value);
                            print(valueProvider.c1R4);
                            print(valueProvider.c1R4Value);
                            print(valueProvider.c2R4);
                            print(valueProvider.c2R4Value);
                            print(valueProvider.dessertsR4);
                            print(valueProvider.dessertsR4Value);



                            const snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Product is added to cart'),
                              duration: Duration(microseconds: 100),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }).onError((error, stackTrace) {
                            if (kDebugMode) {
                              print("error$error");
                            }
                            const snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content:
                                Text('Product is already added in cart'),
                                duration: Duration(microseconds: 100));

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        },
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
  }
}
