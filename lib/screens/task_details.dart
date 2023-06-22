import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/TasksProvider.dart';
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
  late String _selectedStatus= task.etat==false ? 'TO DO':'DONE';
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.black26,
            valueColor: AlwaysStoppedAnimation<Color>(
              mountainMeadow,
            ),
          ),
          Container(margin: const EdgeInsets.only(left: 20),child:const Text("Loading ..." )),
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
                          'Time :',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Machine :',
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
                        ),SizedBox(
                          height: 70,
                          child: Text(
                            'Message :',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          'State :',
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
                          task.date != null
                              ?task.date!
                              :"No date",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          task.heure!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          task.distributeur,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          task.type!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
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
                          taskProvider.switchTask(task.id,task.etat);
                        });
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
                      onPressed: () async {
                        showLoaderDialog(context);
                        taskProvider.assignTask(task, false);
                        task.idUser=null;
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil("/assign",
                            ModalRoute.withName("/home"),
                            arguments: task);
                        final snackBar = SnackBar(
                          content: const Text('Task removed from my tasks!'),
                          backgroundColor: (Colors.black),
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