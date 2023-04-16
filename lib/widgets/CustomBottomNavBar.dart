import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomBottomNavBar extends StatefulWidget {

   Icon icon1;
   Icon icon2;
   Icon icon3;

   String label1;
   String label2;
   String label3;

   Color selectedItemColor;
   Color unselectedItemColor;

   CustomBottomNavBar({
    Key? key,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    required this.label1,
    required this.label2,
    required this.label3,
    required this.selectedItemColor,
    required this.unselectedItemColor,
  }) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 12
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)
        ),
        child: BottomNavigationBar(
          selectedItemColor: widget.selectedItemColor,
          unselectedItemColor: widget.unselectedItemColor,
          items: [
            BottomNavigationBarItem(
                icon: widget.icon1,
                label: widget.label1
            ),
            BottomNavigationBarItem(
              icon: widget.icon2,
              label: widget.label2,
            ),
            BottomNavigationBarItem(
              icon: widget.icon3,
              label: widget.label3,
            ),
          ],
        ),
      ),
    );
  }
}
