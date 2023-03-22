import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundedColoredButton extends StatelessWidget {
  double width;
  double height;
  Color textColor;
  Color fillColor;
  String text;
  VoidCallback onPressed;

  RoundedColoredButton({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    required this.textColor,
    required this.fillColor,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size(
              this.width,
              this.height,
          )),
          foregroundColor: MaterialStateProperty.all(this.textColor),
          backgroundColor: MaterialStateProperty.all(this.fillColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: this.onPressed,
        child: Text(
          this.text,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400
          ),
        )
    );
  }
}
