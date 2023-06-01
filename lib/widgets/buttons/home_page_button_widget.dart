import 'package:flutter/material.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';

class HomePageButtonWidget extends StatelessWidget {
  Function onTap;
  String containerText;
  HomePageButtonWidget({super.key, required this.onTap,required this.containerText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            color: MyColors.lightGrey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              containerText,
              style: AppTextStyle.spiceShackFonts(
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: MyColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
