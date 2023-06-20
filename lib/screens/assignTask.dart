import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/providers/TasksProvider.dart';
import 'package:innovit_2cs_project_paiement/utilities/constants.dart';
import 'package:innovit_2cs_project_paiement/widgets/RoundedColoredButton.dart';
import '../viewmodels/Task.dart';
import 'package:provider/provider.dart';
class AssignTask extends StatefulWidget{
  const AssignTask({super.key});

  @override
  State<AssignTask> createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask> {
  late Task task = ModalRoute.of(context)!.settings.arguments as Task;
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
          Container(margin: const EdgeInsets.only(left: 20),child:const Text("Assigning task..." )),
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
    if(task.opened==false){
      taskProvider.openTask(task.id);
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, task.etat);
          },
        ),
        title: const Text(
          "Assign Task",
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
                          'Company :',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'SmartBev :',
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
                          task.date ?? "none",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          task.heure ?? "none",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          task.entreprise!,
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
                            task.message ?? "No message",
                            style: const TextStyle(
                              fontSize: 15,
                              color: pastelRed,
                            ),
                          ),
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
                  child: task.idUser==null?
                  RoundedColoredButton(
                      width: 200,
                      height: 50,
                      text: "Add to My Tasks",
                      textColor: Colors.white,
                      fillColor: mountainMeadow,
                      shadowBlurRadius: 0,
                      onPressed: () async{
                        showLoaderDialog(context);
                        taskProvider.assignTask(task,true);
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil("/details",
                            ModalRoute.withName("/home"),
                            arguments: task);
                        const snackBar = SnackBar(
                          content: Text('Task added to my tasks!'),
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