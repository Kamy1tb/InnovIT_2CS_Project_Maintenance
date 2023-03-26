import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/utilities/constants.dart';
import 'package:innovit_2cs_project_paiement/widgets/RoundedColoredButton.dart';
import 'package:innovit_2cs_project_paiement/widgets/RoundedTextField.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Sign in now',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Image.asset('assets/images/app_logo.png'),
                ),
                Text(
                  'SmartBev',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: cadetGray,
                  ),
                ),
              ],
            ),
            RoundedTextField(
              HintText: 'Enter your email',
              hintTextSize: 17,
              borderColor: Color(0xff251201).withOpacity(0.2),
              selectedBorderColor: antiFlashWhite.withOpacity(0.7),
            ),
            RoundedTextField(
              HintText: 'Enter your password',
              hintTextSize: 17,
              borderColor: Color(0xff251201).withOpacity(0.2),
              selectedBorderColor: antiFlashWhite.withOpacity(0.7),
              trailingIcon: Icon(Icons.remove_red_eye_outlined),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.black,
                      value: false,
                      onChanged: (value) {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) =>
                            BorderSide(width: 1.0, color: Color(0xff9BAEBC)),
                      ),
                    ),
                    Text(
                      'Remember me',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xff9BAEBC),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Forgot password ?',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff9BAEBC),
                  ),
                ),
              ],
            ),
            RoundedColoredButton(
                width: 350,
                height: 50,
                text: 'Sign In',
                textColor: Colors.white,
                fillColor: cadetGray.withOpacity(0.7),
                shadowBlurRadius: 7,
                onPressed: () {}),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'or',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Container(
              width: 350,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xffD9D9D9))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.g_mobiledata_rounded,
                    size: 40,
                  ),
                  Text(
                    'Login with google',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don’t have an account ?  ',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 17,
                    color: cadetGray,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
