import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
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
import '../../widgets/navigation bar/navigation_bar_widget.dart';

class FamilyFeastScreen extends StatefulWidget {
  const FamilyFeastScreen({Key? key}) : super(key: key);

  @override
  State<FamilyFeastScreen> createState() => _FamilyFeastScreenState();
}

class _FamilyFeastScreenState extends State<FamilyFeastScreen> {
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
                          'assets/images/backgrounds/ff.jpg',
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
                                  'Family Feast',
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38.0,vertical: 18.0),
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
                        "Price \$ ${valueProvider.priceFF.toStringAsFixed(2)}",
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

              if (valueProvider.feastRamadan == 0)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 48.0, horizontal: 20.0),
                  child: SizedBox(
                    height: 40.h,
                    width: 40.h,
                    child: Lottie.asset(
                        'assets/images/lottie/loader.json'),
                  ),
                ),
    //child: BoxWidget(image: valueProvider.cateringFamilyFeastList[index].images![0]['src'].toString(), price: valueProvider.cateringFamilyFeastList[index].price.toString(), productName: valueProvider.cateringFamilyFeastList[index].name.toString(),)),


              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

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
                                          children: provider.checkApIFF
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
                                                        provider.updateSelectedCheckApIFF(index);
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
                                          children: provider.checkApIIFF
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
                                                        provider.updateSelectedCheckApIIFF(index);
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
                                          children: provider.checkE1FF
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
                                                        provider.updateSelectedCheckE1FF(index);
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
                                          children: provider.checkE2FF
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
                                                        provider.updateSelectedCheckE2FF(index);
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
                                          children: provider.checkE3FF
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
                                                        provider.updateSelectedCheckE3FF(index);
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
                                          children: provider.checkBreadFF
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
                                                        provider.updateSelectedCheckBreadFF(index);
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
                                          children: provider.checkC1FF
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
                                                        provider.updateSelectedCheckC1FF(index);
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
                                          children: provider.checkC2FF
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
                                                        provider.updateSelectedCheckC2FF(index);
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
                                          children: provider.checkDessertsFF
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
                                                        provider.updateSelectedCheckDessertsFF(index);
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
                                                      "Plate, Spoon, Plate, Spoon (+\$${valueProvider.platesAddOnsFF})",
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
                                                            .decrementPlatesFF,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterPlatesAddOnsFF
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
                                                            .incrementPlatesFF,
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
                                            color: valueProvider.isPlatesFF
                                                ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                          ),
                                          child: TextButton(
                                            onPressed: (){
                                              valueProvider.togglePlatesFF();
                                              setState(() {});

                                            },
                                            child: Consumer<
                                                ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return AutoSizeText(
                                                    valueProvider.isPlatesFF ? "Added" : "Add",
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: valueProvider.isPlatesFF ?  Colors.white : MyColors.black,
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
                                                      "Bottled Water (+\$${valueProvider.bottleAddOnsFF})",
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
                                                            .decrementBottleFF,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterBottleAddOnsFF
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
                                                            .incrementBottleFF,
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
                                            color: valueProvider.isBottleFF
                                                ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                          ),
                                          child: TextButton(
                                            onPressed: (){
                                              valueProvider.toggleBottleFF();
                                              setState(() {});

                                            },
                                            child: Consumer<
                                                ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return AutoSizeText(
                                                    valueProvider.isBottleFF ? "Added" : "Add",
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: valueProvider.isBottleFF ?  Colors.white : MyColors.black,
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
                                                      "Mango Juice (+\$${valueProvider.mangoAddOnsFF})",
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
                                                            .decrementMangoFF,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterMangoAddOnsFF
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
                                                            .incrementMangoFF,
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
                                          color: valueProvider.isMangoFF
                                              ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                        ),
                                        child: TextButton(
                                          onPressed: (){
                                            valueProvider.toggleMangoFF();
                                            setState(() {});
                                          },
                                          child: Consumer<
                                              ProductCategoriesProvider>(
                                              builder:
                                                  (context, provider, child) {
                                                return AutoSizeText(
                                                  valueProvider.isMangoFF ? "Added" : "Add",
                                                  textAlign: TextAlign.start,
                                                  style: AppTextStyle
                                                      .spiceShackFonts(
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: valueProvider.isMangoFF ?  Colors.white : MyColors.black,
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
                                                      "Naan (+\$${valueProvider.naanAddOnsFF.toString()})",
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
                                                            .decrementFF,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterAddOnsFF
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
                                                              .incrementFF();
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
                                            color: valueProvider.isNaanFF
                                                ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                          ),
                                          child: TextButton(
                                            onPressed: (){
                                              valueProvider.toggleNaanFF();
                                              setState(() {});

                                            },
                                            child: Consumer<
                                                ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return AutoSizeText(
                                                    valueProvider.isNaanFF ? "Added" : "Add",
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: valueProvider.isNaanFF ?  Colors.white : MyColors.black,
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
                              productId: valueProvider.cateringFamilyFeastList[0].id!.toString(),
                              name: valueProvider.cateringFamilyFeastList[0].name!.toString(),
                              initialPrice: valueProvider.priceFF,
                              productPrice: valueProvider.priceFF,
                              quantity: 1,
                              image: valueProvider.cateringFamilyFeastList[0].images![0]['src'].toString(),
                              varData: '',
                            ),
                          )
                              .then((value) async {
                            valueProvider.addTotalPrice(valueProvider.priceFF);
                            valueProvider.addCounter();
                            setState(() {});



                            final SharedPreferences prefs = await SharedPreferences.getInstance();

                            if(valueProvider.checkApIFF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkApIFF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("ApIFF", "Appetizer - I");
                              prefs.setString("ApIFFValue", valueProvider.checkApIFF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkApIIFF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkApIIFF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("ApIiFF", "Appetizer - II");
                              prefs.setString("ApIIFFValue", valueProvider.checkApIIFF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE1FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE1FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E1FF", "Entree - I");
                              prefs.setString("E1FFValue", valueProvider.checkE1FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE2FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE2FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E2FF", "Entree - II");
                              prefs.setString("E2FFValue", valueProvider.checkE2FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE3FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE3FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E3FF", "Entree - III");
                              prefs.setString("E3FFValue", valueProvider.checkE3FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkBreadFF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkBreadFF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("BreadFF", "Bread");
                              prefs.setString("BreadFFValue", valueProvider.checkBreadFF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkC1FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC1FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("C1FF", "Condiments - I");
                              prefs.setString("C1FFValue", valueProvider.checkC1FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkC2FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC2FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("C2FF", "Condiments - II");
                              prefs.setString("C2FFValue", valueProvider.checkC2FF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkDessertsFF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkDessertsFF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("DessertsFF", "Desserts");
                              prefs.setString("DessertsFFValue", valueProvider.checkDessertsFF.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }



                            if(valueProvider.isPlatesFF == true){
                              prefs.setString("PlatesAddOnsFF", "Spoon, Fork, Napkins (+\$0.25)");
                              prefs.setString("PlatesAddOnsQuantityFF", valueProvider.counterPlatesAddOnsFF.toString());
                            }
                            if(valueProvider.isBottleFF == true){
                              prefs.setString("BottleAddOnsFF", "Bottled Water (+\$0.50)");
                              prefs.setString("BottleAddOnsQuantityFF", valueProvider.counterBottleAddOnsFF.toString());
                            }
                            if(valueProvider.isMangoFF == true){
                              prefs.setString("MangoAddOnsFF", "Mango Juice (+\$1.00)");
                              prefs.setString("MangoAddOnsQuantityFF", valueProvider.counterMangoAddOnsFF.toString());
                            }
                            if(valueProvider.isNaanFF == true){
                              prefs.setString("NaanAddOnsFF", "Naan (+\$0.50)");
                              prefs.setString("NaanAddOnsQuantityFF", valueProvider.counterAddOnsFF.toString());
                            }

                            valueProvider.plateAddOnsFFCheck = (prefs.getString('PlatesAddOnsFF') ?? '');
                            valueProvider.plateQuantityFFCheck = (prefs.getString('PlatesAddOnsQuantityFF') ?? '');
                            valueProvider.bottleAddOnsFFCheck = (prefs.getString('BottleAddOnsFF') ?? '');
                            valueProvider.bottleQuantityFFCheck = (prefs.getString('BottleAddOnsQuantityFF') ?? '');
                            valueProvider.mangoAddOnsFFCheck = (prefs.getString('MangoAddOnsFF') ?? '');
                            valueProvider.mangoQuantityFFCheck = (prefs.getString('MangoAddOnsQuantityFF') ?? '');
                            valueProvider.naanAddOnsFFCheck = (prefs.getString('NaanAddOnsFF') ?? '');
                            valueProvider.naanQuantityFFCheck = (prefs.getString('NaanAddOnsQuantityFF') ?? '');
                            valueProvider.apIFF = (prefs.getString("ApIFF") ?? '');
                            valueProvider.apIFFValue = (prefs.getString("ApIFFValue") ?? '');
                            valueProvider.apIIFF = (prefs.getString("ApIiFF") ?? '');
                            valueProvider.apIIFFValue = (prefs.getString("ApIIFFValue") ?? '');
                            valueProvider.e1FF = (prefs.getString("E1FF") ?? '');
                            valueProvider.e1FFValue = (prefs.getString("E1FFValue") ?? '');
                            valueProvider.e2FF = (prefs.getString("E2FF") ?? '');
                            valueProvider.e2FFValue = (prefs.getString("E2FFValue") ?? '');
                            valueProvider.e3FF = (prefs.getString("E3FF") ?? '');
                            valueProvider.e3FFValue = (prefs.getString("E3FFValue") ?? '');
                            valueProvider.breadFF = (prefs.getString("BreadFF") ?? '');
                            valueProvider.breadFFValue = (prefs.getString("BreadFFValue") ?? '');
                            valueProvider.c1FF = (prefs.getString("C1FF") ?? '');
                            valueProvider.c1FFValue = (prefs.getString("C1FFValue") ?? '');
                            valueProvider.c2FF = (prefs.getString("C2FF") ?? '');
                            valueProvider.c2FFValue = (prefs.getString("C2FFValue") ?? '');
                            valueProvider.dessertsFF = (prefs.getString("DessertsFF") ?? '');
                            valueProvider.dessertsFFValue = (prefs.getString("DessertsFFValue") ?? '');
                            print(valueProvider.apIFF);
                            print(valueProvider.apIFFValue);
                            print(valueProvider.apIIFF);
                            print(valueProvider.apIIFFValue);
                            print(valueProvider.e1FF);
                            print(valueProvider.e1FFValue);
                            print(valueProvider.e2FF);
                            print(valueProvider.e2FFValue);
                            print(valueProvider.e3FF);
                            print(valueProvider.e3FFValue);
                            print(valueProvider.breadFF);
                            print(valueProvider.breadFFValue);
                            print(valueProvider.c1FF);
                            print(valueProvider.c1FFValue);
                            print(valueProvider.c2FF);
                            print(valueProvider.c2FFValue);
                            print(valueProvider.dessertsFF);
                            print(valueProvider.dessertsFFValue);




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
