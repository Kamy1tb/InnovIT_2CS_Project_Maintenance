import 'dart:async';
import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/providers/TasksProvider.dart';
import 'package:provider/provider.dart';
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
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.black26,
            valueColor: AlwaysStoppedAnimation<Color>(
              mountainMeadow, //<-- SEE HERE
            ),
          ),
          Container(margin: const EdgeInsets.only(left: 20),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TasksProvider>(context);
    void sortTasks(String? value) {
      setState(() async {
        sortValue = value!;
        switch(sortValue){
          case "All":{
            showLoaderDialog(context);
            await taskProvider.fetchMyTasks();
            Navigator.pop(context);
          }break;
          case "Done":{
            showLoaderDialog(context);
            await taskProvider.fetchDoneTasks();
            Navigator.pop(context);
          }break;
          case "Undone":{
            showLoaderDialog(context);
            await taskProvider.fetchUndoneTasks();
            Navigator.pop(context);
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
                      padding: const EdgeInsets.only(left: 8),
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

    body: Consumer<TasksProvider>(
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
                                    task.date!,
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
                                          'Machine :',
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
                                        task.distributeur.toString(),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          height: 2,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        task.type!,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          height: 2,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        task.etat? "DONE" : "TO DO",
                                        style: TextStyle(
                                          fontSize: 13,
                                          height: 2,
                                          color: task.etat ? mountainMeadow : pastelRed,
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

