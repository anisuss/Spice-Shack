import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../cart data/database/db_helper.dart';
import '../../../cart data/model/cart_model.dart';
import '../../../resources/colors/colors_resources.dart';
import '../../../resources/colors/gradient_colors.dart';
import '../../../resources/text/fonts.dart';
import '../../cart screen/cart_screen.dart';
import '../../products categories screen/providers/product_categories_provider.dart';
import 'package:badges/src/badge.dart' as badge;


class ProductsListByCategories extends StatefulWidget {
  final String nameTitle;
  ProductsListByCategories({super.key, required this.nameTitle});

  @override
  State<ProductsListByCategories> createState() =>
      _ProductsListByCategoriesState();
}

class _ProductsListByCategoriesState extends State<ProductsListByCategories> {

  DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductCategoriesProvider>(
        builder: (context, valueProvider, child) {
      print(valueProvider.productState);
      return Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          Container(
                            height: 30.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: GradientsConstants.blackGradient,
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/backgrounds/add_items.jpg',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: MyColors.silver),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 3.h,
                                    color: MyColors.white,
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
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
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
                    ),
                    listData(valueProvider, context),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget listData(ProductCategoriesProvider valueProvider, BuildContext context) {
    if (valueProvider.productState == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 20.0),
        child: SizedBox(
          height: 40.h,
          width: 40.h,
          child: Lottie.asset('assets/images/lottie/loader.json'),
        ),
      );
    }
    return Expanded(
      flex: 7,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.0,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            itemCount: valueProvider.productsCategoriesList.length,
            //itemCount: newRandom.length,
            itemBuilder: (BuildContext ctx, index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColors.white),
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.red.withOpacity(.4),
                              Colors.brown.withOpacity(.5),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),

                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: MyColors.silver),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        colors: [
                                          Colors.white.withOpacity(.4),
                                          Colors.brown.withOpacity(.5),
                                        ],
                                      ),
                                    ),
                                  ),
                                  imageUrl: valueProvider
                                      .productsCategoriesList[index].images![0]["src"]
                                      .toString(),
                                  fit: BoxFit.cover,
                                  key: UniqueKey(),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  colors: [
                                    Colors.black.withOpacity(.1),
                                    Colors.black.withOpacity(.1),
                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: 8.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        colors: [
                                          Colors.brown.withOpacity(.2),
                                          Colors.brown.withOpacity(.3),
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        valueProvider.productsCategoriesList[index].name
                                            .toString(),
                                        style: AppTextStyle.spiceShackFonts(
                                          style: TextStyle(
                                            height: 1.2,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: MyColors.silver,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 4.h,
                                          width: 8.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.black.withOpacity(0.7)),
                                          child: Center(
                                            child: Text(
                                              "\$ ${valueProvider.productsCategoriesList[index].price.toString()}",
                                              style: AppTextStyle.spiceShackFonts(
                                                style: TextStyle(
                                                  height: 1.2,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: MyColors.silver,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (kDebugMode) {
                                              print(index);
                                            }
                                            if (kDebugMode) {
                                              print(valueProvider
                                                  .productsCategoriesList[index].name
                                                  .toString());
                                            }
                                            if (kDebugMode) {
                                              print(valueProvider
                                                  .productsCategoriesList[index].price
                                                  .toString());
                                            }
                                            if (kDebugMode) {
                                              print('1');
                                            }

                                            dbHelper.insert(
                                              Cart(
                                                id: index,
                                                productId: valueProvider.productsCategoriesList[index].id.toString(),
                                                productName: valueProvider.productsCategoriesList[index].name.toString(),
                                                initialPrice: double.parse(valueProvider.productsCategoriesList[index].price.toString()),
                                                productPrice: double.parse(valueProvider.productsCategoriesList[index].price.toString()),
                                                quantity: ValueNotifier(1),
                                                image: valueProvider.productsCategoriesList[index].images![0]["src"].toString(),
                                                varData: "",
                                              ),
                                            )
                                                .then((value) {
                                              valueProvider.addTotalPrice(double.parse(valueProvider.productsCategoriesList[index].price.toString()));
                                              valueProvider.addCounter();
                                              print('Product Added to cart');
                                            }).onError((error, stackTrace) {
                                              print(error.toString());
                                            });
                                          },
                                          child: Container(
                                            height: 6.h,
                                            width: 6.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.white),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Lottie.asset(
                                                  'assets/images/lottie/cart.json'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
            }),
      ),
    );
  }

  Widget buildImage(String sliderImg, int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                sliderImg,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
