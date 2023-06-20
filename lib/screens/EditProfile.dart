import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/utilities/constants.dart';
import 'package:innovit_2cs_project_paiement/widgets/RoundedColoredButton.dart';
import 'package:provider/provider.dart';
import '../providers/UserProvider.dart';
import '../viewmodels/User.dart';

class EditProfile extends StatefulWidget{
  const EditProfile({super.key});
  @override
  _EditProfileState createState() => _EditProfileState();
}
class _EditProfileState extends State<EditProfile>{
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final telController = TextEditingController();
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
          Container(margin: const EdgeInsets.only(left: 20),child:const Text("Editing Profile..." )),
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
    User user=ModalRoute.of(context)!.settings.arguments as User;
    final userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context).scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(user.image,))),
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    //edit profile picture
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Text(
                        " ${user.nom} ${user.prenom}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 26),
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        controller:prenomController,
                        decoration: InputDecoration(
                            hintText: user.prenom,
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff9BAEBC),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: cadetGray, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:const BorderSide(width: 1, color: cadetGray),
                              borderRadius:  BorderRadius.circular(20.0),
                            ),
                            labelText: "First Name"
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 26),
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        controller:nomController,
                        decoration: InputDecoration(
                            hintText: user.nom,
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff9BAEBC),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: cadetGray, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:const BorderSide(width: 1, color: cadetGray),
                              borderRadius:  BorderRadius.circular(20.0),
                            ),
                            labelText: "Last Name"
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 26),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        controller:emailController,
                        decoration: InputDecoration(
                            hintText: user.email,
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff9BAEBC),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: cadetGray, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: cadetGray),
                              borderRadius:  BorderRadius.circular(20.0),
                            ),
                            labelText: "Email"
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 26),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        controller:telController,
                        decoration: InputDecoration(
                            hintText: user.phone,
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff9BAEBC),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: cadetGray, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:const BorderSide(width: 1, color: cadetGray),
                              borderRadius:  BorderRadius.circular(20.0),
                            ),
                            labelText: "Phone Number"
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: RoundedColoredButton(
                          width: 350,
                          height: 50,
                          text: "Save changes",
                          textColor: Colors.white,
                          fillColor: mountainMeadow,
                          shadowBlurRadius: 4,
                          onPressed: () {
                            showLoaderDialog(context);
                            userProvider.editProfile(
                                nomController.text,
                                prenomController.text,
                                emailController.text,
                                telController.text,
                                user.password);
                          Navigator.of(context)
                              .pushNamed("/profile");
                          const snackBar = SnackBar(
                          content: Text('Profile edited successfully'),
                          backgroundColor: (Colors.black),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }),
                    )
                  ],
                ),
        ),
      ),
    );
  }

}

