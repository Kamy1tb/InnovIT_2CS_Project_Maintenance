import 'package:flutter/foundation.dart';
import 'package:innovit_2cs_project_paiement/utilities/functions.dart';
import '../global.dart' as global;
import '../viewmodels/Task.dart';

class AllTasksProvider extends ChangeNotifier {
  Future<List<Task>> _tasks=getTasks(); // Your list of tasks
  Future<List<Task>> get tasks => _tasks;
  void fetchTasks() {
    _tasks=getTasks();
    notifyListeners();
  }

  void filterFree(){
    _tasks=getTasksFree();
    notifyListeners();
  }

  void assignTask(int idTask, bool assigned){
    assigned?
    _tasks.then((tasks) => tasks.firstWhere((element) => element.id==idTask).username=global.globalSessionData?.username):
    _tasks.then((tasks) => tasks.firstWhere((element) => element.id==idTask).username="None");
    assignTaskAM(idTask, assigned);
    notifyListeners();
  }

}
