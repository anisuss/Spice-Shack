import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/widgets/navigation%20bar/navigation_bar_widget.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';

import '../products categories screen/providers/product_categories_provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late ProductCategoriesProvider menuProductObject;
  static final customCacheManager = CacheManager(Config(
    'customCacheKey',
    stalePeriod: const Duration(days: 10),
    maxNrOfCacheObjects: 100,
  ));

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductCategoriesProvider(),
      child:
          Consumer<ProductCategoriesProvider>(builder: (context, value, child) {
        menuProductObject = value;
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
                            'assets/images/backgrounds/menu_products.jpg',
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
                                    "Spice Menu",
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
                                      const NavigationBarWidget(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.home_rounded,
                              size: 3.h,
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (menuProductObject.state == 0)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 48.0, horizontal: 20.0),
                      child: SizedBox(
                        height: 40.h,
                        width: 40.h,
                        child: Lottie.asset('assets/images/lottie/loader.json'),
                      ),
                    ),
                  ),
                Expanded(
                  flex: 13,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 10.sp
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
                          child: GridView.custom(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: SliverQuiltedGridDelegate(
                              crossAxisCount: 2,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              repeatPattern: QuiltedGridRepeatPattern.inverted,
                              pattern: const [
                                QuiltedGridTile(2, 2),
                                QuiltedGridTile(1, 1),
                              ],
                            ),
                            childrenDelegate: SliverChildBuilderDelegate(
                                childCount: menuProductObject.menuProducts.length,
                                (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: MyColors.silver),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
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
                                        imageUrl: menuProductObject
                                            .menuProducts[index].images![0]['src'],
                                        fit: BoxFit.cover,
                                        key: UniqueKey(),
                                        cacheManager: customCacheManager,
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
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(menuProductObject
                                              .menuProducts[index].name.toString(),maxLines: 1,
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
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 4.h,
                                                width: 8.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    color: Colors.black
                                                        .withOpacity(0.7)),
                                                child: Center(
                                                  child: Text(
                                                    "\$ ${menuProductObject.menuProducts[index].price.toString()}",
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        height: 1.2,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: MyColors.silver,
                                                      ),
                                                    ),
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
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
