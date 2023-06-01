import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../cart data/database/db_helper.dart';
import '../../cart data/model/cart_model.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../order screen/order_screen.dart';
import '../products categories screen/providers/product_categories_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}
double _billTotal = 0.0;
List my = [];

double get billTotal => _billTotal;
String _profileEmail = '';
String get profileEmail => _profileEmail;
String _profileName = '';
String get profileName => _profileName;
int _lengthCartList = 0;
int get lengthCartList => _lengthCartList;


class _CartScreenState extends State<CartScreen> {
  set lengthCartList(int value) {
    _lengthCartList = value;
  }
  set billTotal(double value) {
    _billTotal = value;
  }
  set profileEmail(String value) {
    _profileEmail = value;
  }
  set profileName(String value) {
    _profileName = value;
  }
  DBHelper? dbHelper = DBHelper();
  List<bool> tapped = [];

  @override
  void initState() {
    super.initState();
    _checkSharedPrefsDataLocation();
    context.read<ProductCategoriesProvider>().getData();
  }


  bool showButtonsLocation = true;



  Future<void> _checkSharedPrefsDataLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool sharedData = prefs.getBool('sharedDataLocation') ?? false;
    if (sharedData) {
      setState(() {
        showButtonsLocation = false;
      });
    }
  }

  Future<void> _saveToSharedPrefsLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sharedDataLocation', true);
    setState(() {
      showButtonsLocation = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ProductCategoriesProvider>(context);
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 21.0,
                  left: 20.0,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: MyColors.white,
                      ),
                    ),
                    AutoSizeText(
                      "Cart",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.spiceShackFonts(
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Consumer<ProductCategoriesProvider>(
                  builder: (BuildContext context, provider, widget) {
                    if (provider.cart.isEmpty) {
                      return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: SizedBox(

                                  height:
                                  MediaQuery.of(context).size.height *
                                      0.1,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    child: Lottie.asset(
                                      'assets/images/lottie/checkBrown.json',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(padding: const EdgeInsets.all(20),child: Container(
                                height: 30.h,
                                width: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/cart backgrounds/undraw_empty_cart_co35.png',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),),
                            ],
                          ),);
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.1,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      child: Lottie.asset(
                                        'assets/images/lottie/check2.json',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                Consumer<ProductCategoriesProvider>(
                                  builder: (BuildContext context, value,
                                      Widget? child) {
                                    final ValueNotifier<double?> totalPrice =
                                        ValueNotifier(null);
                                    for (var element in value.cart) {
                                      /*billTotal = (element.productPrice! *
                                          element.quantity!.value) +
                                          (totalPrice.value ?? 0);*/
                                      totalPrice.value =
                                          (element.productPrice! *
                                                  element.quantity!.value) +
                                              (totalPrice.value ?? 0);
                                    }
                                    return Visibility(
                                      visible:
                                          value.totalPrice.toStringAsFixed(2) ==
                                                  "0.00"
                                              ? false
                                              : true,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 9.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: MyColors.silver),
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomRight,
                                                colors: [
                                                  Colors.black.withOpacity(.4),
                                                  Colors.black.withOpacity(.5),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ValueListenableBuilder<double?>(
                                                      valueListenable:
                                                          totalPrice,
                                                      builder: (context, val,
                                                          child) {
                                                        return ReusableWidget(
                                                            title: 'Total',
                                                            value: r'$' +
                                                                (val?.toStringAsFixed(
                                                                        2) ??
                                                                    '0'));
                                                      }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                  },
                                ),

                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: provider.cart.length,
                                      itemBuilder:
                                          (BuildContext context, int index)
                                          {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: GradientsConstants
                                                  .blackGradient,
                                              border: Border.all(
                                                  width: 1,
                                                  color: MyColors.grey),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(30),
                                              ),
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.13,
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.13,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  decoration: BoxDecoration(
                                                    gradient: GradientsConstants
                                                        .blackGradient,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(30),
                                                      bottomRight:
                                                          Radius.circular(30),
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(30),
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(30),
                                                      bottomRight:
                                                          Radius.circular(30),
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(30),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      placeholder:
                                                          (context, url) =>
                                                              Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .bottomRight,
                                                            colors: [
                                                              Colors.white
                                                                  .withOpacity(
                                                                      .4),
                                                              Colors.brown
                                                                  .withOpacity(
                                                                      .5),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      imageUrl: provider
                                                          .cart[index].image!,
                                                      fit: BoxFit.cover,
                                                      key: UniqueKey(),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 40.w,
                                                        child: AutoSizeText(
                                                          provider.cart[index]
                                                              .productName!,
                                                          maxLines: 1,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: AppTextStyle
                                                              .spiceShackFonts(
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: MyColors
                                                                  .white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          ValueListenableBuilder<
                                                                  int>(
                                                              valueListenable:
                                                                  provider
                                                                      .cart[
                                                                          index]
                                                                      .quantity!,
                                                              builder: (context,
                                                                  val, child) {
                                                                return PlusMinusButtons(
                                                                  addQuantity:
                                                                      () {
                                                                    cart.addQuantity(
                                                                        provider
                                                                            .cart[index]
                                                                            .id!);
                                                                    dbHelper!
                                                                        .updateQuantity(Cart(
                                                                            id:
                                                                                index,
                                                                            productId:
                                                                                index.toString(),
                                                                            productName: provider.cart[index].productName,
                                                                            initialPrice: provider.cart[index].initialPrice,
                                                                            productPrice: provider.cart[index].productPrice,
                                                                            quantity: ValueNotifier(provider.cart[index].quantity!.value),
                                                                            image: provider.cart[index].image, varData: ""))
                                                                        .then((value) {
                                                                      cart.addTotalPrice(double.parse(provider
                                                                          .cart[index]
                                                                          .productPrice
                                                                          .toString()));
                                                                    });
                                                                  },
                                                                  deleteQuantity:
                                                                      () {
                                                                    cart.deleteQuantity(
                                                                        provider
                                                                            .cart[index]
                                                                            .id!);
                                                                    cart.removeTotalPrice(double.parse(provider
                                                                        .cart[
                                                                            index]
                                                                        .productPrice
                                                                        .toString()));
                                                                  },
                                                                  text: val
                                                                      .toString(),
                                                                );
                                                              }),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: TextSpan(
                                                          text: "Price",
                                                          style: AppTextStyle
                                                              .spiceShackFonts(
                                                            style: TextStyle(
                                                              height: 1.2,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: MyColors
                                                                  .silver,
                                                            ),
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: ' ',
                                                              style: AppTextStyle
                                                                  .spliceSans(
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 11,
                                                                ),
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: '\$ ',
                                                              recognizer:
                                                                  TapGestureRecognizer()
                                                                    ..onTap =
                                                                        () {
                                                                      //print('Moon');
                                                                    },
                                                              style: AppTextStyle
                                                                  .spliceSans(
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 11,
                                                                  color: MyColors
                                                                      .yellow,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: provider
                                                                  .cart[index]
                                                                  .productPrice!
                                                                  .toString(),
                                                              recognizer:
                                                                  TapGestureRecognizer()
                                                                    ..onTap =
                                                                        () {
                                                                      //print('Moon');
                                                                    },
                                                              style: AppTextStyle
                                                                  .spliceSans(
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 11,
                                                                  color: MyColors
                                                                      .yellow,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.delete_rounded,
                                                    color: MyColors.silver,
                                                  ),
                                                  onPressed: () {
                                                    dbHelper!.deleteCartItem(
                                                        provider
                                                            .cart[index].id!);
                                                    provider.removeItem(provider
                                                        .cart[index].id!);
                                                    provider.removeCounter();
                                                    setState(() {

                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                      ),
                                ),
                                Consumer<ProductCategoriesProvider>(
                                  builder: (context, value, child) {
                                    return  Visibility (
                                      visible: value.getTotalPrice().toStringAsFixed(2) == "0.00" ? false : true,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: /*showButtonsLocation ? Container(
                                          decoration: BoxDecoration(
                                            gradient: GradientsConstants.redGradient,
                                            borderRadius: BorderRadius.circular(20.0),
                                            border: Border.all(
                                                width: 1, color: MyColors.silver),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 0.0,
                                              horizontal: 100,
                                            ),
                                            child: TextButton(
                                              onPressed: () async {
                                                if(cart.stateEmail.isNotEmpty){
                                                  profileEmail = cart.stateEmail;
                                                  profileName = cart.stateName;
                                                }else{
                                                  profileEmail = cart.temp!.email;
                                                  profileName = cart.temp!.nick;
                                                }
                                                billTotal = cart.totalPrice;
                                                // cart.loadData();

                                                // MyNewList().my = await dbHelper?.getCartList() as List<Cart>;
                                                lengthCartList = provider.cart.length;
                                                cart.quantityList.clear();
                                                cart.idGrowableList.clear();
                                                for(int i=0;i<provider.cart.length;i++)
                                                {
                                                  cart.idGrowableList.add(provider.cart[i].productId.toString());
                                                  cart.quantityList.add(provider.cart[i].quantity!.value.toString());
                                                  if(provider.cart[i].varData.toString().isNotEmpty){
                                                    cart.variationId.add(provider.cart[i].varData.toString());
                                                  }
                                                }

                                                for(int i=0;i<cart.variationId.length;i++)
                                                {
                                                  print(cart.variationId.toString());
                                                }



                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) => AlertDialog(
                                                    title: const Text('Location Permission'),
                                                    content: const Text('To provide you with the best food delivery experience, we require your permission to access your location even when the app is in the background.'),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text('Cancel'),
                                                        onPressed: () async {
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text('Ok'),
                                                        onPressed: () async {
                                                          _saveToSharedPrefsLocation();
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                              const OrderScreen(),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );





                                              },
                                              child: AutoSizeText(
                                                "Check Out",
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.spiceShackFonts(
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                    color: MyColors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ) : */
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: GradientsConstants.redGradient,
                                            borderRadius: BorderRadius.circular(20.0),
                                            border: Border.all(
                                                width: 1, color: MyColors.silver),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 0.0,
                                              horizontal: 100,
                                            ),
                                            child: TextButton(
                                              onPressed: () async {
                                                if(cart.stateEmail.isNotEmpty){
                                                  profileEmail = cart.stateEmail;
                                                  profileName = cart.stateName;
                                                }else{
                                                  profileEmail = cart.temp!.email;
                                                  profileName = cart.temp!.nick;
                                                }
                                                billTotal = cart.totalPrice;
                                                // cart.loadData();

                                                // MyNewList().my = await dbHelper?.getCartList() as List<Cart>;
                                                lengthCartList = provider.cart.length;
                                                cart.quantityList.clear();
                                                cart.idGrowableList.clear();
                                                for(int i=0;i<provider.cart.length;i++)
                                                  {
                                                    cart.idGrowableList.add(provider.cart[i].productId.toString());
                                                    cart.quantityList.add(provider.cart[i].quantity!.value.toString());
                                                    if(provider.cart[i].varData.toString().isNotEmpty){
                                                      cart.variationId.add(provider.cart[i].varData.toString());
                                                    }
                                                  }

                                                for(int i=0;i<cart.variationId.length;i++)
                                                {
                                                  print(cart.variationId.toString());
                                                }


                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                    const OrderScreen(),
                                                  ),
                                                );





                                              },
                                              child: AutoSizeText(
                                                "Check Out",
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.spiceShackFonts(
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                    color: MyColors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;

  const PlusMinusButtons(
      {Key? key,
      required this.addQuantity,
      required this.deleteQuantity,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: deleteQuantity,
          icon: Icon(
            Icons.remove_circle_outline_rounded,
            color: MyColors.white,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.start,
          style: AppTextStyle.spiceShackFonts(
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: MyColors.white,
            ),
          ),
        ),
        IconButton(
          onPressed: addQuantity,
          icon: Icon(
            Icons.add_circle_outline_rounded,
            color: MyColors.white,
          ),
        ),
      ],
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;

  const ReusableWidget({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            title,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: AppTextStyle.spiceShackFonts(
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: MyColors.white,
              ),
            ),
          ),
          AutoSizeText(
            value,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: AppTextStyle.spiceShackFonts(
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: MyColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
