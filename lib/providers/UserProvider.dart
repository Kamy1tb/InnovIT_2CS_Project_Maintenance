import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:innovit_2cs_project_paiement/viewmodels/User.dart';
import 'package:http/http.dart' as http;
import '../global.dart' as global;

class UserProvider extends ChangeNotifier{
  late Future<User>? _user;
  Future<User>? get user => _user;



  //recuperer les informations de l'utilisateur
  void userInfo() async{
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/users/${global.globalSessionData?.userId}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      _user = Future.value(User.fromJson(jsonResponse));
      notifyListeners();
      print("user infos jebnahom");
    } else {
      throw Exception('failed to load User information,error code: ${response.statusCode}');
    }
  }
  //authentication en utilisant un email et un mot de passe
  Future<bool> login(mail, mdp) async{
  print("I guess dkhalna");
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
      var jsonResponse = json.decode(response.body);
      var id = jsonResponse['id'];
      var name = jsonResponse['data']['nom'];
      var last = jsonResponse['data']['prenom'];
      global.globalSessionData?.userId=id;
      global.globalSessionData?.username= "$name $last";
      notifyListeners();
      print("logged in saye");
      return true;
    } else {
      return false;
    }
  }

  void logout()async{
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/auth/logout');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      _user = Future.value(User.fromJson(jsonResponse));
      notifyListeners();
    } else {
      throw Exception('failed to log out,error code: ${response.statusCode}');
    }
  }

  //add a token of the user
  void addToken(String token) async{
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
      notifyListeners();
      print("token added saye");
    } else {
      throw Exception('Failed to assign task || error code : ${response.statusCode}');
    }

  }

  //clear the token
  void clearToken() async{
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/AM/token/clear');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'idUser': global.globalSessionData?.userId,
        }));
    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Failed to assign task || error code : ${response.statusCode}');
    }

  }

  void editProfile(nom, prenom, mail, tel, mdp) async{
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/account/edit');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
            'id': global.globalSessionData?.userId,
            'nom'    : nom,
            'prenom' : prenom,
            'mail'   : mail,
            'tel'    : tel,
            'mdp'    : mdp
        }));
    if (response.statusCode == 200) {
      _user?.then((user) {
        user.nom=nom;
        user.prenom=prenom;
        user.email=mail;
        user.phone=tel;
      });
      _user=Future.value(_user);
      notifyListeners();
    } else {
      throw Exception('Failed to assign task || error code : ${response.statusCode}');
    }
  }

  void changePwd(mdp) async{
    final url = Uri.parse('${dotenv.env["BASE_URL"]}/maintenance/account/edit/mdp');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': global.globalSessionData?.userId,
          'mdp':mdp
        }));
    if (response.statusCode == 200) {
      _user?.then((user) => user.password=mdp);
      _user=Future.value(_user);
      notifyListeners();
    } else {
      throw Exception('Failed to change password || error code : ${response.statusCode}');
    }

  }

}