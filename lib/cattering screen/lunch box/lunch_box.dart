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

class LunchBoxCateringScreen extends StatefulWidget {
  const LunchBoxCateringScreen({Key? key}) : super(key: key);

  @override
  State<LunchBoxCateringScreen> createState() => _LunchBoxCateringScreenState();
}

class _LunchBoxCateringScreenState extends State<LunchBoxCateringScreen> {
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
                          'assets/images/backgrounds/lunch.jpg',
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
                                  'Lunch Box',
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
                        "Price \$ ${valueProvider.priceLBox.toStringAsFixed(2)}",
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
                                          children: provider.checkApILBox
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
                                                        provider.updateSelectedCheckApILBox(index);
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
                                          children: provider.checkApIILBox
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
                                                        provider.updateSelectedCheckApIILBox(index);
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
                                          children: provider.checkE1LBox
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
                                                        provider.updateSelectedCheckE1LBox(index);
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
                                          children: provider.checkE2LBox
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
                                                        provider.updateSelectedCheckE2LBox(index);
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
                                          children: provider.checkE3LBox
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
                                                        provider.updateSelectedCheckE3LBox(index);
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
                                          children: provider.checkBreadLBox
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
                                                        provider.updateSelectedCheckBreadLBox(index);
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
                                          children: provider.checkC1LBox
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
                                                        provider.updateSelectedCheckC1LBox(index);
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
                                          children: provider.checkC2LBox
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
                                                        provider.updateSelectedCheckC2LBox(index);
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
                                          children: provider.checkDessertsLBox
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
                                                        provider.updateSelectedCheckDessertsLBox(index);
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
                                                      "Plate, Spoon, Plate, Spoon (+\$${valueProvider.platesAddOnsLBox})",
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
                                                            .decrementPlatesLBox,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterPlatesAddOnsLBox
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
                                                            .incrementPlatesLBox,
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
                                            color: valueProvider.isPlatesLBox
                                                ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                          ),
                                          child: TextButton(
                                            onPressed: (){
                                              valueProvider.togglePlatesLBox();
                                              setState(() {});

                                            },
                                            child: Consumer<
                                                ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return AutoSizeText(
                                                    valueProvider.isPlatesLBox ? "Added" : "Add",
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: valueProvider.isPlatesLBox ?  Colors.white : MyColors.black,
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
                                                      "Bottled Water (+\$${valueProvider.bottleAddOnsLBox})",
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
                                                            .decrementBottleLBox,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterBottleAddOnsLBox
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
                                                            .incrementBottleLBox,
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
                                            color: valueProvider.isBottleLBox
                                                ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                          ),
                                          child: TextButton(
                                            onPressed: (){
                                              valueProvider.toggleBottleLBox();
                                              setState(() {});

                                            },
                                            child: Consumer<
                                                ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return AutoSizeText(
                                                    valueProvider.isBottleLBox ? "Added" : "Add",
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: valueProvider.isBottleLBox ?  Colors.white : MyColors.black,
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
                                                      "Mango Juice (+\$${valueProvider.mangoAddOnsLBox})",
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
                                                            .decrementMangoLBox,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterMangoAddOnsLBox
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
                                                            .incrementMangoLBox,
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
                                          color: valueProvider.isMangoLBox
                                              ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                        ),
                                        child: TextButton(
                                          onPressed: (){
                                            valueProvider.toggleMangoLBox();
                                            setState(() {});
                                          },
                                          child: Consumer<
                                              ProductCategoriesProvider>(
                                              builder:
                                                  (context, provider, child) {
                                                return AutoSizeText(
                                                  valueProvider.isMangoLBox ? "Added" : "Add",
                                                  textAlign: TextAlign.start,
                                                  style: AppTextStyle
                                                      .spiceShackFonts(
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: valueProvider.isMangoLBox ?  Colors.white : MyColors.black,
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
                                                      "Naan (+\$${valueProvider.naanAddOnsLBox.toString()})",
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
                                                            .decrementLBox,
                                                        icon: Icon(Icons.remove),
                                                      ),
                                                      Text(valueProvider
                                                          .counterAddOnsLBox
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
                                                              .incrementLBox();
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
                                            color: valueProvider.isNaanLBox
                                                ? Colors.green.shade700.withOpacity(0.8) : Colors.white70,
                                          ),
                                          child: TextButton(
                                            onPressed: (){
                                              valueProvider.toggleNaanLBox();
                                              setState(() {});

                                            },
                                            child: Consumer<
                                                ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return AutoSizeText(
                                                    valueProvider.isNaanLBox ? "Added" : "Add",
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: valueProvider.isNaanLBox ?  Colors.white : MyColors.black,
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
                              productId: valueProvider.cateringLunchBoxList[0].id.toString(),
                              name: valueProvider.cateringLunchBoxList[0].name.toString(),
                              initialPrice: valueProvider.priceLBox,
                              productPrice: valueProvider.priceLBox,
                              quantity: 1,
                              image: valueProvider.cateringLunchBoxList[0].images![0]['src'].toString(),
                              varData: '',
                            ),
                          )
                              .then((value) async {
                            valueProvider.addTotalPrice(valueProvider.priceLBox);
                            valueProvider.addCounter();
                            setState(() {});



                            final SharedPreferences prefs = await SharedPreferences.getInstance();

                            if(valueProvider.checkApILBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkApILBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("ApILBox", "Appetizer - I");
                              prefs.setString("ApILBoxValue", valueProvider.checkApILBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkApIILBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkApIILBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("ApIiLBox", "Appetizer - II");
                              prefs.setString("ApIILBoxValue", valueProvider.checkApIILBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE1LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE1LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E1LBox", "Entree - I");
                              prefs.setString("E1LBoxValue", valueProvider.checkE1LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE2LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE2LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E2LBox", "Entree - II");
                              prefs.setString("E2LBoxValue", valueProvider.checkE2LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE3LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE3LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E3LBox", "Entree - III");
                              prefs.setString("E3LBoxValue", valueProvider.checkE3LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkBreadLBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkBreadLBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("BreadLBox", "Bread");
                              prefs.setString("BreadLBoxValue", valueProvider.checkBreadLBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkC1LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC1LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("C1LBox", "Condiments - I");
                              prefs.setString("C1LBoxValue", valueProvider.checkC1LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkC2LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC2LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("C2LBox", "Condiments - II");
                              prefs.setString("C2LBoxValue", valueProvider.checkC2LBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkDessertsLBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkDessertsLBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("DessertsLBox", "Desserts");
                              prefs.setString("DessertsLBoxValue", valueProvider.checkDessertsLBox.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }



                            if(valueProvider.isPlatesLBox == true){
                              prefs.setString("PlatesAddOnsLBox", "Spoon, Fork, Napkins (+\$0.25)");
                              prefs.setString("PlatesAddOnsQuantityLBox", valueProvider.counterPlatesAddOnsLBox.toString());
                            }
                            if(valueProvider.isBottleLBox == true){
                              prefs.setString("BottleAddOnsLBox", "Bottled Water (+\$0.50)");
                              prefs.setString("BottleAddOnsQuantityLBox", valueProvider.counterBottleAddOnsLBox.toString());
                            }
                            if(valueProvider.isMangoLBox == true){
                              prefs.setString("MangoAddOnsLBox", "Mango Juice (+\$1.00)");
                              prefs.setString("MangoAddOnsQuantityLBox", valueProvider.counterMangoAddOnsLBox.toString());
                            }
                            if(valueProvider.isNaanLBox == true){
                              prefs.setString("NaanAddOnsLBox", "Naan (+\$0.50)");
                              prefs.setString("NaanAddOnsQuantityLBox", valueProvider.counterAddOnsLBox.toString());
                            }

                            valueProvider.plateAddOnsLBoxCheck = (prefs.getString('PlatesAddOnsLBox') ?? '');
                            valueProvider.plateQuantityLBoxCheck = (prefs.getString('PlatesAddOnsQuantityLBox') ?? '');
                            valueProvider.bottleAddOnsLBoxCheck = (prefs.getString('BottleAddOnsLBox') ?? '');
                            valueProvider.bottleQuantityLBoxCheck = (prefs.getString('BottleAddOnsQuantityLBox') ?? '');
                            valueProvider.mangoAddOnsLBoxCheck = (prefs.getString('MangoAddOnsLBox') ?? '');
                            valueProvider.mangoQuantityLBoxCheck = (prefs.getString('MangoAddOnsQuantityLBox') ?? '');
                            valueProvider.naanAddOnsLBoxCheck = (prefs.getString('NaanAddOnsLBox') ?? '');
                            valueProvider.naanQuantityLBoxCheck = (prefs.getString('NaanAddOnsQuantityLBox') ?? '');
                            valueProvider.apILBox = (prefs.getString("ApILBox") ?? '');
                            valueProvider.apILBoxValue = (prefs.getString("ApILBoxValue") ?? '');
                            valueProvider.apIILBox = (prefs.getString("ApIiLBox") ?? '');
                            valueProvider.apIILBoxValue = (prefs.getString("ApIILBoxValue") ?? '');
                            valueProvider.e1LBox = (prefs.getString("E1LBox") ?? '');
                            valueProvider.e1LBoxValue = (prefs.getString("E1LBoxValue") ?? '');
                            valueProvider.e2LBox = (prefs.getString("E2LBox") ?? '');
                            valueProvider.e2LBoxValue = (prefs.getString("E2LBoxValue") ?? '');
                            valueProvider.e3LBox = (prefs.getString("E3LBox") ?? '');
                            valueProvider.e3LBoxValue = (prefs.getString("E3LBoxValue") ?? '');
                            valueProvider.breadLBox = (prefs.getString("BreadLBox") ?? '');
                            valueProvider.breadLBoxValue = (prefs.getString("BreadLBoxValue") ?? '');
                            valueProvider.c1LBox = (prefs.getString("C1LBox") ?? '');
                            valueProvider.c1LBoxValue = (prefs.getString("C1LBoxValue") ?? '');
                            valueProvider.c2LBox = (prefs.getString("C2LBox") ?? '');
                            valueProvider.c2LBoxValue = (prefs.getString("C2LBoxValue") ?? '');
                            valueProvider.dessertsLBox = (prefs.getString("DessertsLBox") ?? '');
                            valueProvider.dessertsLBoxValue = (prefs.getString("DessertsLBoxValue") ?? '');
                            print(valueProvider.apILBox);
                            print(valueProvider.apILBoxValue);
                            print(valueProvider.apIILBox);
                            print(valueProvider.apIILBoxValue);
                            print(valueProvider.e1LBox);
                            print(valueProvider.e1LBoxValue);
                            print(valueProvider.e2LBox);
                            print(valueProvider.e2LBoxValue);
                            print(valueProvider.e3LBox);
                            print(valueProvider.e3LBoxValue);
                            print(valueProvider.breadLBox);
                            print(valueProvider.breadLBoxValue);
                            print(valueProvider.c1LBox);
                            print(valueProvider.c1LBoxValue);
                            print(valueProvider.c2LBox);
                            print(valueProvider.c2LBoxValue);
                            print(valueProvider.dessertsLBox);
                            print(valueProvider.dessertsLBoxValue);




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
