import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spice_shack/screens/products%20categories%20screen/providers/product_categories_provider.dart';

class CheckCateringScreen extends StatefulWidget {
  const CheckCateringScreen({Key? key}) : super(key: key);

  @override
  State<CheckCateringScreen> createState() => _CheckCateringScreenState();
}

class _CheckCateringScreenState extends State<CheckCateringScreen> {

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ProductCategoriesProvider>(context);

    return Scaffold(
      backgroundColor: Colors.greenAccent.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 300,
              width: double.infinity,
              child: ListView.builder(
             itemCount: 3,
              itemBuilder: (_, index) {
            return Column(

              children: [
                Text("Name : {cart.cateringProductsList[index].name.toString()}"),
                Text("Length : ${cart.cateringProductsList.length.toString()}"),
              ],
            );
          })),
        ],
      ),
    );
  }
}
