import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/widgets/PasswordInputWidget.dart';
import '../utilities/constants.dart';
import '../widgets/RoundedColoredButton.dart';
import '../global.dart' as global;

class Security extends StatelessWidget{

  const Security({super.key});
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final current = TextEditingController();
    final newPassword=TextEditingController();
    final confirm=TextEditingController();
    late String actualValue;
    late String newValue;
    late String confirmValue;
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
                  onPressed: ()=>{}),
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
                    if (_formKey.currentState!.validate()) {
                      actualValue = current.text;
                      newValue = newPassword.text;
                      confirmValue = confirm.text;
                    }
                  },
            )),
          ],
        ),
      ),
    );    throw UnimplementedError();
  }

}