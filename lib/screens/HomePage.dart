import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/screens/profile.dart';
import 'package:innovit_2cs_project_paiement/screens/tasks_list.dart';

import '../utilities/constants.dart';
import 'notifications.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex=0;
  final screens=[
    Notifications(),
    TasksList(),
    Profile()
  ];
  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (index==0){
        taskslist.addAll(notifs);
        notifs.removeWhere((element) => 1==1);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mountainMeadow,
        unselectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        onTap: (index)=>setState(() => selectedIndex=index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rtl),
            label: "tasks list",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
