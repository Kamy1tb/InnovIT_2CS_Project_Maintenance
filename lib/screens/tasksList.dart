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
  late String sortValue = 'All';

  void sortTasks(String? value) {
    setState(() {
      sortValue = value!;
      switch(sortValue){
        case "All":{
          tasks=getTasks(global.globalSessionData!.userId);
        }break;
        case "Free":{
          tasks=getTasksFree(global.globalSessionData!.userId);
        }break;
      }
    });
  }
  //Get the tasks
  //Authentication - I have to get the user ID
  @override
  void initState() {
    super.initState();
    tasks = getTasks(global.globalSessionData!.userId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: cadetGray, width:1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: EdgeInsets.only(left:10, right:10),
              child: DropdownButton<String>(
                value: sortValue,
                onChanged: sortTasks,
                items: <String>['All', 'Free']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                      style: const TextStyle(
                          color:cadetGray
                      ),),
                  );
                }).toList(),
                underline: Container(),
                icon: const Padding(
                  padding: EdgeInsets.only(right:10),
                  child:Icon(Icons.filter_list, color: cadetGray,),
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Task>>(
        future: tasks,
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
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(5, 30, 5, 8),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                final task = snapshot.data![index];
                return ListTile(
                  title: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(
                          task.idUser==global.globalSessionData?.userId? "/details" : "/assign",
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
                          Row(
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
                                'Time : ${task.heure}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: cadetGray,
                                ),
                              ),
                            ],
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
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Type :',
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Assigned To :',
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 2,
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
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    task.type,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    task.username != null ? task.username! : "None",
                                    style: TextStyle(
                                      fontSize: 13,
                                      height: 2,
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
