import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';
import '../../screens/products categories screen/providers/product_categories_provider.dart';

class CheckBoxWidget extends StatelessWidget {
  String title;
  List checkList;
  Function onTap;

  CheckBoxWidget({super.key, required this.title,required this.onTap,required this.checkList,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText(
            title,
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
                    children: checkList
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
                                  //provider.updateSelectedCheckbox(index);
                                  onTap;
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
    );
  }
}
