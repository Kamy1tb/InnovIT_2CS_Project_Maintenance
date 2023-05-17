import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/utilities/constants.dart';
import '../widgets/RoundedColoredButton.dart';
import '../global.dart' as global;

class SignInPage extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height:100,
                  width: 100,
                  child: Image.asset('assets/logo/app_logo.png'),
                ),
                const Text(
                  'SmartBev',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: mountainMeadow,
                  ),
                ),
              ],
            ),
            const Center(
              child: Text(
                'Sign in now',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff9BAEBC),
                  ),
                  filled: false,
                  contentPadding: const EdgeInsets.only(left: 15,top: 5,bottom: 5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        width: 1,
                        color: cadetGray,
                    ),
                  )),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff9BAEBC),
                  ),
                  filled: false,
                  contentPadding: const EdgeInsets.only(left: 15,top: 5,bottom: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: cadetGray,
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
                            (states) => const BorderSide(
                            width: 1.0,
                            color: Colors.red
                        ),
                      ),
                    ),
                    const Text(
                      'Remember me',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff9BAEBC),
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Forgot password ?',
                  style: TextStyle(
                    fontSize: 14,
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
                fillColor: mountainMeadow,
                onPressed: () {
                  global.globalSessionData?.userId=4;
                  Navigator.of(context)
                      .pushNamed("/home");
                },
                shadowBlurRadius: 0),
            const Row(
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.g_mobiledata_rounded,
                    size: 30,
                  ),
                  Text(
                    'Login with google',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don’t have an account ?  ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 14,
                    color: mountainMeadow,
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