import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class PasswordInputWidget extends StatelessWidget{
  String label;
  TextEditingController controller;
  PasswordInputWidget({
    Key? key,
    required this.label,
    required this.controller
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 30),
        child: TextField(
          controller: controller,
          obscureText: true,
          style: const TextStyle(
            fontSize: 14,
          ),
          decoration: InputDecoration(
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: cadetGray, width: 1.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: cadetGray),
                borderRadius:  BorderRadius.circular(20.0),
              ),
              hintText: label
          ),
        ),
      ),
    );
  }

}