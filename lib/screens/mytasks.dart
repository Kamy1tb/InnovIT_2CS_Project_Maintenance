import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/MyTasksProvider.dart';
import '../utilities/constants.dart';
import '../viewmodels/Task.dart';
import '../widgets/RoundedColoredButton.dart';

//TasksList widget
class MyTasks extends StatefulWidget {
  const MyTasks({super.key});
    @override
  State<StatefulWidget> createState() => MyTasksState();
}
class MyTasksState extends State<MyTasks> {
  late Future<List<Task>> myTasks;
  late String sortValue = 'All';
  late List<Task> displayedList=myTasks as List<Task>;
  String search="";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<MyTasksProvider>(context);
    taskProvider.fetchMyTasks();
    void sortTasks(String? value) {
      setState(() {
        sortValue = value!;
        switch(sortValue){
          case "All":{
            taskProvider.fetchMyTasks();
          }break;
          case "Done":{
            taskProvider.fetchDoneTasks();
          }break;
          case "Undone":{
            taskProvider.fetchUndoneTasks();
          }break;
        }
      });
    }
    return Scaffold(
            appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(top:5, right: 10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  border: Border.all(color: cadetGray, width:1),
                  borderRadius: BorderRadius.circular(20),
                            ),
              child: DropdownButton<String>(
                value: sortValue,
                onChanged: sortTasks,
                items: <String>['All', 'Done', 'Undone']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(value,
                      style: const TextStyle(
                        color:cadetGray
                      ),),
                    ),
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

    body: Consumer<MyTasksProvider>(
        builder: (context, taskProvider, _){
          return FutureBuilder<List<Task>>(
            future: taskProvider.myTasks,
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
                      const SizedBox(
                        height: 40,
                      ),
                      RoundedColoredButton(
                          width: 200,
                          height: 50,
                          text: "Refresh",
                          textColor: Colors.white,
                          fillColor: pastelRed,
                          shadowBlurRadius: 0,
                          onPressed: ()=>{
                            Navigator.of(context)
                                .pushNamed("/home")
                          }),
                    ],
                  ),
                );
              } else {

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(5, 30, 5, 8),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    final task = snapshot.data![index];
                    print("task state : ${task.etat}");
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
                                          'State :',
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
                                        task.etat=='true'? "DONE" : "TO DO",
                                        style: TextStyle(
                                          fontSize: 13,
                                          height: 2,
                                          color: task.etat == "false" ? pastelRed : mountainMeadow,
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
          );
        }
    ),
    );
  }
}



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import '../utilities/constants.dart';
// import '../utilities/functions.dart';
// import '../viewmodels/Task.dart';
// import '../global.dart' as global;
//
// class MyTasks extends StatefulWidget {
//   const MyTasks({super.key});
//   @override
//   State<StatefulWidget> createState() => MyTasksState();
// }
//
// class MyTasksState extends State<MyTasks> {
//   late Future<List<Task>> tasks;
//   late List<Task> displayedList;
//   late List<Task> tmp;
//   late String sortValue = 'Date';
//
//   @override
//   void initState() {
//     super.initState();
//     tasks = getTasksAM(global.globalSessionData!.userId);
//   }
//
//   Future<void> searchTasks(String search) async {
//     setState(() async {
//       tmp = await Future.wait(tasks as Iterable<Future<Task>>);
//       displayedList = tmp
//           .where((item) =>
//               item.message.toLowerCase().contains(search.toLowerCase()))
//           .toList();
//     });
//   }
//
//   void sortTasks(String? value) {
//     setState(() async {
//       sortValue = value!;
//       tmp = await Future.wait(tasks as Iterable<Future<Task>>);
//       displayedList = tmp;
//       displayedList.sort((a, b) {
//         if (value == 'Date') {
//           return a.date.compareTo(b.date);
//         } else if (value == 'Identifier') {
//           return a.id.compareTo(b.id);
//         } else {
//           return a.etat.compareTo(b.etat);
//         }
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.search,
//               color: cadetGray,
//             ),
//           ),
//           Expanded(
//             child: TextField(
//               style: const TextStyle(
//                 color: cadetGray,
//               ),
//               decoration: const InputDecoration(
//                 hintText: 'Search',
//                 border: InputBorder.none,
//               ),
//               onChanged: (value) => searchTasks(value),
//             ),
//           ),
//           DropdownButton<String>(
//             value: sortValue,
//             onChanged: sortTasks,
//             items: <String>['Date', 'Identifier', 'State']
//                 .map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Task>>(
//           future: tasks,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               // Display a loading indicator while waiting for the data
//               return const Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                       child: CircularProgressIndicator(
//                     backgroundColor: Colors.black26,
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       mountainMeadow, //<-- SEE HERE
//                     ),
//                   )),
//                 ],
//               );
//             } else if (snapshot.hasError) {
//               // Display an error message if there was an error retrieving the data
//               return Container(
//                 margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Center(
//                       child: Text(
//                         'Error: ${snapshot.error}',
//                         style: const TextStyle(color: pastelRed, fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               return ListView.builder(
//                 padding: const EdgeInsets.all(8),
//                 itemCount: displayedList.length,
//                 itemBuilder: (context, index) {
//                   final task = displayedList[index];
//                   return ListTile(
//                     title: GestureDetector(
//                       onTap: () async {
//                         Navigator.of(context)
//                             .pushNamed("/details", arguments: task);
//                         setState(() {
//                           task.etat = task.etat;
//                         });
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: mountainMeadow.withOpacity(0.05),
//                           borderRadius: const BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                         ),
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.only(bottom: 20),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     task.date,
//                                     style: const TextStyle(
//                                       fontSize: 13,
//                                       color: cadetGray,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Time : ${task.heure}',
//                                     style: const TextStyle(
//                                       fontSize: 13,
//                                       color: cadetGray,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   margin: const EdgeInsets.only(right: 15),
//                                   child: const Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Distributeur :',
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           color: Colors.black,
//                                             height: 1.2
//                                         ),
//                                       ),
//                                       Text(
//                                         'Type :',
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           color: Colors.black,
//                                             height: 1.2
//                                         ),
//                                       ),
//                                       Text(
//                                         'Etat :',
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           color: Colors.black,
//                                             height: 1.2
//                                         ),
//                                       ),
//                                       Text(
//                                         'Message :',
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           color: Colors.black,
//                                             height: 1.2
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       task.id.toString(),
//                                       style: const TextStyle(
//                                         fontSize: 13,
//                                         color: Colors.black,
//                                           height: 1.2
//                                       ),
//                                     ),
//                                     Text(
//                                       task.type,
//                                       style: const TextStyle(
//                                         fontSize: 13,
//                                         color: pastelRed,
//                                           height: 1.2
//                                       ),
//                                     ),
//                                     Text(
//                                       task.etat == "false" ? "TO DO" : "DONE",
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         height: 1.2,
//                                         color: task.etat == "false"
//                                             ? pastelRed
//                                             : mountainMeadow,
//                                       ),
//                                     ),
//                                     Text(
//                                       task.message,
//                                       style: const TextStyle(
//                                         fontSize: 13,
//                                         color: Colors.black,
//                                           height: 1.2
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           }),
//     );
//   }
// }
