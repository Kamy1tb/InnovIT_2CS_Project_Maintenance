import 'package:flutter/foundation.dart';
import 'package:innovit_2cs_project_paiement/utilities/functions.dart';
import '../viewmodels/Task.dart';

class MyTasksProvider extends ChangeNotifier {
  late Future<List<Task>> _mytasks=getTasksAM(); // Your list of tasks
  Future<List<Task>> get myTasks => _mytasks;

  void fetchMyTasks(){
    _mytasks=getTasksAM();
    notifyListeners();
  }

  void fetchDoneTasks(){
    _mytasks=getDoneTasks();
    notifyListeners();
  }

  void fetchUndoneTasks(){
    _mytasks=getUnDoneTasks();
    notifyListeners();
  }
  // Method to update the task state
  void updateTaskState(int id, String isdone) {
    if(isdone=="DONE"){
      _mytasks.then((tasks) => tasks.firstWhere((element) => element.id==id).etat="TO DO");
    }else if(isdone=="TO DO"){
      _mytasks.then((tasks) => tasks.firstWhere((element) => element.id==id).etat="DONE");
    }
    switchStateTask(id);
    notifyListeners();
  }


}
