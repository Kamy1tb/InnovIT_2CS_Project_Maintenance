import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_paiement/utilities/constants.dart';
import 'package:innovit_2cs_project_paiement/utilities/functions.dart';
import 'package:innovit_2cs_project_paiement/widgets/RoundedColoredButton.dart';
import '../viewmodels/Task.dart';
import '../global.dart' as global;
class AssignTask extends StatefulWidget{
  const AssignTask({super.key});

  @override
  State<AssignTask> createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask> {
  late Task task = ModalRoute.of(context)!.settings.arguments as Task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, task.etat);
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
                        ),Text(
                          'Message :',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Assigned To :',
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
                              color: pastelRed,
                            ),
                          ),
                        ),
                        Text(
                          task.username != null ? task.username! : "None",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
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
                      fillColor: pastelRed,
                      shadowBlurRadius: 0,
                      onPressed: ()=>{
                        assignTaskAM(global.globalSessionData!.userId, task.id)
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