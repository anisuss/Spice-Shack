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

class RamadanBox2 extends StatefulWidget {
  final String nameTitle;
  final String image;
  final String price;
  final String id;
  const RamadanBox2({super.key, required this.nameTitle,required this.image,required this.price,required this.id});

  @override
  State<RamadanBox2> createState() => _RamadanBox2State();
}

class _RamadanBox2State extends State<RamadanBox2> {
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
                      BoxWidget(image: widget.image, price: valueProvider.priceR2.toStringAsFixed(2), productName: widget.nameTitle,),

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
                                          children: provider.checkApIR2
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
                                                        provider.updateSelectedCheckApIR2(index);
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
                                          children: provider.checkE1R2
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
                                                        provider.updateSelectedCheckE1R2(index);
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
                                          children: provider.checkE2R2
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
                                                        provider.updateSelectedCheckE2R2(index);
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
                                          children: provider.checkE3R2
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
                                                        provider.updateSelectedCheckE3R2(index);
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
                                          children: provider.checkBreadR2
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
                                                        provider.updateSelectedCheckBreadR2(index);
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
                                          children: provider.checkC1R2
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
                                                        provider.updateSelectedCheckC1R2(index);
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
                                          children: provider.checkC2R2
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
                                                        provider.updateSelectedCheckC2R2(index);
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
                                          children: provider.checkDessertsR2
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
                                                        provider.updateSelectedCheckDessertsR2(index);
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
                                                      "Plate, Spoon, Plate, Spoon (+\$${valueProvider.platesAddOnsR2})",
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
                                                            .decrementPlatesR2,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterPlatesAddOnsR2
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
                                                            .incrementPlatesR2,
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
                                            color: valueProvider.isPlatesR2
                                                ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                          ),
                                          child: TextButton(
                                            onPressed: (){
                                              valueProvider.togglePlatesR2();
                                              setState(() {});

                                            },
                                            child: Consumer<
                                                ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return AutoSizeText(
                                                    valueProvider.isPlatesR2 ? "Added" : "Add",
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: valueProvider.isPlatesR2 ?  Colors.white : MyColors.black,
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
                                                      "Bottled Water (+\$${valueProvider.bottleAddOnsR2})",
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
                                                            .decrementBottleR2,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterBottleAddOnsR2
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
                                                            .incrementBottleR2,
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
                                            color: valueProvider.isBottleR2
                                                ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                          ),
                                          child: TextButton(
                                            onPressed: (){
                                              valueProvider.toggleBottleR2();
                                              setState(() {});

                                            },
                                            child: Consumer<
                                                ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return AutoSizeText(
                                                    valueProvider.isBottleR2 ? "Added" : "Add",
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: valueProvider.isBottleR2 ?  Colors.white : MyColors.black,
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
                                                      "Mango Juice (+\$${valueProvider.mangoAddOnsR2})",
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
                                                            .decrementMangoR2,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterMangoAddOnsR2
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
                                                            .incrementMangoR2,
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
                                          color: valueProvider.isMangoR2
                                              ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                        ),
                                        child: TextButton(
                                          onPressed: (){
                                            valueProvider.toggleMangoR2();
                                            setState(() {});
                                          },
                                          child: Consumer<
                                              ProductCategoriesProvider>(
                                              builder:
                                                  (context, provider, child) {
                                                return AutoSizeText(
                                                  valueProvider.isMangoR2 ? "Added" : "Add",
                                                  textAlign: TextAlign.start,
                                                  style: AppTextStyle
                                                      .spiceShackFonts(
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: valueProvider.isMangoR2 ?  Colors.white : MyColors.black,
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
                                                      "Naan (+\$${valueProvider.naanAddOnsR2.toString()})",
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
                                                            .decrementR2,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterAddOnsR2
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
                                                              .incrementR2();
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
                                            color: valueProvider.isNaanR2
                                                ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                          ),
                                          child: TextButton(
                                            onPressed: (){
                                              valueProvider.toggleNaanR2();
                                              setState(() {});

                                            },
                                            child: Consumer<
                                                ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return AutoSizeText(
                                                    valueProvider.isNaanR2 ? "Added" : "Add",
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: valueProvider.isNaanR2 ?  Colors.white : MyColors.black,
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
                        /*onTap: () async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();

                          if(valueProvider.checkApIR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkApIR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                            prefs.setString("ApIR2", "Appetizer - I");
                            prefs.setString("ApIR2Value", valueProvider.checkApIR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                          }
                          if(valueProvider.checkE1R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE1R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                            prefs.setString("E1R2", "Entree - I");
                            prefs.setString("E1R2Value", valueProvider.checkE1R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                          }
                          if(valueProvider.checkE2R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE2R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                            prefs.setString("E2R2", "Entree - II");
                            prefs.setString("E2R2Value", valueProvider.checkE2R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                          }
                          if(valueProvider.checkE3R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE3R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                            prefs.setString("E3R2", "Entree - III");
                            prefs.setString("E3R2Value", valueProvider.checkE3R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                          }
                          if(valueProvider.checkBreadR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkBreadR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                            prefs.setString("BreadR2", "Bread");
                            prefs.setString("BreadR2Value", valueProvider.checkBreadR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                          }
                          if(valueProvider.checkC1R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC1R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                            prefs.setString("C1R2", "Condiments - I");
                            prefs.setString("C1R2Value", valueProvider.checkC1R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                          }
                          if(valueProvider.checkC2R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC2R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                            prefs.setString("C2R2", "Condiments - II");
                            prefs.setString("C2R2Value", valueProvider.checkC2R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                          }
                          if(valueProvider.checkDessertsR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkDessertsR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                            prefs.setString("DessertsR2", "Desserts");
                            prefs.setString("DessertsR2Value", valueProvider.checkDessertsR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                          }

                          valueProvider.apIR2 = (prefs.getString("ApIR2") ?? '');
                          valueProvider.apIR2Value = (prefs.getString("ApIR2Value") ?? '');
                          valueProvider.e1R2 = (prefs.getString("E1R2") ?? '');
                          valueProvider.e1R2Value = (prefs.getString("E1R2Value") ?? '');
                          valueProvider.e2R2 = (prefs.getString("E2R2") ?? '');
                          valueProvider.e2R2Value = (prefs.getString("E2R2Value") ?? '');
                          valueProvider.e3R2 = (prefs.getString("E3R2") ?? '');
                          valueProvider.e3R2Value = (prefs.getString("E3R2Value") ?? '');
                          valueProvider.breadR2 = (prefs.getString("BreadR2") ?? '');
                          valueProvider.breadR2Value = (prefs.getString("BreadR2Value") ?? '');
                          valueProvider.c1R2 = (prefs.getString("C1R2") ?? '');
                          valueProvider.c1R2Value = (prefs.getString("C1R2Value") ?? '');
                          valueProvider.c2R2 = (prefs.getString("C2R2") ?? '');
                          valueProvider.c2R2Value = (prefs.getString("C2R2Value") ?? '');
                          valueProvider.dessertsR2 = (prefs.getString("DessertsR2") ?? '');
                          valueProvider.dessertsR2Value = (prefs.getString("DessertsR2Value") ?? '');
                          print(valueProvider.apIR2);
                          print(valueProvider.apIR2Value);
                          print(valueProvider.e1R2);
                          print(valueProvider.e1R2Value);
                          print(valueProvider.e2R2);
                          print(valueProvider.e2R2Value);
                          print(valueProvider.e3R2);
                          print(valueProvider.e3R2Value);
                          print(valueProvider.breadR2);
                          print(valueProvider.breadR2Value);
                          print(valueProvider.c1R2);
                          print(valueProvider.c1R2Value);
                          print(valueProvider.c2R2);
                          print(valueProvider.c2R2Value);
                          print(valueProvider.dessertsR2);
                          print(valueProvider.dessertsR2Value);
                        },*/
                        onTap: () {
                          dbHelper!.insert(
                            ProductModel(
                              id: 2,
                              productId: widget.id,
                              name: widget.nameTitle,
                              initialPrice: valueProvider.priceR2,
                              productPrice: valueProvider.priceR2,
                              quantity: 1,
                              image: widget.image,
                              varData: '',
                            ),
                          )
                              .then((value) async {
                            valueProvider.addTotalPrice(valueProvider.priceR2);
                            valueProvider.addCounter();
                            setState(() {});
                            final SharedPreferences prefs = await SharedPreferences.getInstance();

                            if(valueProvider.checkApIR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkApIR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("ApIR2", "Appetizer - I");
                              prefs.setString("ApIR2Value", valueProvider.checkApIR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE1R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE1R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E1R2", "Entree - I");
                              prefs.setString("E1R2Value", valueProvider.checkE1R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE2R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE2R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E2R2", "Entree - II");
                              prefs.setString("E2R2Value", valueProvider.checkE2R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE3R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE3R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E3R2", "Entree - III");
                              prefs.setString("E3R2Value", valueProvider.checkE3R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkBreadR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkBreadR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("BreadR2", "Bread");
                              prefs.setString("BreadR2Value", valueProvider.checkBreadR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkC1R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC1R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("C1R2", "Condiments - I");
                              prefs.setString("C1R2Value", valueProvider.checkC1R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkC2R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC2R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("C2R2", "Condiments - II");
                              prefs.setString("C2R2Value", valueProvider.checkC2R2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkDessertsR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkDessertsR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("DessertsR2", "Desserts");
                              prefs.setString("DessertsR2Value", valueProvider.checkDessertsR2.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }


                            if(valueProvider.isPlatesR2 == true){
                              prefs.setString("PlatesAddOnsR2", "Spoon, Fork, Napkins (+\$0.25)");
                              prefs.setString("PlatesAddOnsQuantityR2", valueProvider.counterPlatesAddOnsR2.toString());
                            }
                            if(valueProvider.isBottleR2 == true){
                              prefs.setString("BottleAddOnsR2", "Bottled Water (+\$0.50)");
                              prefs.setString("BottleAddOnsQuantityR2", valueProvider.counterBottleAddOnsR2.toString());
                            }
                            if(valueProvider.isMangoR2 == true){
                              prefs.setString("MangoAddOnsR2", "Mango Juice (+\$1.00)");
                              prefs.setString("MangoAddOnsQuantityR2", valueProvider.counterMangoAddOnsR2.toString());
                            }
                            if(valueProvider.isNaanR2 == true){
                              prefs.setString("NaanAddOnsR2", "Naan (+\$0.50)");
                              prefs.setString("NaanAddOnsQuantityR2", valueProvider.counterAddOnsR2.toString());
                            }

                            valueProvider.plateAddOnsR2Check = (prefs.getString('PlatesAddOnsR2') ?? '');
                            valueProvider.plateQuantityR2Check = (prefs.getString('PlatesAddOnsQuantityR2') ?? '');
                            valueProvider.bottleAddOnsR2Check = (prefs.getString('BottleAddOnsR2') ?? '');
                            valueProvider.bottleQuantityR2Check = (prefs.getString('BottleAddOnsQuantityR2') ?? '');
                            valueProvider.mangoAddOnsR2Check = (prefs.getString('MangoAddOnsR2') ?? '');
                            valueProvider.mangoQuantityR2Check = (prefs.getString('MangoAddOnsQuantityR2') ?? '');
                            valueProvider.naanAddOnsR2Check = (prefs.getString('NaanAddOnsR2') ?? '');
                            valueProvider.naanQuantityR2Check = (prefs.getString('NaanAddOnsQuantityR2') ?? '');


                            valueProvider.apIR2 = (prefs.getString("ApIR2") ?? '');
                            valueProvider.apIR2Value = (prefs.getString("ApIR2Value") ?? '');
                            valueProvider.e1R2 = (prefs.getString("E1R2") ?? '');
                            valueProvider.e1R2Value = (prefs.getString("E1R2Value") ?? '');
                            valueProvider.e2R2 = (prefs.getString("E2R2") ?? '');
                            valueProvider.e2R2Value = (prefs.getString("E2R2Value") ?? '');
                            valueProvider.e3R2 = (prefs.getString("E3R2") ?? '');
                            valueProvider.e3R2Value = (prefs.getString("E3R2Value") ?? '');
                            valueProvider.breadR2 = (prefs.getString("BreadR2") ?? '');
                            valueProvider.breadR2Value = (prefs.getString("BreadR2Value") ?? '');
                            valueProvider.c1R2 = (prefs.getString("C1R2") ?? '');
                            valueProvider.c1R2Value = (prefs.getString("C1R2Value") ?? '');
                            valueProvider.c2R2 = (prefs.getString("C2R2") ?? '');
                            valueProvider.c2R2Value = (prefs.getString("C2R2Value") ?? '');
                            valueProvider.dessertsR2 = (prefs.getString("DessertsR2") ?? '');
                            valueProvider.dessertsR2Value = (prefs.getString("DessertsR2Value") ?? '');
                            print(valueProvider.apIR2);
                            print(valueProvider.apIR2Value);
                            print(valueProvider.e1R2);
                            print(valueProvider.e1R2Value);
                            print(valueProvider.e2R2);
                            print(valueProvider.e2R2Value);
                            print(valueProvider.e3R2);
                            print(valueProvider.e3R2Value);
                            print(valueProvider.breadR2);
                            print(valueProvider.breadR2Value);
                            print(valueProvider.c1R2);
                            print(valueProvider.c1R2Value);
                            print(valueProvider.c2R2);
                            print(valueProvider.c2R2Value);
                            print(valueProvider.dessertsR2);
                            print(valueProvider.dessertsR2Value);



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
