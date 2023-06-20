import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/providers/UserProvider.dart';
import 'package:provider/provider.dart';
import '../utilities/constants.dart';
import '../viewmodels/User.dart';
import '../widgets/ProfileMenuWidget.dart';
import '../widgets/RoundedColoredButton.dart';
import '../global.dart' as global;



class Profile extends StatelessWidget{
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
        body: FutureBuilder<User>(
        future: userProvider.user,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while waiting for the data
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator(
                backgroundColor: Colors.black26,
                valueColor: AlwaysStoppedAnimation<Color>(
                  mountainMeadow, //<-- SEE HERE
                ),
              )),
            ],
          );
          } else if (snapshot.hasError) {
          // Display an error message if there was an error retrieving the data
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('Error: ${snapshot.error}',
                    style: const TextStyle(
                        color: pastelRed,
                        fontSize: 14
                    ),),
                ),
              ],
            ),
          );
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
                    "${snapshot.data!.nom} ${snapshot.data!.prenom}" ,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),
                ),
                Text(
                  snapshot.data!.email!,
                  style: const TextStyle(
                      fontSize: 13,
                      color: cadetGray
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    "${snapshot.data!.entreprise} Company",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                    width: (MediaQuery.of(context).size.width * 4) / 5,
                    height: 50,
                    text: 'Logout',
                    textColor: Colors.white,
                    fillColor: pastelRed,
                    shadowBlurRadius: 8,
                    onPressed: ()=>{
                    userProvider.clearToken(),
                    Navigator.of(context)
                        .pushNamed("/signin"),
                      global.clearSessionData()
                    })
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