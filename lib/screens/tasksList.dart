import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../utilities/constants.dart';
import '../utilities/functions.dart';
import '../viewmodels/Task.dart';
import '../global.dart' as global;

//TasksList widget
class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);
  @override
  TasksListState createState() => TasksListState();
}

class TasksListState extends State<TasksList> {
  late Future<List<Task>> tasks;
  //Get the tasks
  //Authentication - I have to get the user ID
  @override
  void initState() {
    super.initState();
    tasks = getTasks(global.globalSessionData!.userId);
  }
  Future<void> tasksToList() async {
    final tasksList = await Future.wait(tasks as Iterable<Future>);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Task>>(
        future: tasks,
        builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for the data
            return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
            // Display an error message if there was an error retrieving the data
            return Text('Error: ${snapshot.error}');
            } else {
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(5, 30, 5, 8),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                final task = snapshot.data![index];
                return ListTile(
                  title: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed("/details",
                          arguments: snapshot.data![index]);
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
                                      'Type :',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Assigned To :',
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
                                    task.type,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: pastelRed,
                                    ),
                                  ),
                                  Text(
                                    task.idUser==null? "None" : task.idUser.toString(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: task.idUser == null ? pastelRed : mountainMeadow,
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
