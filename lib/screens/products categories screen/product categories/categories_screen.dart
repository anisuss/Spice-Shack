import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../model/api data model/prdoucts_model.dart';
import '../../../resources/colors/colors_resources.dart';
import '../../cart screen/cart_screen.dart';
import '../../categories list screen/screen/products_by_categories_list.dart';
import '../../nav slider screen/nav_bar_slider.dart';
import '../../products APi Functions/products_Functions_api.dart';
import '../providers/product_categories_provider.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:badges/src/badge.dart' as badge;


class ProductCategoriesScreen extends StatefulWidget {

  const ProductCategoriesScreen({super.key});

  @override
  State<ProductCategoriesScreen> createState() =>
      _ProductCategoriesScreenState();
}
String _myStateId = "";
String get myStateId => _myStateId;
class _ProductCategoriesScreenState extends State<ProductCategoriesScreen> {


  set myStateId(String value) {
    _myStateId = value;
  }


  final sliderImages = [
    'assets/images/backgrounds/food.jpg',
    'assets/images/cart backgrounds/food-5.jpg',
    'assets/images/cart backgrounds/food-6.jpg',
    'assets/images/cart backgrounds/food-7.jpg',
  ];


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldGlobalKey = GlobalKey();

    return Consumer<ProductCategoriesProvider>(
        builder: (context, valueProvider, child) {
      return Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            key: scaffoldGlobalKey,
            drawer: const NavBarSlider(),
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
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28.0.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () async {
                                scaffoldGlobalKey.currentState
                                    ?.openDrawer();
                              },
                              icon: Icon(
                                Icons.menu,
                                color: MyColors.white,
                                size: 3.h,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(1.0.sp),
                              child: Image.asset(
                                  'assets/images/logo/spice-logo.png'),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CartScreen(),
                                    ),
                                  );
                                },
                                child: badge.Badge(
                                  badgeContent:
                                      Consumer<ProductCategoriesProvider>(
                                    builder: (context, value, child) {
                                      return Text(
                                        value.getCounter().toString(),
                                        style: TextStyle(
                                          color: MyColors.white,
                                        ),
                                      );
                                    },
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
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CarouselSlider.builder(
                        itemCount: sliderImages.length,
                        itemBuilder: (context, index, realIndex) {
                          final sliderImg = sliderImages[index];
                          if(index == 0)
                            {
                              return buildCoupon(index);
                            }
                          return buildImage(sliderImg, index);
                        },
                        options: CarouselOptions(
                          height: 50.h,
                          autoPlayAnimationDuration: const Duration(seconds: 2),
                          onPageChanged: (index, reason) {
                            valueProvider.updateSlider(index);
                          },
                          autoPlay: true,
                          reverse: false,
                          enableInfiniteScroll: false,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: AnimatedSmoothIndicator(
                        activeIndex: valueProvider.activeIndex,
                        count: sliderImages.length,
                        effect: WormEffect(
                          dotHeight: 1.h,
                          dotWidth: 1.h,
                          activeDotColor: MyColors.red3,
                          dotColor: MyColors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          if (valueProvider.state == 0)
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
                            Expanded(
                              child: ListView.builder(
                                itemCount: valueProvider.dataProductList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5.0.sp),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: MyColors.silver,width: 2),
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          height: 30.h,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 30.h,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
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
                                                    imageUrl: valueProvider.dataProductList[index].image!["src"].toString(),
                                                    fit: BoxFit.cover,
                                                    key: UniqueKey(),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(30),
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.bottomRight,
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(.5),
                                                          Colors.black
                                                              .withOpacity(.3),
                                                        ],),),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text(
                                                      Bidi.stripHtmlIfNeeded( valueProvider.dataProductList[index].name.toString(),),maxLines: 3,textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        myStateId = valueProvider.dataProductList[index].id.toString();
                                                      // print("check my Image Url  ${valueProvider.dataProductList[index].images![0]["src"].toString()}");
                                                      valueProvider.productState= 0;
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => ProductsListByCategories(nameTitle: valueProvider.dataProductList[index].name.toString()),
                                                            ),);
                                                        if (kDebugMode) {
                                                          print('Name :- ${valueProvider.dataProductList[index].name}');
                                                        }
                                                        if (kDebugMode) {
                                                          print('Id :- ${valueProvider.dataProductList[index].id}');
                                                        }
                                                        if (kDebugMode) {
                                                          print('Index :- $index');
                                                        }
                                                        // products list
                                                        List<ProductListModel>productData = await ProductsFunctionsApi().getListOfProductsByCategories();
                                                        valueProvider.updateDataProductCategoriesListModel(productData);
                                                      },
                                                      child: Container(
                                                        height: 6.h,
                                                        margin:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 44.sp),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10),
                                                            color: Colors.white),
                                                        child: Center(
                                                          child: Text(
                                                            "Order Now",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[900],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
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

  Widget buildCoupon(int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CouponCard(
          height: MediaQuery.of(context).size.height * 0.1,
          backgroundColor: Colors.red.withOpacity(0.6),
          curveAxis: Axis.vertical,
          firstChild: Container(
            decoration: BoxDecoration(
              color: Colors.yellow.withOpacity(0.6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          '20%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: Colors.white54, height: 0),

              ],
            ),
          ),
          secondChild: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Coupon Code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'SPICY30',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'MIN SPENT \$30\nSpice Offer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFF3D67D),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}
