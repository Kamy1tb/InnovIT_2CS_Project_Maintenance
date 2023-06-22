import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/utilities/constants.dart';
import 'package:provider/provider.dart';
import '../providers/UserProvider.dart';
import '../widgets/RoundedColoredButton.dart';
import '../global.dart' as global;

class SignInPage extends StatelessWidget{
  final emailController = TextEditingController();
  final passwordController=TextEditingController();

  SignInPage({super.key});
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.black26,
            valueColor: AlwaysStoppedAnimation<Color>(
              mountainMeadow, //<-- SEE HERE
            ),
          ),
          Container(margin: const EdgeInsets.only(left: 20),child:Text("Signing In..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
                SizedBox(
                  height:130,
                  width: 130,
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
            const SizedBox(
              height:10,
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
              obscureText: true,
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
            RoundedColoredButton(
                width: 350,
                height: 50,
                text: 'Sign In',
                textColor: Colors.white,
                fillColor: mountainMeadow,
                onPressed: () async {
                  showLoaderDialog(context);
                  final logged = await userProvider.login(emailController.text,passwordController.text);
                  global.globalSessionData?.encryptedPassword=passwordController.text;
                  if(logged){
                    FirebaseMessaging messaging = FirebaseMessaging.instance;
                    String? token = await messaging.getToken();
                    userProvider.addToken(token!);
                    userProvider.userInfo();
                    Navigator.of(context)
                        .pushNamed("/home");
                  }else{
                    Navigator.pop(context);
                    const snackBar = SnackBar(
                      content: Text('Login failed'),
                      backgroundColor: pastelRed,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                shadowBlurRadius: 0),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.15,
            ),
          ],
        ),
      ),
    );
  }
  
}