import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../viewmodels/Task.dart';


Future<List<Task>> getTasks(idUser) async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/getTasks/$idUser');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Task.fromJson(e)).toList();
  } else {
    throw Exception('failed to load tasks,error code: ${response.statusCode}');
  }
}
Future<List<Task>> getTasksFree(idUser) async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/getTasksFree/$idUser');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Task.fromJson(e)).toList();
  } else {
    throw Exception('failed to load tasks,error code: ${response.statusCode}');
  }

}
Future<List<Task>> getTasksAM(idUser) async {
  final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/getTasksAM/$idUser');
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

Future<http.Response> assignTaskAM(int idUser,int idTask){
 final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/assignTaskAM/$idUser/$idTask');
  return http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': idTask,
        'idUser': idUser,
      }));
}

Future<http.Response> switchStateTask(idTask){
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/switchStateTask/$idTask');
  return http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': idTask,
      }));
}



