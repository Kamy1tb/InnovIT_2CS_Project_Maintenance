import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../global.dart' as global;
import 'package:http/http.dart' as http;
import '../viewmodels/Task.dart';

class TasksProvider extends ChangeNotifier {
  //The list that contains all the tasks of the company
  Future<List<Task>>? _tasks;

  //The list that contains all the tasks of the user
  Future<List<Task>>? _myTasks;

  // counters to avoid fetching tasks every second
  int tasksCounter=0;
  int myTasksCounter=0;

  //getter of tasks
  Future<List<Task>>? get tasks{
    if(tasksCounter==0){
      fetchTasks();
      tasksCounter++;
    }
    return _tasks;
  }

  //getter of my tasks
  Future<List<Task>>? get myTasks{
    if(myTasksCounter==0){
      fetchMyTasks();
      myTasksCounter++;
    }
    return _myTasks;
  }


  //fetches all the tasks of the company
  Future<void> fetchTasks() async {
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/${global.globalSessionData?.userId}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      _tasks = Future.value(data.map((json) => Task.fromJson(json)).toList());
      notifyListeners();
    } else {
      throw Exception('failed to load tasks,error code: ${response.statusCode}');
    }
  }

  //fetches all the tasks of the user
  Future<void> fetchMyTasks() async{
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/AM/tasks/${global.globalSessionData?.userId}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      _myTasks=Future.value(data.map((json) => Task.fromJson(json)).toList());
      notifyListeners();
    } else {
      throw Exception('failed to load my tasks,error code: ${response.statusCode}');
    }
  }

  //filters the free tasks (not assigned)
  Future<void> fetchFreeTasks() async {
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/state/unassigned/${global.globalSessionData?.userId}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      _tasks=Future.value(data.map((json) => Task.fromJson(json)).toList());
      notifyListeners();
    } else {
      throw Exception('failed to load free tasks,error code: ${response.statusCode}');
    }
  }

  //fetches tasks marked as done in the user's tasks
  Future<void> fetchDoneTasks() async{
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/AM/state?idAM=${global.globalSessionData?.userId}&state=true');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      _myTasks=Future.value(data.map((json) => Task.fromJson(json)).toList());
      notifyListeners();
    } else {
      throw Exception('failed to load done tasks,error code: ${response.statusCode}');
    }
  }

  //fetched tasks marked as undone in the user's tasks
  Future<void> fetchUndoneTasks() async{
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/AM/state?idAM=${global.globalSessionData?.userId}&state=false');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      _myTasks=Future.value(data.map((json) => Task.fromJson(json)).toList());
      notifyListeners();
    } else {
      throw Exception('failed to load undone tasks,error code: ${response.statusCode}');
    }
  }

  //change the owner of the task
  void assignTask(Task task, bool assigned)async {
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/AM/assign');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': task.id,
          'idUser': global.globalSessionData?.userId,
          'state' : assigned,
        }));
    if (response.statusCode == 200) {
      if(assigned){
        _tasks?.then((tasks) => tasks.firstWhere((element) => element.id==task.id).idUser=global.globalSessionData?.userId);
        _tasks?.then((tasks) => tasks.firstWhere((element) => element.id==task.id).username=global.globalSessionData?.username);
        _myTasks?.then((tasks) => tasks.add(task));
      }else{
        _tasks?.then((tasks) => tasks.firstWhere((element) => element.id==task.id).idUser=null);
        _tasks?.then((tasks) => tasks.firstWhere((element) => element.id==task.id).username=null);
        _myTasks?.then((tasks) => tasks.remove(task));
      }
      _tasks=Future.value(_tasks);
      _myTasks=Future.value(_myTasks);
      notifyListeners();
    } else {
      throw Exception('Failed to assign task || error code : ${response.statusCode}');
    }

  }

  //mark the task as opened
  void openTask(int idTask) async{
      final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/AM/task/open/$idTask');
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id': idTask,
          }));
      if (response.statusCode == 200) {
        _tasks?.then((tasks) => tasks.firstWhere((element) => element.id==idTask).opened=true);
        _tasks=Future.value(_tasks);
        notifyListeners();
      } else {
        throw Exception('Failed to open task || error code : ${response.statusCode}');
      }
  }

  //switch the state of a task between done and undone
  void switchTask(int idTask, bool done) async{
    print("Helloooooo");
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/AM/task/state/$idTask');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': idTask,
        }));
    if (response.statusCode == 200) {
      print("jebna response weeee");
      if(done){
        _myTasks?.then((tasks) => tasks.firstWhere((element) => element.id==idTask).etat=false);
      }else{
        _myTasks?.then((tasks) => tasks.firstWhere((element) => element.id==idTask).etat=true);
      }
      _myTasks=Future.value(_myTasks);
      notifyListeners();
    } else {
      throw Exception('Failed to switch state || error code : ${response.statusCode}');
    }

  }
}
