import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/utilities/constants.dart';
import 'package:innovit_2cs_project_paiement/widgets/RoundedColoredButton.dart';
import '../viewmodels/User.dart';

class EditProfile extends StatefulWidget{
  const EditProfile({super.key});
  @override
  _EditProfileState createState() => _EditProfileState();
}
class _EditProfileState extends State<EditProfile>{
  @override
  Widget build(BuildContext context) {
    User user=ModalRoute.of(context)!.settings.arguments as User;
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
                        user.name,
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
                        controller:TextEditingController(text: user.name),
                        decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: cadetGray, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:const BorderSide(width: 1, color: cadetGray),
                              borderRadius:  BorderRadius.circular(20.0),
                            ),
                            labelText: "Full Name"
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
                        controller:TextEditingController(text:user.email),
                        decoration: InputDecoration(
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
                        controller:TextEditingController(text: user.phone),
                        decoration: InputDecoration(
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 26),
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        controller:TextEditingController(text: user.location),
                        decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: cadetGray, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:const BorderSide(width: 1, color: cadetGray),
                              borderRadius:  BorderRadius.circular(20.0),
                            ),
                            labelText: "Location"
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
                          onPressed: () => {
                            // update query to the db
                          }),
                    )
                  ],
                ),
        ),
      ),
    );
  }

}

