import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../widgets/CustomBottomNavBar.dart';
import '../widgets/ProfileMenuWidget.dart';
import '../widgets/RoundedColoredButton.dart';

class Profile extends StatelessWidget{
  String link='https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250';
  String name='Afnane Touhar';
  String email='ja_afnane@esi.dz';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(link),
              radius: 50,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black
                ),
              ),
            ),
            Text(
              email,
              style: const TextStyle(
                fontSize: 13,
                color: cadetGray
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            ProfileMenuWidget(
                icon: const Icon(Icons.person),
                label: 'Edit Profile'),
            ProfileMenuWidget(
                icon: const Icon(Icons.notifications),
                label: 'Notifications'),
            ProfileMenuWidget(
                icon: const Icon(Icons.checklist_rtl),
                label: 'Tasks List'),
            ProfileMenuWidget(
                icon: const Icon(Icons.admin_panel_settings),
                label: 'Security'),
            ProfileMenuWidget(
                icon: const Icon(Icons.help),
                label: 'Help'),
            const SizedBox(
              height: 35,
            ),
            RoundedColoredButton(
                width: 350,
                height: 50,
                text: 'Logout',
                textColor: Colors.white,
                fillColor: pastelRed,
                shadowBlurRadius: 8,
                onPressed: ()=>{})
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        icon1: const Icon(Icons.notifications),
        icon2: const Icon(Icons.checklist_rtl),
        icon3: const Icon(Icons.person),
        label1: 'Notifications',
        label2: "task's list",
        label3: 'Profile',
        selectedItemColor: mountainMeadow,
        unselectedItemColor: Colors.black,

      ),    );
    throw UnimplementedError();
  }

}