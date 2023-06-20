import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/widgets/PasswordInputWidget.dart';
import 'package:provider/provider.dart';
import '../providers/UserProvider.dart';
import '../utilities/constants.dart';
import '../widgets/RoundedColoredButton.dart';
import '../global.dart' as global;

class Security extends StatelessWidget{

  const Security({super.key});
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
          Container(margin: const EdgeInsets.only(left: 20),child:const Text("Loading..." )),
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
    final current = TextEditingController();
    final newPassword=TextEditingController();
    final confirm=TextEditingController();
    late String actualValue;
    late String newValue;
    late String confirmValue;
    final userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
              color: Colors.black
          ),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 80,
            ),
            PasswordInputWidget(
                label: "Current password", controller: current),
            PasswordInputWidget(label: "New password", controller: newPassword),
            PasswordInputWidget(label: "Re-type new password", controller: confirm),
            const SizedBox(
              height: 35,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: RoundedColoredButton(
                  width: 350,
                  height: 50,
                  text: 'Save changes',
                  textColor: Colors.white,
                  fillColor: mountainMeadow,
                  shadowBlurRadius: 4,
                  onPressed: (){
                  actualValue = current.text;
                  newValue = newPassword.text;
                  confirmValue = confirm.text;
                  if(actualValue != global.globalSessionData?.encryptedPassword){
                    const snackBar = SnackBar(
                    content: Text('Actual Password incorrect'),
                    backgroundColor: (Colors.black),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else if(newValue != confirmValue){
                    const snackBar = SnackBar(
                    content: Text('Password confirmation incorrect'),
                    backgroundColor: (Colors.black),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                      showLoaderDialog(context);
                      userProvider.changePwd(newValue);
                      Navigator.of(context)
                          .pushNamed("/profile");
                      const snackBar = SnackBar(
                      content: Text('Password changed successfully'),
                      backgroundColor: (Colors.black),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }


      }),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: RoundedColoredButton(
                  width: 350,
                  height: 50,
                  text: 'Cancel',
                  textColor: Colors.black.withOpacity(0.6),
                  fillColor: Color(0xffbce4d4),
                  shadowBlurRadius: 0,
                  onPressed:  () {
                    Navigator.pushNamed(context, "/profile");
                  },
            )),
          ],
        ),
      ),
    );
  }

}