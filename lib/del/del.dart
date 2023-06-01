import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/products categories screen/providers/product_categories_provider.dart';

class MyHomePage extends StatelessWidget {

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final couponProviders = Provider.of<ProductCategoriesProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter data',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                //Provider.of<ProductCategoriesProvider>(context, listen: false).fetchDataOfGiftsCard(_textEditingController.text);
                //Provider.of<ProductCategoriesProvider>(context, listen: false).fetchDataOfGiftsCard("CU9D-45HQ-8LGS-PC8F");
                // String myString = "10.00000000";
                // myString = myString.substring(0, myString.indexOf("."));
                // int myNumber = int.parse(myString);
                // print(myNumber);
                // Provider.of<ProductCategoriesProvider>(context, listen: false).subtractFromTotal("CU9D-45HQ-8LGS-PC8F");
                print(couponProviders.myDataList);
                couponProviders.myDataList.clear();
                print(couponProviders.myDataList);
              },
              child: Text('Fetch data and subtract'),
            ),
            SizedBox(height: 16.0),
            Consumer<ProductCategoriesProvider>(
              builder: (context, provider, child) {
                return Text('Total: ${provider.total}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
