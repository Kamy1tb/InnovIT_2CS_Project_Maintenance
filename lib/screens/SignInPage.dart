import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/utilities/constants.dart';
import 'package:innovit_2cs_project_paiement/widgets/RoundedColoredButton.dart';

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
                    color: coffeeBrown,
                  ),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: Color(0xff9BAEBC),
                  ),
                  filled: false,
                  contentPadding: EdgeInsets.only(left: 15,top: 5,bottom: 5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.greenAccent
                    ),
                  )),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: Color(0xff9BAEBC),
                  ),
                  filled: false,
                  contentPadding: EdgeInsets.only(left: 15,top: 5,bottom: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Color(0xff251201),
                    ),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: false,
                        onChanged: (value){},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                                  width: 1.0,
                                  color: Colors.red
                              ),
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
            RoundedColoredButton(width: 350, height: 50, text: 'Sign In', textColor: Colors.white, fillColor: coffeeBrown.withOpacity(0.7), onPressed: (){})
          ],
        ),
      ),
    );
  }
}
