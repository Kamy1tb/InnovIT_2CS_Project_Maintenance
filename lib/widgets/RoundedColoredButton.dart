import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundedColoredButton extends StatelessWidget {
  double width;
  double height;
  Color textColor;
  Color fillColor;
  String text;
  VoidCallback onPressed;
  double shadowBlurRadius;


  RoundedColoredButton({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    required this.textColor,
    required this.fillColor,
    required this.shadowBlurRadius,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0,horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: this.shadowBlurRadius,
          ),
        ],
      ),
      child: TextButton(
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
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),
          )
      ),
    );
  }
}
