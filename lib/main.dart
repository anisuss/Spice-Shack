import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:spice_shack/resources/colors/colors_resources.dart';
import 'package:spice_shack/screens/products%20categories%20screen/providers/product_categories_provider.dart';
import 'package:spice_shack/screens/splash%20screen/splash_screen.dart';

import 'package:sizer/sizer.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_live_51MZe2yG6RhT0JMTC8AnIQu09JR12kTC6gzZB27NwQ1VFUe5WN0QPZTn3tXvqosUg5vq7OOI0xupwE8ye4NtzVzMa00VXX48WbV';

  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductCategoriesProvider(),
      child: Builder(builder: (BuildContext context) {
        return const SpiceSnack();
      }),
    ),
  );

}

class SpiceSnack extends StatelessWidget {
  const SpiceSnack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: MaterialColor(
                MyColors.brown.value,

                MyColors.getSwatch(MyColors.brown),

              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: const SplashScreen(),
            //home: ShowDataScreen(),
          );
        }
    );

  }
}

