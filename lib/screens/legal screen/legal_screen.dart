import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';
import '../../widgets/buttons/legal_buttons_widget.dart';

class LegalScreen extends StatefulWidget {
  const LegalScreen({Key? key}) : super(key: key);

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: MediaQuery.of(context).padding,
          child: Column(
            children: [
              appBarWidget(context),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Column(
                    children: [
                      LegalScreenWidgets(onTap: (){}, text:  MyText.privacy,),
                      LegalScreenWidgets(onTap: (){}, text:  MyText.termsConditions,),
                      LegalScreenWidgets(onTap: (){}, text:  MyText.yourAdvertisingChoices,),
                      LegalScreenWidgets(onTap: (){}, text:  MyText.doNotSell,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarWidget(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: GradientsConstants.redGradient,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: MyColors.white,
                size: MediaQuery.of(context).size.width * 0.08,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            AutoSizeText(
              MyText.legal,
              textAlign: TextAlign.start,
              style: AppTextStyle.spiceShackFonts(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: MyColors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
