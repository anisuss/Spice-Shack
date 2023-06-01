import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
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

class RamadanBox3 extends StatefulWidget {
  final String nameTitle;
  final String image;
  final String price;
  final String id;
  const RamadanBox3({super.key, required this.nameTitle,required this.image,required this.price,required this.id});

  @override
  State<RamadanBox3> createState() => _RamadanBox3State();
}

class _RamadanBox3State extends State<RamadanBox3> {
  DBHelperStatic? dbHelper = DBHelperStatic();

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
                          onPressed: (){
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
                                builder: (context) =>
                                const CartScreen(),
                              ),
                            );
                          },
                          child: badge.Badge(
                            badgeContent: Text(
                                valueProvider.getCounter().toString(),
                                style: const TextStyle(
                                    color: Colors.white)),
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
                      BoxWidget(image: widget.image, price: valueProvider.priceR3.toStringAsFixed(2), productName: widget.nameTitle,),

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
                                          children: provider.checkApIR3
                                              .asMap()
                                              .map(
                                                (index, checkbox) =>
                                                MapEntry(index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor: Colors.red,
                                                      checkboxTheme: CheckboxThemeData(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign: TextAlign.start,
                                                        style: AppTextStyle.spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w600,
                                                            color: MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value: checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider.updateSelectedCheckApIR3(index);
                                                      },
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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
                                          children: provider.checkApIIR3
                                              .asMap()
                                              .map(
                                                (index, checkbox) =>
                                                MapEntry(index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor: Colors.red,
                                                      checkboxTheme: CheckboxThemeData(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign: TextAlign.start,
                                                        style: AppTextStyle.spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w600,
                                                            color: MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value: checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider.updateSelectedCheckApIIR3(index);
                                                      },
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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
                                          children: provider.checkE1R3
                                              .asMap()
                                              .map(
                                                (index, checkbox) =>
                                                MapEntry(index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor: Colors.red,
                                                      checkboxTheme: CheckboxThemeData(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign: TextAlign.start,
                                                        style: AppTextStyle.spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w600,
                                                            color: MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value: checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider.updateSelectedCheckE1R3(index);
                                                      },
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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
                                          children: provider.checkE2R3
                                              .asMap()
                                              .map(
                                                (index, checkbox) =>
                                                MapEntry(index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor: Colors.red,
                                                      checkboxTheme: CheckboxThemeData(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign: TextAlign.start,
                                                        style: AppTextStyle.spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w600,
                                                            color: MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value: checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider.updateSelectedCheckE2R3(index);
                                                      },
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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
                                          children: provider.checkE3R3
                                              .asMap()
                                              .map(
                                                (index, checkbox) =>
                                                MapEntry(index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor: Colors.red,
                                                      checkboxTheme: CheckboxThemeData(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign: TextAlign.start,
                                                        style: AppTextStyle.spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w600,
                                                            color: MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value: checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider.updateSelectedCheckE3R3(index);
                                                      },
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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
                                          children: provider.checkBreadR3
                                              .asMap()
                                              .map(
                                                (index, checkbox) =>
                                                MapEntry(index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor: Colors.red,
                                                      checkboxTheme: CheckboxThemeData(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign: TextAlign.start,
                                                        style: AppTextStyle.spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w600,
                                                            color: MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value: checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider.updateSelectedCheckBreadR3(index);
                                                      },
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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
                                          children: provider.checkC1R3
                                              .asMap()
                                              .map(
                                                (index, checkbox) =>
                                                MapEntry(index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor: Colors.red,
                                                      checkboxTheme: CheckboxThemeData(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign: TextAlign.start,
                                                        style: AppTextStyle.spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w600,
                                                            color: MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value: checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider.updateSelectedCheckC1R3(index);
                                                      },
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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
                                          children: provider.checkC2R3
                                              .asMap()
                                              .map(
                                                (index, checkbox) =>
                                                MapEntry(index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor: Colors.red,
                                                      checkboxTheme: CheckboxThemeData(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign: TextAlign.start,
                                                        style: AppTextStyle.spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w600,
                                                            color: MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value: checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider.updateSelectedCheckC2R3(index);
                                                      },
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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
                                          children: provider.checkDessertsR3
                                              .asMap()
                                              .map(
                                                (index, checkbox) =>
                                                MapEntry(index,
                                                  Theme(
                                                    data: ThemeData(
                                                      toggleableActiveColor: Colors.red,
                                                      checkboxTheme: CheckboxThemeData(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10), // set the border radius to 10
                                                        ),
                                                      ),
                                                    ),
                                                    child: CheckboxListTile(
                                                      title: AutoSizeText(
                                                        checkbox.label,
                                                        textAlign: TextAlign.start,
                                                        style: AppTextStyle.spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w600,
                                                            color: MyColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      value: checkbox.isSelected,
                                                      onChanged: (value) {
                                                        provider.updateSelectedCheckDessertsR3(index);
                                                      },
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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




                          // Container(
                          //   height: MediaQuery.of(context).size.height * 0.5,
                          //   child: Column(
                          //     children: [
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: AutoSizeText(
                          //           "Add Ons",
                          //           textAlign: TextAlign.start,
                          //           style: AppTextStyle.spiceShackFonts(
                          //             style: TextStyle(
                          //               fontSize: 16.sp,
                          //               fontWeight: FontWeight.bold,
                          //               color: MyColors.silver,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(20),
                          //             color: Colors.white70,
                          //           ),
                          //           child: Center(
                          //             child: Consumer<ProductCategoriesProvider>(
                          //               builder: (context, checkboxData, _) => Theme(
                          //                 data: ThemeData(
                          //                   toggleableActiveColor: Colors.red,
                          //                   checkboxTheme: CheckboxThemeData(
                          //                     shape: RoundedRectangleBorder(
                          //                       borderRadius: BorderRadius.circular(10), // set the border radius to 10
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 child: CheckboxListTile(
                          //                   title: AutoSizeText(
                          //                     "Plate, Spoon, Fork, Napkins (+\$0.50)",
                          //                     textAlign: TextAlign.start,
                          //                     style: AppTextStyle.spiceShackFonts(
                          //                       style: TextStyle(
                          //                         fontSize: 12.sp,
                          //                         fontWeight: FontWeight.w600,
                          //                         color: MyColors.black,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   value: checkboxData.isChecked,
                          //                   onChanged: (isChecked) {
                          //                     checkboxData.setChecked(isChecked!);
                          //                   },
                          //                   shape: RoundedRectangleBorder(
                          //                     borderRadius: BorderRadius.circular(30), // set the same border radius as the container
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(20),
                          //             color: Colors.white70,
                          //           ),
                          //           child: Center(
                          //             child: Consumer<ProductCategoriesProvider>(
                          //               builder: (context, checkboxData, _) => Theme(
                          //                 data: ThemeData(
                          //                   toggleableActiveColor: Colors.red,
                          //                   checkboxTheme: CheckboxThemeData(
                          //                     shape: RoundedRectangleBorder(
                          //                       borderRadius: BorderRadius.circular(10), // set the border radius to 10
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 child: CheckboxListTile(
                          //                   title: AutoSizeText(
                          //                     "Bottled Water (+\$0.50)",
                          //                     textAlign: TextAlign.start,
                          //                     style: AppTextStyle.spiceShackFonts(
                          //                       style: TextStyle(
                          //                         fontSize: 12.sp,
                          //                         fontWeight: FontWeight.w600,
                          //                         color: MyColors.black,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   value: checkboxData.isChecked,
                          //                   onChanged: (isChecked) {
                          //                     checkboxData.setChecked(isChecked!);
                          //                   },
                          //                   shape: RoundedRectangleBorder(
                          //                     borderRadius: BorderRadius.circular(30), // set the same border radius as the container
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(20),
                          //             color: Colors.white70,
                          //           ),
                          //           child: Center(
                          //             child: Consumer<ProductCategoriesProvider>(
                          //               builder: (context, checkboxData, _) => Theme(
                          //                 data: ThemeData(
                          //                   toggleableActiveColor: Colors.red,
                          //                   checkboxTheme: CheckboxThemeData(
                          //                     shape: RoundedRectangleBorder(
                          //                       borderRadius: BorderRadius.circular(10), // set the border radius to 10
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 child: CheckboxListTile(
                          //                   title: AutoSizeText(
                          //                     "Mango Juice (+\$1.00)",
                          //                     textAlign: TextAlign.start,
                          //                     style: AppTextStyle.spiceShackFonts(
                          //                       style: TextStyle(
                          //                         fontSize: 12.sp,
                          //                         fontWeight: FontWeight.w600,
                          //                         color: MyColors.black,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   value: checkboxData.isChecked,
                          //                   onChanged: (isChecked) {
                          //                     checkboxData.setChecked(isChecked!);
                          //                   },
                          //                   shape: RoundedRectangleBorder(
                          //                     borderRadius: BorderRadius.circular(30), // set the same border radius as the container
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(20),
                          //             color: Colors.white70,
                          //           ),
                          //           child: Center(
                          //             child: Consumer<ProductCategoriesProvider>(
                          //               builder: (context, checkboxData, _) => Theme(
                          //                 data: ThemeData(
                          //                   toggleableActiveColor: Colors.red,
                          //                   checkboxTheme: CheckboxThemeData(
                          //                     shape: RoundedRectangleBorder(
                          //                       borderRadius: BorderRadius.circular(10), // set the border radius to 10
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 child: CheckboxListTile(
                          //                   title: AutoSizeText(
                          //                     "Naan (+\$0.50)",
                          //                     textAlign: TextAlign.start,
                          //                     style: AppTextStyle.spiceShackFonts(
                          //                       style: TextStyle(
                          //                         fontSize: 12.sp,
                          //                         fontWeight: FontWeight.w600,
                          //                         color: MyColors.black,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   value: checkboxData.isChecked,
                          //                   onChanged: (isChecked) {
                          //                     checkboxData.setChecked(isChecked!);
                          //                   },
                          //                   shape: RoundedRectangleBorder(
                          //                     borderRadius: BorderRadius.circular(30), // set the same border radius as the container
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

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
                                                      "Plate, Spoon, Plate, Spoon (+\$${valueProvider.platesAddOnsR3})",
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
                                                            .decrementPlatesR3,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterPlatesAddOnsR3
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
                                                            .incrementPlatesR3,
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
                                            color: valueProvider.isPlatesR3
                                                ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                          ),
                                          child: TextButton(
                                            onPressed: (){
                                              valueProvider.togglePlatesR3();
                                              setState(() {});

                                            },
                                            child: Consumer<
                                                ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return AutoSizeText(
                                                    valueProvider.isPlatesR3 ? "Added" : "Add",
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: valueProvider.isPlatesR3 ?  Colors.white : MyColors.black,
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
                                                      "Bottled Water (+\$${valueProvider.bottleAddOnsR3})",
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
                                                            .decrementBottleR3,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterBottleAddOnsR3
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
                                                            .incrementBottleR3,
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
                                            color: valueProvider.isBottleR3
                                                ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                          ),
                                          child: TextButton(
                                            onPressed: (){
                                              valueProvider.toggleBottleR3();
                                              setState(() {});

                                            },
                                            child: Consumer<
                                                ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return AutoSizeText(
                                                    valueProvider.isBottleR3 ? "Added" : "Add",
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: valueProvider.isBottleR3 ?  Colors.white : MyColors.black,
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
                                                      "Mango Juice (+\$${valueProvider.mangoAddOnsR3})",
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
                                                            .decrementMangoR3,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterMangoAddOnsR3
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
                                                            .incrementMangoR3,
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
                                          color: valueProvider.isMangoR3
                                              ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                        ),
                                        child: TextButton(
                                          onPressed: (){
                                            valueProvider.toggleMangoR3();
                                            setState(() {});
                                          },
                                          child: Consumer<
                                              ProductCategoriesProvider>(
                                              builder:
                                                  (context, provider, child) {
                                                return AutoSizeText(
                                                  valueProvider.isMangoR3 ? "Added" : "Add",
                                                  textAlign: TextAlign.start,
                                                  style: AppTextStyle
                                                      .spiceShackFonts(
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: valueProvider.isMangoR3 ?  Colors.white : MyColors.black,
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
                                                      "Naan (+\$${valueProvider.naanAddOnsR3.toString()})",
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
                                                            .decrementR3,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterAddOnsR3
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
                                                              .incrementR3();
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
                                            color: valueProvider.isNaanR3
                                                ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                          ),
                                          child: TextButton(
                                            onPressed: (){
                                              valueProvider.toggleNaanR3();
                                              setState(() {});

                                            },
                                            child: Consumer<
                                                ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return AutoSizeText(
                                                    valueProvider.isNaanR3 ? "Added" : "Add",
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: valueProvider.isNaanR3 ?  Colors.white : MyColors.black,
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

                      ButtonToBuy(
                        onTap: () {
                          dbHelper!.insert(
                            ProductModel(
                              id: 3,
                              productId: widget.id,
                              name: widget.nameTitle,
                              initialPrice: valueProvider.priceR3,
                              productPrice: valueProvider.priceR3,
                              quantity: 1,
                              image: widget.image,
                              varData: '',
                            ),
                          )
                              .then((value) async {
                            valueProvider.addTotalPrice(valueProvider.priceR3);
                            valueProvider.addCounter();
                            setState(() {});



                            final SharedPreferences prefs = await SharedPreferences.getInstance();

                            if(valueProvider.checkApIR3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkApIR3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("ApIR3", "Appetizer - I");
                              prefs.setString("ApIR3Value", valueProvider.checkApIR3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkApIIR3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkApIIR3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("ApIIR3", "Appetizer - II");
                              prefs.setString("ApIIR3Value", valueProvider.checkApIR3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE1R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE1R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E1R3", "Entree - I");
                              prefs.setString("E1R3Value", valueProvider.checkE1R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE2R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE2R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E2R3", "Entree - II");
                              prefs.setString("E2R3Value", valueProvider.checkE2R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE3R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE3R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E3R3", "Entree - III");
                              prefs.setString("E3R3Value", valueProvider.checkE3R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkBreadR3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkBreadR3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("BreadR3", "Bread");
                              prefs.setString("BreadR3Value", valueProvider.checkBreadR3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkC1R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC1R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("C1R3", "Condiments - I");
                              prefs.setString("C1R3Value", valueProvider.checkC1R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkC2R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC2R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("C2R3", "Condiments - II");
                              prefs.setString("C2R3Value", valueProvider.checkC2R3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkDessertsR3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkDessertsR3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("DessertsR3", "Desserts");
                              prefs.setString("DessertsR3Value", valueProvider.checkDessertsR3.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }



                            if(valueProvider.isPlatesR3 == true){
                              prefs.setString("PlatesAddOnsR3", "Spoon, Fork, Napkins (+\$0.25)");
                              prefs.setString("PlatesAddOnsQuantityR3", valueProvider.counterPlatesAddOnsR3.toString());
                            }
                            if(valueProvider.isBottleR3 == true){
                              prefs.setString("BottleAddOnsR3", "Bottled Water (+\$0.50)");
                              prefs.setString("BottleAddOnsQuantityR3", valueProvider.counterBottleAddOnsR3.toString());
                            }
                            if(valueProvider.isMangoR3 == true){
                              prefs.setString("MangoAddOnsR3", "Mango Juice (+\$1.00)");
                              prefs.setString("MangoAddOnsQuantityR3", valueProvider.counterMangoAddOnsR3.toString());
                            }
                            if(valueProvider.isNaanR3 == true){
                              prefs.setString("NaanAddOnsR3", "Naan (+\$0.50)");
                              prefs.setString("NaanAddOnsQuantityR3", valueProvider.counterAddOnsR3.toString());
                            }

                            valueProvider.plateAddOnsR3Check = (prefs.getString('PlatesAddOnsR3') ?? '');
                            valueProvider.plateQuantityR3Check = (prefs.getString('PlatesAddOnsQuantityR3') ?? '');
                            valueProvider.bottleAddOnsR3Check = (prefs.getString('BottleAddOnsR3') ?? '');
                            valueProvider.bottleQuantityR3Check = (prefs.getString('BottleAddOnsQuantityR3') ?? '');
                            valueProvider.mangoAddOnsR3Check = (prefs.getString('MangoAddOnsR3') ?? '');
                            valueProvider.mangoQuantityR3Check = (prefs.getString('MangoAddOnsQuantityR3') ?? '');
                            valueProvider.naanAddOnsR3Check = (prefs.getString('NaanAddOnsR3') ?? '');
                            valueProvider.naanQuantityR3Check = (prefs.getString('NaanAddOnsQuantityR3') ?? '');
                            valueProvider.apIR3 = (prefs.getString("ApIR3") ?? '');
                            valueProvider.apIR3Value = (prefs.getString("ApIR3Value") ?? '');
                            valueProvider.apIIR3 = (prefs.getString("ApIIR3") ?? '');
                            valueProvider.apIIR3Value = (prefs.getString("ApIIR3Value") ?? '');
                            valueProvider.e1R3 = (prefs.getString("E1R3") ?? '');
                            valueProvider.e1R3Value = (prefs.getString("E1R3Value") ?? '');
                            valueProvider.e2R3 = (prefs.getString("E2R3") ?? '');
                            valueProvider.e2R3Value = (prefs.getString("E2R3Value") ?? '');
                            valueProvider.e3R3 = (prefs.getString("E3R3") ?? '');
                            valueProvider.e3R3Value = (prefs.getString("E3R3Value") ?? '');
                            valueProvider.breadR3 = (prefs.getString("BreadR3") ?? '');
                            valueProvider.breadR3Value = (prefs.getString("BreadR3Value") ?? '');
                            valueProvider.c1R3 = (prefs.getString("C1R3") ?? '');
                            valueProvider.c1R3Value = (prefs.getString("C1R3Value") ?? '');
                            valueProvider.c2R3 = (prefs.getString("C2R3") ?? '');
                            valueProvider.c2R3Value = (prefs.getString("C2R3Value") ?? '');
                            valueProvider.dessertsR3 = (prefs.getString("DessertsR3") ?? '');
                            valueProvider.dessertsR3Value = (prefs.getString("DessertsR3Value") ?? '');
                            print(valueProvider.apIR3);
                            print(valueProvider.apIR3Value);
                            print(valueProvider.apIIR3);
                            print(valueProvider.apIIR3Value);
                            print(valueProvider.e1R3);
                            print(valueProvider.e1R3Value);
                            print(valueProvider.e2R3);
                            print(valueProvider.e2R3Value);
                            print(valueProvider.e3R3);
                            print(valueProvider.e3R3Value);
                            print(valueProvider.breadR3);
                            print(valueProvider.breadR3Value);
                            print(valueProvider.c1R3);
                            print(valueProvider.c1R3Value);
                            print(valueProvider.c2R3);
                            print(valueProvider.c2R3Value);
                            print(valueProvider.dessertsR3);
                            print(valueProvider.dessertsR3Value);




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
