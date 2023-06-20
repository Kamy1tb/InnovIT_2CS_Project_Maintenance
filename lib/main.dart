import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/providers/TasksProvider.dart';
import 'package:innovit_2cs_project_paiement/providers/UserProvider.dart';
import 'package:innovit_2cs_project_paiement/screens/HomePage.dart';
import 'package:innovit_2cs_project_paiement/screens/SignInPage.dart';
import 'package:innovit_2cs_project_paiement/screens/assignTask.dart';
import 'package:innovit_2cs_project_paiement/screens/tasksList.dart';
import 'package:innovit_2cs_project_paiement/screens/mytasks.dart';
import 'package:innovit_2cs_project_paiement/screens/profile.dart';
import 'package:innovit_2cs_project_paiement/screens/EditProfile.dart';
import 'package:innovit_2cs_project_paiement/screens/Security.dart';
import 'package:innovit_2cs_project_paiement/screens/Help.dart';
import 'package:innovit_2cs_project_paiement/screens/task_details.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");// mergeWith optional, you can include Platform.environment for Mobile/Desktop app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
    print('User granted permission: ${settings.authorizationStatus}');
  String? token = await messaging.getToken();
  print('FCM Token: $token');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TasksProvider>(
          create: (context) => TasksProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/TasksList": (_) => const TasksList(),
        "/MyTasks": (_) => const MyTasks(),
        "/details": (_) => const TaskDetails(),
        "/assign": (_) => const AssignTask(),
        "/profile": (_) => Profile(),
        "/edit" : (_) => EditProfile(),
        "/security" : (_) => const Security(),
        "/help" : (_) => const Help(),
        "/signin" : (_) => SignInPage(),
        "/home" : (_) => HomePage()
      },

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Outfit'),
      home: SignInPage(),
    );
  }
}

