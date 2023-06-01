import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/src/badge.dart' as badge;

import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../screens/cart screen/cart_screen.dart';
import '../../screens/products categories screen/providers/product_categories_provider.dart';

class RamadanCateringScreen extends StatefulWidget {
  const RamadanCateringScreen({Key? key}) : super(key: key);

  @override
  State<RamadanCateringScreen> createState() => _RamadanCateringScreenState();
}

class _RamadanCateringScreenState extends State<RamadanCateringScreen> {
  @override
  Widget build(BuildContext context) {
    final valueProvider =
        Provider.of<ProductCategoriesProvider>(context, listen: false);
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
        child: SafeArea(
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
                                  "Add Ramadan Boxes",
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


              Expanded(child: ListView.builder(
                itemCount: valueProvider.cateringRamadanList.length,
                  itemBuilder: (_,index){
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(20),
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
                                      valueProvider
                                          .cateringRamadanList[index]
                                          .name
                                          .toString(),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.27,
                          child: Column(
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
                                      builder: (context, checkboxData, _) => Theme(
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
                                            "Veg Samosa",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ),
                                          value: checkboxData.isChecked,
                                          onChanged: (isChecked) {
                                            checkboxData.setChecked(isChecked!);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30), // set the same border radius as the container
                                          ),
                                        ),
                                      ),
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
                                      builder: (context, checkboxData, _) => Theme(
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
                                            "Veg Pakora",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ),
                                          value: checkboxData.isChecked,
                                          onChanged: (isChecked) {
                                            checkboxData.setChecked(isChecked!);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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


                        Container(
                          height: MediaQuery.of(context).size.height * 0.27,
                          child: Column(
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
                                      builder: (context, checkboxData, _) => Theme(
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
                                            "Chicken/Veg Biryani",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ),
                                          value: checkboxData.isChecked,
                                          onChanged: (isChecked) {
                                            checkboxData.setChecked(isChecked!);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30), // set the same border radius as the container
                                          ),
                                        ),
                                      ),
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
                                      builder: (context, checkboxData, _) => Theme(
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
                                            "Chicken Pulav",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ),
                                          value: checkboxData.isChecked,
                                          onChanged: (isChecked) {
                                            checkboxData.setChecked(isChecked!);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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



                        Container(
                          height: MediaQuery.of(context).size.height * 0.27,
                          child: Column(
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
                                      builder: (context, checkboxData, _) => Theme(
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
                                            "Tandoori Chicken",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ),
                                          value: checkboxData.isChecked,
                                          onChanged: (isChecked) {
                                            checkboxData.setChecked(isChecked!);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30), // set the same border radius as the container
                                          ),
                                        ),
                                      ),
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
                                      builder: (context, checkboxData, _) => Theme(
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
                                            "Pepper Chicken",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ),
                                          value: checkboxData.isChecked,
                                          onChanged: (isChecked) {
                                            checkboxData.setChecked(isChecked!);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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



                        Container(
                          height: MediaQuery.of(context).size.height * 0.18,
                          child: Column(
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
                                      builder: (context, checkboxData, _) => Theme(
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
                                            "Raitha",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ),
                                          value: checkboxData.isChecked,
                                          onChanged: (isChecked) {
                                            checkboxData.setChecked(isChecked!);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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




                        Container(
                          height: MediaQuery.of(context).size.height * 0.27,
                          child: Column(
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
                                      builder: (context, checkboxData, _) => Theme(
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
                                            "Gulab Jamun",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ),
                                          value: checkboxData.isChecked,
                                          onChanged: (isChecked) {
                                            checkboxData.setChecked(isChecked!);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30), // set the same border radius as the container
                                          ),
                                        ),
                                      ),
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
                                      builder: (context, checkboxData, _) => Theme(
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
                                            "Rice Kheer",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ),
                                          value: checkboxData.isChecked,
                                          onChanged: (isChecked) {
                                            checkboxData.setChecked(isChecked!);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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




                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Column(
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white70,
                                  ),
                                  child: Center(
                                    child: Consumer<ProductCategoriesProvider>(
                                      builder: (context, checkboxData, _) => Theme(
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
                                            "Plate, Spoon, Fork, Napkins (+\$0.50)",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ),
                                          value: checkboxData.isChecked,
                                          onChanged: (isChecked) {
                                            checkboxData.setChecked(isChecked!);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30), // set the same border radius as the container
                                          ),
                                        ),
                                      ),
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
                                      builder: (context, checkboxData, _) => Theme(
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
                                            "Bottled Water (+\$0.50)",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ),
                                          value: checkboxData.isChecked,
                                          onChanged: (isChecked) {
                                            checkboxData.setChecked(isChecked!);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30), // set the same border radius as the container
                                          ),
                                        ),
                                      ),
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
                                      builder: (context, checkboxData, _) => Theme(
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
                                            "Mango Juice (+\$1.00)",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ),
                                          value: checkboxData.isChecked,
                                          onChanged: (isChecked) {
                                            checkboxData.setChecked(isChecked!);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30), // set the same border radius as the container
                                          ),
                                        ),
                                      ),
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
                                      builder: (context, checkboxData, _) => Theme(
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
                                            "Naan (+\$0.50)",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ),
                                          value: checkboxData.isChecked,
                                          onChanged: (isChecked) {
                                            checkboxData.setChecked(isChecked!);
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30), // set the same border radius as the container
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 6.h,
                              width: 6.h,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      10),
                                  color:
                                  Colors.white),
                              child: Padding(
                                padding:
                                const EdgeInsets
                                    .all(8.0),
                                child: Lottie.asset(
                                    'assets/images/lottie/cart.json'),
                              ),
                            ),
                            Container(
                              height: 6.h,
                              width: 6.h,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      10),
                                  color:
                                  Colors.white),
                              child: Padding(
                                padding:
                                const EdgeInsets
                                    .all(8.0),
                                child: Lottie.asset(
                                    'assets/images/lottie/cart.json'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );

                    Text(valueProvider
                    .cateringRamadanList[index]
                    //.images![0]['src']
                    .toString());
              })),
            ],
          ),
        ),
      ),
    );
  }
}
