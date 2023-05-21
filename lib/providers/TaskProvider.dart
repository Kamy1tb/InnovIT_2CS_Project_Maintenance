
import 'package:flutter/cupertino.dart';
import '../viewmodels/Task.dart';

class TaskProvider extends ChangeNotifier{
  late Future<List<Task>> taskslist;

  void changeState(Task task){
    if(task.etat=="true"){
      task.etat="false";
    }else if(task.etat=="false"){
      task.etat="true";
    }
    notifyListeners();
  }
}