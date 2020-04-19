
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {

  final String url = "http://54.38.190.167:20201";

  static const String USERNAME_KEY = "symptomecovid19username";

  Future<String> login(username, password) async {
    final response = await http.post("$url/api/oauth/token", headers: {
      "Content-Type": "Application/json"
    }, body: jsonEncode({
      "grant_type": 'password',
      "username": username,
      "password": password
    }));

    if(response.statusCode == 200){
      return response.body;
    } else {
      throw new Exception(response.body);
    }
  }

  Future<String> createUser(username, password) async {
    final response = await http.post("$url/users", headers: {
    "Content-Type": "Application/json"
    }, body: jsonEncode({
    "username": username,
    "password": password
    }));

    if(response.statusCode == 200){
        return jsonDecode(response.body)["newUser"]["_id"];
    } else {
      throw new Exception(response.body);
    }
  }

  Future<String> getUsername() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(USERNAME_KEY);
  }

  Future<String> persistUsername(String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(USERNAME_KEY, username);
  }
}
