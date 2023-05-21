import 'package:flutter/material.dart';
import '../utilities/functions.dart';
import '../utilities/constants.dart';
import '../viewmodels/Task.dart';
import '../widgets/RoundedColoredButton.dart';
import '../global.dart' as global;

class TaskDetails extends StatefulWidget{
  const TaskDetails({super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late Task task = ModalRoute.of(context)!.settings.arguments as Task;
  final List<String> _statusOptions = ['TO DO', 'DONE'];
  late String _selectedStatus= task.etat=="false"?'TO DO':'DONE';

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
          child: Column(
            children: [
              Row(
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
                          'Type :',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),Text(
                          'Message :',
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
                          task.type,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            task.message != null ? task.message! : "No message",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                    DropdownButton<String>(
                      isDense: true,
                      elevation: 1,
                      value: _selectedStatus,
                      items: _statusOptions.map((String status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(
                              status,
                              style: TextStyle(color: status =='TO DO'?pastelRed:mountainMeadow),
                          ),
                        );
                      }).toList(),

                      onChanged: (newStatus) async {
                        setState(() {
                          _selectedStatus = newStatus!;
                          task.etat=newStatus=='TO DO'?"false":"true";
                        });
                        switchStateTask(task.id);

                      },
                    ),

                    ],

                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                  child: task.idUser==global.globalSessionData!.userId?
                  RoundedColoredButton(
                      width: 250,
                      height: 50,
                      text: "Remove from My Tasks",
                      textColor: Colors.white,
                      fillColor: pastelRed,
                      shadowBlurRadius: 0,
                      onPressed: (){
                        assignTaskAM(global.globalSessionData!.userId, task.id, false);
                        final snackBar = SnackBar(
                          content: const Text('Task removed from my tasks!'),
                          backgroundColor: (Colors.black12),
                          action: SnackBarAction(
                            label: 'dismiss',
                            onPressed: () {
                              assignTaskAM(global.globalSessionData!.userId, task.id, true);
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }):
                  const SizedBox(
                      height:5
                  )
              )
            ],
          ),
        ),) ,
    );
  }
}