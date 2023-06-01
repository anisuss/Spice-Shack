import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:spice_shack/widgets/navigation%20bar/navigation_bar_widget.dart';
import '../../model/api data model/prdoucts_model.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';
import '../../widgets/buttons/home_page_button_widget.dart';
import '../authentication screen/login_screen.dart';
import '../authentication screen/sign_up_screen.dart';
import '../categories list screen/model/temp.dart';
import '../products APi Functions/products_Functions_api.dart';
import '../products categories screen/model/api_data_model.dart';
import '../products categories screen/providers/product_categories_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<String> _taskModelList = [];

List<String> get taskModelList => _taskModelList;

class _HomeScreenState extends State<HomeScreen> {
  set taskModelList(String taskModel) {
    _taskModelList.add(taskModel);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductCategoriesProvider>(
        builder: (context, valueProvider, child) {
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),

                welcomeTextWidget(),
                spiceLogoWidget(),

                //Middle Spaces

                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 48.0, horizontal: 20.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Lottie.asset('assets/images/lottie/home.json'),
                  ),
                ),

                termsAndConditionsWidget(),
                //Login And SignUp Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomePageButtonWidget(
                        onTap: () {
                          valueProvider.temp =
                              Temp(ID: "", email: "", nick: "");
                          print(
                              "______________________: ${valueProvider.temp}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                              // builder: (context) => logScreen(),
                            ),
                          );
                        },
                        containerText: MyText.login),
                    HomePageButtonWidget(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        containerText: MyText.signUp),
                  ],
                ),

                continueAsGuestWidget(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget welcomeTextWidget() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: AutoSizeText(
            MyText.welcomeTo,
            style: AppTextStyle.spiceShackFonts(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: MyColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget spiceLogoWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Image.asset('assets/images/logo/spice-logo.png'),
    );
  }

  Widget termsAndConditionsWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 60,
          ),
          child: AutoSizeText(
            MyText.byUsingText,
            style: AppTextStyle.spiceShackFonts(
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w200,
                color: MyColors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 60,
            vertical: 8.0,
          ),
          child: AutoSizeText(
            MyText.privacyPolicy,
            style: AppTextStyle.spiceShackFonts(
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w200,
                color: MyColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget continueAsGuestWidget() {
    return Consumer<ProductCategoriesProvider>(
        builder: (context, valueProvider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: TextButton(
          onPressed: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NavigationBarWidget(),
              ),
            );
            valueProvider.temp = Temp(ID: "", email: "", nick: "");

            //Categories products list
            List<ProductListModel> productData =
                await ProductsFunctionsApi().getListOfProductsByCategories();
            valueProvider.updateDataProductCategoriesListModel(productData);

            //Categories list
            List<CartItemModel> myData =
                await ProductsFunctionsApi().getCategories();
            valueProvider.updateDataProductCategoriesModel(myData);

            //Catering list
            List<CartItemModel> myCatering =
                await ProductsFunctionsApi().getCatering();
            valueProvider.updateDataCateringModel(myCatering);
          },
          child: AutoSizeText(
            MyText.continueAsOurGuest,
            style: AppTextStyle.spiceShackFonts(
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: MyColors.white,
              ),
            ),
          ),
        ),
      );
    });
  }
}
