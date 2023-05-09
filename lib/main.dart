import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:innovit_2cs_project_paiement/screens/HomePage.dart';

import 'package:innovit_2cs_project_paiement/screens/tasksList.dart';
import 'package:innovit_2cs_project_paiement/screens/mytasks.dart';
import 'package:innovit_2cs_project_paiement/screens/profile.dart';
import 'package:innovit_2cs_project_paiement/screens/EditProfile.dart';
import 'package:innovit_2cs_project_paiement/screens/Security.dart';
import 'package:innovit_2cs_project_paiement/screens/Help.dart';

import 'package:innovit_2cs_project_paiement/screens/task_details.dart';
import 'package:innovit_2cs_project_paiement/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");// mergeWith optional, you can include Platform.environment for Mobile/Desktop app

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/notifications": (_) => const TasksList(),
        "/tasks": (_) => const MyTasks(),
        "/details": (_) => const TaskDetails(),
        "/profile": (_) => Profile(),
        "/edit" : (_) => EditProfile(),
        "/security" : (_) => const Security(),
        "/help" : (_) => const Help(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Outfit'),
      home: HomePage(),
    );
  }
}

