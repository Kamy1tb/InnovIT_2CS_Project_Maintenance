import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/widgets/CustomBottomNavBar.dart';
import '../utilities/constants.dart';
import 'tasks_list.dart';
class TaskDetails extends StatelessWidget{
  final Task task;
  const TaskDetails({super.key, required this.task});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Task's Details",
          style: TextStyle(
            color: Colors.black
          ),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body:Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          margin: const EdgeInsets.fromLTRB(10,80,10,0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 320,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date :',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Heure :',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Entreprise :',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Distributeur :',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Message :',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),Text(
                      'Type :',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Etat :',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 320,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.date,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      task.heure,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      task.entreprise,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      task.id.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      task.message,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      task.type,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      task.etat,
                      style: TextStyle(
                        fontSize: 15,
                        color: task.etat=="TO DO" ? pastelRed : mountainMeadow,
                      ),
                    ),
                  ],

                ),
              ),
            ],
          ),
        ),) ,
      bottomNavigationBar: CustomBottomNavBar(
        icon1: const Icon(Icons.notifications),
        icon2: const Icon(Icons.checklist_rtl),
        icon3: const Icon(Icons.person),
        label1: 'Notifications',
        label2: "task's list",
        label3: 'Profile',
        selectedItemColor: mountainMeadow,
        unselectedItemColor: Colors.black,
      ),
    );
  }

}