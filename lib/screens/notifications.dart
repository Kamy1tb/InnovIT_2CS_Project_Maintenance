import 'package:flutter/material.dart';
import '../utilities/constants.dart';
class Task
{
  int id;
  String date;
  String heure;
  String entreprise;
  String message;
  String type;
  String etat;
  bool opened;
  Task(this.id, this.date, this.heure, this.entreprise, this.message, this.type, this.etat, this.opened);
}

Future<List<Task>> getTasks() async {
  // Retrieve tasks from a database or any other source of data
  // Return a List<Task>
  return [
    Task(1,'04 mars 2023','03:00 PM','ESI Alger', "Mecanisme bloque",'Rupture de stock', "TO DO", false),
    Task(2,'05 mars 2023','07:00 PM','EPAU', "Disconnected",'Rupture de stock', "TO DO", false),
    Task(3,'05 mars 2023','09:00 AM','USTHB', "Manque d'ingredients",'Rupture de stock', "TO DO", false),
    Task(4,'06 mars 2023','04:00 PM','SOGRAL', "Manque d'ingredients",'Rupture de stock', "TO DO", true),
    Task(5,'06 mars 2023','08:00 AM','City Center Alger', "Manque d'ingredients",'Rupture de stock', "TO DO", false),
    Task(6,'06 mars 2023','04:50 PM','CUB1', "Manque d'ingredients",'Rupture de stock', "DONE", true),
  ];
}
List<Task> taskslist=[];
List<Task> notifs=[];

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Task>>(
        future: getTasks(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while waiting for the data
          return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
          // Display an error message if there was an error retrieving the data
          return Text('Error: ${snapshot.error}');
          } else {
            taskslist=snapshot.data!.where((task) => task.opened==true).toList();
            notifs=snapshot.data!.where((task) => task.opened==false).toList();
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(5, 30, 5, 8),
              itemCount: notifs.length,
              itemBuilder: (context, index){
                final task = notifs[index];
                return ListTile(
                  title: GestureDetector(
                    onTap: () {
                      // Navigator.of(context)
                      //     .pushNamed("/details",
                      //     arguments: notifs[index]);
                      setState(() {
                        snapshot.data![index].opened=true;
                        taskslist.add(task);
                        notifs.removeAt(index);
                      });
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
            );
          }
        },
      ),
    );
  }
}
