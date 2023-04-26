import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../widgets/ProfileMenuWidget.dart';
import '../widgets/RoundedColoredButton.dart';

class ProfileInfos{
  String name;
  String email;
  String phone;
  String image;
  String location;
  String password;
  ProfileInfos(
      this.name, this.email, this.phone, this.image, this.location, this.password
      );
}

Future<ProfileInfos> getProfileInfos() async{
  return ProfileInfos(
    "Afnane Touhar",
    "ja_touhar@esi.dz",
    "05555555",
    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
    "Algiers, Algeria",
    "********"
  );
}

class Profile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<ProfileInfos>(
        future: getProfileInfos(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while waiting for the data
          return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
          // Display an error message if there was an error retrieving the data
          return Text('Error: ${snapshot.error}');
          } else {
          return Container(
            margin: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
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
                          image: NetworkImage(snapshot.data!.image,))),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    snapshot.data!.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),
                ),
                Text(
                  snapshot.data!.email,
                  style: const TextStyle(
                      fontSize: 13,
                      color: cadetGray
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                ProfileMenuWidget(
                    icon: const Icon(Icons.person),
                    label: 'Edit Profile',
                    onClick: () => {
                    Navigator.of(context)
                        .pushNamed("/edit",
                    arguments: snapshot.data)
                    },
                ),
                ProfileMenuWidget(
                    icon: const Icon(Icons.admin_panel_settings),
                    label: 'Security',
                    onClick: () => {
                      Navigator.of(context)
                          .pushNamed("/security",
                          arguments: snapshot.data!.password)
                    },
                  ),
                ProfileMenuWidget(
                    icon: const Icon(Icons.help),
                    label: 'Help',
                    onClick: () => {
                      Navigator.of(context)
                          .pushNamed("/help")
                    },),
                const SizedBox(
                  height: 60,
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
          );
          }
        }
      ),
       );
    throw UnimplementedError();
  }

}