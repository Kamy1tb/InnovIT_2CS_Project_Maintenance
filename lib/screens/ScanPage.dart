import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/widgets/CustomBottomNavBar.dart';
import 'package:innovit_2cs_project_paiement/widgets/RoundedColoredButton.dart';

import '../utilities/constants.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Image.asset('assets/images/app_logo.png'),
          ),
          Text(
            'Scan your command from the vending machine\n screen',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          Container(
            child: Image.asset('assets/images/qr_code.png'),
          ),
          RoundedColoredButton(
              width: 260,
              height: 50,
              text: 'Confirm',
              textColor: Colors.white,
              fillColor: deepGreen,
              shadowBlurRadius: 0,
              onPressed: (){},
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        icon1: Icon(Icons.history),
        icon2: Icon(Icons.qr_code_scanner_outlined),
        icon3: Icon(Icons.person),
        label1: 'History',
        label2: 'Scan',
        label3: 'Profile',
        selectedItemColor: coffeeBrown,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
