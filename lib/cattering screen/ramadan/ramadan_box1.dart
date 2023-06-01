import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

class RamadanBox1 extends StatefulWidget {

  final String nameTitle;
  final String image;
  final String price;
  final String id;

  const RamadanBox1(
      {super.key,
      required this.nameTitle,
      required this.image,
      required this.price,
      required this.id,
      });

  @override
  State<RamadanBox1> createState() => _RamadanBox1State();
}

class _RamadanBox1State extends State<RamadanBox1> {
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
                                  // valueProvider.priceR1.toString(),
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
                      BoxWidget(
                        image: widget.image,
                        price: valueProvider.priceR1.toStringAsFixed(2),
                        productName: widget.nameTitle,
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
                                          children: provider.checkApIR1
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
                                                            .updateSelectedCheckApIR1(
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
                                          children: provider.checkE1R1
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
                                                            .updateSelectedCheckE1R1(
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
                                          children: provider.checkE2R1
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
                                                            .updateSelectedCheckE2R1(
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
                                          children: provider.checkC1R1
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
                                                            .updateSelectedCheckC1R1(
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
                                          children: provider.checkDessertsR1
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
                                                            .updateSelectedCheckDessertsR1(
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
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white70,
                                    ),
                                    child: Center(
                                      child:
                                          Consumer<ProductCategoriesProvider>(
                                              builder:
                                                  (context, provider, child) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: AutoSizeText(
                                                  "Plate, Spoon, Plate, Spoon (+\$${valueProvider.platesAddOnsR1})",
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
                                                        .decrementPlatesR1,
                                                    icon: Icon(Icons.remove),
                                                  ),
                                                  Text(valueProvider
                                                      .counterPlatesAddOnsR1
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
                                                    onPressed: valueProvider
                                                        .incrementPlatesR1,
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
                                        borderRadius: BorderRadius.circular(15),
                                        color: valueProvider.isPlatesR1
                                            ? Colors.green.shade700
                                                .withOpacity(0.8)
                                            : Colors.white70,
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          valueProvider.togglePlatesR1();
                                          setState(() {});
                                        },
                                        child:
                                            Consumer<ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                          return AutoSizeText(
                                            valueProvider.isPlatesR1
                                                ? "Added"
                                                : "Add",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600,
                                                color: valueProvider.isPlatesR1
                                                    ? Colors.white
                                                    : MyColors.black,
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
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white70,
                                    ),
                                    child: Center(
                                      child:
                                          Consumer<ProductCategoriesProvider>(
                                              builder:
                                                  (context, provider, child) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: AutoSizeText(
                                                  "Bottled Water (+\$${valueProvider.bottleAddOnsR1})",
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
                                                        .decrementBottleR1,
                                                    icon: Icon(Icons.remove),
                                                  ),
                                                  Text(valueProvider
                                                      .counterBottleAddOnsR1
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
                                                    onPressed: valueProvider
                                                        .incrementBottleR1,
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
                                        borderRadius: BorderRadius.circular(15),
                                        color: valueProvider.isBottleR1
                                            ? Colors.green.shade700
                                                .withOpacity(0.8)
                                            : Colors.white70,
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          valueProvider.toggleBottleR1();
                                          setState(() {});
                                        },
                                        child:
                                            Consumer<ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                          return AutoSizeText(
                                            valueProvider.isBottleR1
                                                ? "Added"
                                                : "Add",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600,
                                                color: valueProvider.isBottleR1
                                                    ? Colors.white
                                                    : MyColors.black,
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
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white70,
                                    ),
                                    child: Center(
                                      child:
                                          Consumer<ProductCategoriesProvider>(
                                              builder:
                                                  (context, provider, child) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: AutoSizeText(
                                                  "Mango Juice (+\$${valueProvider.mangoAddOnsR1})",
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
                                                        .decrementMangoR1,
                                                    icon: Icon(Icons.remove),
                                                  ),
                                                  Text(valueProvider
                                                      .counterMangoAddOnsR1
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
                                                    onPressed: valueProvider
                                                        .incrementMangoR1,
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
                                child: Consumer<ProductCategoriesProvider>(
                                    builder: (context, provider, child) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: valueProvider.isMangoR1
                                            ? Colors.green.shade700
                                                .withOpacity(0.8)
                                            : Colors.white70,
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          valueProvider.toggleMangoR1();
                                          setState(() {});
                                        },
                                        child:
                                            Consumer<ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                          return AutoSizeText(
                                            valueProvider.isMangoR1
                                                ? "Added"
                                                : "Add",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600,
                                                color: valueProvider.isMangoR1
                                                    ? Colors.white
                                                    : MyColors.black,
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
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white70,
                                    ),
                                    child: Center(
                                      child:
                                          Consumer<ProductCategoriesProvider>(
                                              builder:
                                                  (context, provider, child) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: AutoSizeText(
                                                  "Naan (+\$${valueProvider.naanAddOnsR1.toString()})",
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
                                                        .decrementR1,
                                                    icon: Icon(Icons.remove),
                                                  ),
                                                  Text(valueProvider
                                                      .counterAddOnsR1
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
                                                          .incrementR1();
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
                                        borderRadius: BorderRadius.circular(15),
                                        color: valueProvider.isNaanR1
                                            ? Colors.green.shade700
                                                .withOpacity(0.8)
                                            : Colors.white70,
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          valueProvider.toggleNaanR1();
                                          setState(() {});
                                        },
                                        child:
                                            Consumer<ProductCategoriesProvider>(
                                                builder:
                                                    (context, provider, child) {
                                          return AutoSizeText(
                                            valueProvider.isNaanR1
                                                ? "Added"
                                                : "Add",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600,
                                                color: valueProvider.isNaanR1
                                                    ? Colors.white
                                                    : MyColors.black,
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
                        ],
                      ),
                      ButtonToBuy(
                        // onTap: () async {
                        //   final SharedPreferences prefs = await SharedPreferences.getInstance();
                        //
                        //   // if(valueProvider.checkApIR1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkApIR1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                        //   //   prefs.setString("ApIR1", "Appetizer - I");
                        //   //   prefs.setString("ApIR1Value", valueProvider.checkApIR1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                        //   // }
                        //   // if(valueProvider.checkE1R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE1R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                        //   //   prefs.setString("E1R1", "Entree - I");
                        //   //   prefs.setString("E1R1Value", valueProvider.checkE1R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                        //   // }
                        //   // if(valueProvider.checkE2R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE2R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                        //   //   prefs.setString("E2R1", "Entree - II");
                        //   //   prefs.setString("E2R1Value", valueProvider.checkE2R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                        //   // }
                        //   // if(valueProvider.checkC1R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC1R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                        //   //   prefs.setString("C1R1", "Condiments - I");
                        //   //   prefs.setString("C1R1Value", valueProvider.checkC1R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                        //   // }
                        //   // if(valueProvider.checkDessertsR1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkDessertsR1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                        //   //   prefs.setString("DessertsR1", "Desserts");
                        //   //   prefs.setString("DessertsR1Value", valueProvider.checkDessertsR1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                        //   // }
                        //   //
                        //   // valueProvider.apIR1 = (prefs.getString("ApIR1") ?? '');
                        //   // valueProvider.apIR1Value = (prefs.getString("ApIR1Value") ?? '');
                        //   // valueProvider.e1R1 = (prefs.getString("E1R1") ?? '');
                        //   // valueProvider.e1R1Value = (prefs.getString("E1R1Value") ?? '');
                        //   // valueProvider.e2R1 = (prefs.getString("E2R1") ?? '');
                        //   // valueProvider.e2R1Value = (prefs.getString("E2R1Value") ?? '');
                        //   // valueProvider.c1R1 = (prefs.getString("C1R1") ?? '');
                        //   // valueProvider.c1R1Value = (prefs.getString("C1R1Value") ?? '');
                        //   // valueProvider.dessertsR1 = (prefs.getString("DessertsR1") ?? '');
                        //   // valueProvider.dessertsR1Value = (prefs.getString("DessertsR1Value") ?? '');
                        //   // print(valueProvider.apIR1);
                        //   // print(valueProvider.apIR1Value);
                        //   // print(valueProvider.e1R1);
                        //   // print(valueProvider.e1R1Value);
                        //   // print(valueProvider.e2R1);
                        //   // print(valueProvider.e2R1Value);
                        //   // print(valueProvider.c1R1);
                        //   // print(valueProvider.c1R1Value);
                        //   // print(valueProvider.dessertsR1);
                        //   // print(valueProvider.dessertsR1Value);
                        //
                        //
                        //
                        //
                        //
                        //   if(valueProvider.isPlatesR1 == true){
                        //     prefs.setString("PlatesAddOnsR1", "Spoon, Fork, Napkins (+\$0.25)");
                        //     prefs.setString("PlatesAddOnsQuantityR1", valueProvider.counterPlatesAddOnsR1.toString());
                        //     print("Quantity Plates ${valueProvider.counterPlatesAddOnsR1.toString()}");
                        //   }
                        //   if(valueProvider.isBottleR1 == true){
                        //     prefs.setString("BottleAddOnsR1", "Bottled Water (+\$0.50)");
                        //     prefs.setString("BottleAddOnsQuantityR1", valueProvider.counterBottleAddOnsR1.toString());
                        //     print("Quantity Bottle ${valueProvider.counterBottleAddOnsR1.toString()}");
                        //   }
                        //   if(valueProvider.isMangoR1 == true){
                        //     prefs.setString("MangoAddOnsR1", "Mango Juice (+\$1.00)");
                        //     prefs.setString("MangoAddOnsQuantityR1", valueProvider.counterMangoAddOnsR1.toString());
                        //     print("Quantity Mango ${valueProvider.counterMangoAddOnsR1.toString()}");
                        //   }
                        //   if(valueProvider.isNaanR1 == true){
                        //     prefs.setString("NaanAddOnsR1", "Naan (+\$0.50)");
                        //     prefs.setString("NaanAddOnsQuantityR1", valueProvider.counterAddOnsR1.toString());
                        //     print("Quantity Naan ${valueProvider.counterAddOnsR1.toString()}");
                        //   }
                        //
                        //   valueProvider.plateAddOnsR1Check = (prefs.getString('PlatesAddOnsR1') ?? '');
                        //   valueProvider.plateQuantityR1Check = (prefs.getString('PlatesAddOnsQuantityR1') ?? '');
                        //   valueProvider.bottleAddOnsR1Check = (prefs.getString('BottleAddOnsR1') ?? '');
                        //   valueProvider.bottleQuantityR1Check = (prefs.getString('BottleAddOnsQuantityR1') ?? '');
                        //   valueProvider.mangoAddOnsR1Check = (prefs.getString('MangoAddOnsR1') ?? '');
                        //   valueProvider.mangoQuantityR1Check = (prefs.getString('MangoAddOnsQuantityR1') ?? '');
                        //   valueProvider.naanAddOnsR1Check = (prefs.getString('NaanAddOnsR1') ?? '');
                        //   valueProvider.naanQuantityR1Check = (prefs.getString('NaanAddOnsQuantityR1') ?? '');
                        // },
                        onTap: () {
                          dbHelper!.insert(
                            ProductModel(
                              id: 1,
                              productId: widget.id.toString(),
                              name: widget.nameTitle.toString(),
                              initialPrice: valueProvider.priceR1,
                              productPrice: valueProvider.priceR1,
                              quantity: 1,
                              image: widget.image.toString(),
                              varData: '',
                            ),
                          )
                              .then((value) async {
                            valueProvider.addTotalPrice(valueProvider.priceR1);
                            valueProvider.addCounter();
                            setState(() {});
                            final SharedPreferences prefs = await SharedPreferences.getInstance();

                            if(valueProvider.checkApIR1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkApIR1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("ApIR1", "Appetizer - I");
                              prefs.setString("ApIR1Value", valueProvider.checkApIR1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE1R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE1R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E1R1", "Entree - I");
                              prefs.setString("E1R1Value", valueProvider.checkE1R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkE2R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkE2R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("E2R1", "Entree - II");
                              prefs.setString("E2R1Value", valueProvider.checkE2R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkC1R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkC1R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("C1R1", "Condiments - I");
                              prefs.setString("C1R1Value", valueProvider.checkC1R1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }
                            if(valueProvider.checkDessertsR1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString().isEmpty == false && valueProvider.checkDessertsR1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString() != 'None') {
                              prefs.setString("DessertsR1", "Desserts");
                              prefs.setString("DessertsR1Value", valueProvider.checkDessertsR1.where((checkbox) => checkbox.isSelected).map((checkbox) => checkbox.label).toList().join(', ').toString());
                            }

                            if(valueProvider.isPlatesR1 == true){
                              prefs.setString("PlatesAddOnsR1", "Spoon, Fork, Napkins (+\$0.25)");
                              prefs.setString("PlatesAddOnsQuantityR1", valueProvider.counterPlatesAddOnsR1.toString());
                            }
                            if(valueProvider.isBottleR1 == true){
                              prefs.setString("BottleAddOnsR1", "Bottled Water (+\$0.50)");
                              prefs.setString("BottleAddOnsQuantityR1", valueProvider.counterBottleAddOnsR1.toString());
                            }
                            if(valueProvider.isMangoR1 == true){
                              prefs.setString("MangoAddOnsR1", "Mango Juice (+\$1.00)");
                              prefs.setString("MangoAddOnsQuantityR1", valueProvider.counterMangoAddOnsR1.toString());
                            }
                            if(valueProvider.isNaanR1 == true){
                              prefs.setString("NaanAddOnsR1", "Naan (+\$0.50)");
                              prefs.setString("NaanAddOnsQuantityR1", valueProvider.counterAddOnsR1.toString());
                            }

                            valueProvider.plateAddOnsR1Check = (prefs.getString('PlatesAddOnsR1') ?? '');
                            valueProvider.plateQuantityR1Check = (prefs.getString('PlatesAddOnsQuantityR1') ?? '');
                            valueProvider.bottleAddOnsR1Check = (prefs.getString('BottleAddOnsR1') ?? '');
                            valueProvider.bottleQuantityR1Check = (prefs.getString('BottleAddOnsQuantityR1') ?? '');
                            valueProvider.mangoAddOnsR1Check = (prefs.getString('MangoAddOnsR1') ?? '');
                            valueProvider.mangoQuantityR1Check = (prefs.getString('MangoAddOnsQuantityR1') ?? '');
                            valueProvider.naanAddOnsR1Check = (prefs.getString('NaanAddOnsR1') ?? '');
                            valueProvider.naanQuantityR1Check = (prefs.getString('NaanAddOnsQuantityR1') ?? '');

                            valueProvider.apIR1 = (prefs.getString("ApIR1") ?? '');
                            valueProvider.apIR1Value = (prefs.getString("ApIR1Value") ?? '');
                            valueProvider.e1R1 = (prefs.getString("E1R1") ?? '');
                            valueProvider.e1R1Value = (prefs.getString("E1R1Value") ?? '');
                            valueProvider.e2R1 = (prefs.getString("E2R1") ?? '');
                            valueProvider.e2R1Value = (prefs.getString("E2R1Value") ?? '');
                            valueProvider.c1R1 = (prefs.getString("C1R1") ?? '');
                            valueProvider.c1R1Value = (prefs.getString("C1R1Value") ?? '');
                            valueProvider.dessertsR1 = (prefs.getString("DessertsR1") ?? '');
                            valueProvider.dessertsR1Value = (prefs.getString("DessertsR1Value") ?? '');
                            print(valueProvider.apIR1);
                            print(valueProvider.apIR1Value);
                            print(valueProvider.e1R1);
                            print(valueProvider.e1R1Value);
                            print(valueProvider.e2R1);
                            print(valueProvider.e2R1Value);
                            print(valueProvider.c1R1);
                            print(valueProvider.c1R1Value);
                            print(valueProvider.dessertsR1);
                            print(valueProvider.dessertsR1Value);


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
