
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationManagement {

  final String TOKEN_PERSIST_KEY = "symptome_covid_token";

  Future<void> persistToken({ String accessToken}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(TOKEN_PERSIST_KEY, accessToken);
  }

  Future<void> removeToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(TOKEN_PERSIST_KEY);
  }

  Future<bool> hasToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(TOKEN_PERSIST_KEY);
  }
}