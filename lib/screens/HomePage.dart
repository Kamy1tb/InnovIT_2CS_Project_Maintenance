import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/screens/profile.dart';
import 'package:innovit_2cs_project_paiement/screens/mytasks.dart';

import '../utilities/constants.dart';
import 'tasksList.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex=0;
  final screens=[
    TasksList(),
    MyTasks(),
    Profile()
  ];
  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
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
              icon: Icon(Icons.checklist_rtl),
              label: 'All tasks'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: "My tasks",
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
