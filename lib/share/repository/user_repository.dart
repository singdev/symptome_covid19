
import 'dart:convert';

import 'package:http/http.dart' as http;

class UserRepository {

  final URL = "http://192.168.43.2:20201";

  Future<String> login(username, password) async {

    final response = await http.post("$URL/api/oauth/token", headers: {
      "Content-Type": "Application/json"
    }, body: jsonEncode({
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
    final response = await http.post("$URL/users", headers: {
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
}