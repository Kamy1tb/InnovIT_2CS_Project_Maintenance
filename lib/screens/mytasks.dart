import 'dart:convert';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../utilities/functions.dart';
import '../viewmodels/Task.dart';
import '../global.dart' as global;

class MyTasks extends StatefulWidget{
  const MyTasks({super.key});
  @override
  State<StatefulWidget> createState() => MyTasksState();
}
class MyTasksState extends State<MyTasks> {
  late Future<List<Task>> tasks;
  late List<Task> displayedList;
  late List<Task> tmp;
  late String sortValue='Date';

  @override
  Future<void> initState() async {
    super.initState();
    tasks = getTasksAM(global.globalSessionData!.userId);
    tmp=await Future.wait(tasks as Iterable<Future<Task>>);
  }

  Future<void> searchTasks(String search) async{
    setState(() async {
      displayedList = tmp
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
      body: FutureBuilder<List<Task>>(
        future: tasks,
        builder: (context,snapshot){
    if (snapshot.connectionState == ConnectionState.waiting) {
    // Display a loading indicator while waiting for the data
    return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
    // Display an error message if there was an error retrieving the data
    return Text('Error: ${snapshot.error}');
    } else {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: displayedList.length,
      itemBuilder: (context, index){
        final task = displayedList[index];
        return ListTile(
          title: GestureDetector(
            onTap: () async{
              Navigator.of(context)
                  .pushNamed("/details",
                  arguments: task);
              setState(() {
                task.etat=task.etat;
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
                            Text(
                              'Type :',
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
                          Text(
                            task.type,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
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
    }}),);}}
