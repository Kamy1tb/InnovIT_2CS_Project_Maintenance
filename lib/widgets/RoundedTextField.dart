import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  String HintText;
  double hintTextSize;
  Color borderColor;
  Color selectedBorderColor;
  Icon? trailingIcon;
  RoundedTextField({
    Key? key,
    required this.HintText,
    required this.hintTextSize,
    required this.borderColor,
    required this.selectedBorderColor,
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: this.HintText,
          hintStyle: TextStyle(
            fontSize: this.hintTextSize,
            color: Color(0xff9BAEBC),
          ),
          filled: false,
          contentPadding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                width: 1,
                color: this.borderColor
            ),
          ),
          focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1, color: this.selectedBorderColor),
        ),
          suffixIcon: this.trailingIcon,
      ),
    );
  }
}
