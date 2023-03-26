import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/widgets/CustomBottomNavBar.dart';
import '../utilities/constants.dart';
import 'task_details.dart';
class Task{
  final int id;
  final String date;
  final String heure;
  final String entreprise;
  final String message;
  final String type;
  final String etat;
  Task(this.id, this.date, this.heure, this.entreprise, this.message, this.type, this.etat);
}
List<Task> taskslist=[
  Task(1,'04 mars 2023','03:00 PM','ESI Alger', "Mecanisme bloque",'Rupture de stock', "TO DO"),
  Task(2,'05 mars 2023','07:00 PM','EPAU', "Disconnected",'Rupture de stock', "TO DO"),
  Task(3,'05 mars 2023','09:00 AM','USTHB', "Manque d'ingredients",'Rupture de stock', "DONE"),
  Task(4,'06 mars 2023','04:00 PM','SOGRAL', "Manque d'ingredients",'Rupture de stock', "TO DO"),
  Task(5,'06 mars 2023','08:00 AM','City Center Alger', "Manque d'ingredients",'Rupture de stock', "DONE"),
  Task(6,'06 mars 2023','04:50 PM','CUB1', "Manque d'ingredients",'Rupture de stock', "TO DO"),
];
class TasksList extends StatefulWidget{
  const TasksList({super.key});
  @override
  State<StatefulWidget> createState() => TasksListState();
}
class TasksListState extends State<TasksList> {
  TasksListState({Key? key}) : super();
  late List<Task> displayedList=List.from(taskslist);
  late String sortValue='Date';
  void searchTasks(String search) {
    setState(() {
      displayedList = taskslist
          .where((item) =>
          item.message.toLowerCase().contains(search.toLowerCase()))
          .toList();
    });
  }
  void sortTasks(String? value){
    setState(() {
      sortValue = value!;
      displayedList.sort((a, b) {
        if (value == 'Date') {
          return a.date.compareTo(b.date);
        } else if (value == 'Identifier') {
          return a.id.compareTo(b.id);
        } else {
          return a.etat.compareTo(b.etat);
        }
      });
    });
  }
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: cadetGray,
            ),
          ),
          Expanded(
            child: TextField(
              style: const TextStyle(
                color: cadetGray,
              ),
              decoration: const InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
              onChanged: (value) => searchTasks(value),
            ),
          ),
          DropdownButton<String>(
            value: sortValue,
            onChanged: sortTasks,
            items: <String>['Date', 'Identifier', 'State']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: displayedList.length,
        itemBuilder: (context, index){
          final task = displayedList[index];
          return ListTile(
            title: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetails(task: task),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: mountainMeadow.withOpacity(0.05),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(20.0),
                child:Column(
                  children: [
                    Container(
                      padding:const EdgeInsets.only(bottom:20),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            task.date,
                            style: const TextStyle(
                              fontSize: 13,
                              color: cadetGray,
                            ),
                          ),
                          Text(
                            task.heure,
                            style: const TextStyle(
                              fontSize: 13,
                              color: cadetGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right:15),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Distributeur :',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Message :',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Etat :',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.id.toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              task.message,
                              style: const TextStyle(
                                fontSize: 13,
                                color: pastelRed,
                              ),
                            ),
                            Text(
                              task.etat,
                              style: TextStyle(
                                fontSize: 13,
                                color: task.etat=="TO DO" ? pastelRed : mountainMeadow,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),


          );
        },
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
      ),
    );
  }
}
