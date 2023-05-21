import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../viewmodels/Task.dart';


Future<List<Task>> getTasks(idUser) async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/$idUser');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Task.fromJson(e)).toList();
  } else {
    throw Exception('failed to load tasks,error code: ${response.statusCode}');
  }
}
Future<List<Task>> getTasksFree(idUser) async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/state/unassigned/$idUser');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Task.fromJson(e)).toList();
  } else {
    throw Exception('failed to load tasks,error code: ${response.statusCode}');
  }

}
Future<List<Task>> getTasksAM(idUser) async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/AM/tasks/$idUser');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Task.fromJson(e)).toList();
  } else {
    throw Exception('failed to load tasks,error code: ${response.statusCode}');
  }
}
Future<List<Task>> getDoneTasks(idUser) async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/AM/state?idAM=${idUser}&state=true');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Task.fromJson(e)).toList();
  } else {
    throw Exception('failed to load tasks,error code: ${response.statusCode}');
  }
}
Future<List<Task>> getUnDoneTasks(idUser) async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/AM/state?idAM=${idUser}&state=false');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Task.fromJson(e)).toList();
  } else {
    throw Exception('failed to load tasks,error code: ${response.statusCode}');
  }
}
Future<Task> getTasksInfo(idTask) async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/getTasksInfo/$idTask');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    Task infos = jsonDecode(response.body);
    return infos;
  } else {
    throw Exception('failed to load tasks,error code: ${response.statusCode}');
  }

}

Future<void> assignTaskAM(int idUser, int idTask, bool state) async{
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/AM/assign');
  final response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': idTask,
        'idUser': idUser,
        'state' : state,
      }));
  if (response.statusCode == 200) {
    print('Task assigned to person successfully');
  } else {
    throw Exception('Failed to assign task || error code : ${response.statusCode}');
  }

}

Future<void> switchStateTask(idTask) async{
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/AM/task/state/$idTask');
  final response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': idTask,
      }));
    if (response.statusCode == 200) {
      print('Task state is changed successfully');
    } else {
      throw Exception('Failed to switch state || error code : ${response.statusCode}');
    }
}



