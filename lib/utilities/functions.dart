import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../viewmodels/Task.dart';
import '../global.dart' as global;


Future<List<Task>> getTasks() async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/${global.globalSessionData?.userId}');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Task.fromJson(e)).toList();
  } else {
    throw Exception('failed to load tasks,error code: ${response.statusCode}');
  }
}
Future<List<Task>> getTasksFree() async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/state/unassigned/${global.globalSessionData?.userId}');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Task.fromJson(e)).toList();
  } else {
    throw Exception('failed to load tasks,error code: ${response.statusCode}');
  }

}
Future<List<Task>> getTasksAM() async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/AM/tasks/${global.globalSessionData?.userId}');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Task.fromJson(e)).toList();
  } else {
    throw Exception('failed to load tasks,error code: ${response.statusCode}');
  }
}
Future<List<Task>> getDoneTasks() async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/AM/state?idAM=${global.globalSessionData?.userId}&state=true');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Task.fromJson(e)).toList();
  } else {
    throw Exception('failed to load tasks,error code: ${response.statusCode}');
  }
}
Future<List<Task>> getUnDoneTasks() async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/AM/state?idAM=${global.globalSessionData?.userId}&state=false');
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

Future<void> assignTaskAM(int idTask, bool state) async{
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/tasks/AM/assign');
  final response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': idTask,
        'idUser': global.globalSessionData?.userId,
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

Future<void> login(mail, mdp) async{
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/auth/login');
  final response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'mail': mail,
        'mdp': mdp,
      }));
  if (response.statusCode == 200) {
    print('Loggedin');
    var jsonResponse = json.decode(response.body);
    var id = jsonResponse['id'];
    global.globalSessionData?.userId=id;
  } else {
    throw Exception('Failed to assign task || error code : ${response.statusCode}');
  }
}

Future<void> signup(mail, mdp) async{
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/auth/signup');
  final response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'mail': mail,
        'mdp': mdp,
      }));
  if (response.statusCode == 200) {
    print('Loggedin');
    var jsonResponse = json.decode(response.body);
    var id = jsonResponse['id'];
    global.globalSessionData?.userId=id;
  } else {
    throw Exception('Failed to assign task || error code : ${response.statusCode}');
  }
}

Future<void> addToken(String token) async{
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/AM/token/add');
  final response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'idUser': global.globalSessionData?.userId,
        'token': token
      }));
  if (response.statusCode == 200) {
    print('token added successfully');
  } else {
    throw Exception('Failed to assign task || error code : ${response.statusCode}');
  }

}

Future<void> clearToken() async{
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/AM/token/clear');
  final response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'idUser': global.globalSessionData?.userId,
      }));
  if (response.statusCode == 200) {
    print('token deleted successfully');
  } else {
    throw Exception('Failed to assign task || error code : ${response.statusCode}');
  }

}


