import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spice_shack/resources/colors/colors_resources.dart';

class InputTextField extends StatelessWidget {
  String hintText;
  bool obscure;
  TextEditingController textController;
  Widget prefixIcon;
  TextInputType textInputType;

  InputTextField({
    super.key,
    required this.hintText,
    required this.textController,
    required this.prefixIcon,
    required this.obscure,
    required this.textInputType, required String? Function(dynamic text) validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: TextFormField(
        controller: textController,
        obscureText: obscure,
        keyboardType: textInputType,
        style: TextStyle(color: MyColors.silver),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: MyColors.silver,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: MyColors.grey),
          ),
          hintText: hintText,
          prefixIcon: prefixIcon,
          hintStyle: TextStyle(color: MyColors.grey),
        ),
      ),
    );
  }
}
