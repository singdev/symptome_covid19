
class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String password;
  final String username;

  LoginButtonPressed({this.username, this.password});
}

class RegisterButtonPressed extends LoginEvent {
  final String username;
  final String password;

  RegisterButtonPressed({this.username, this.password});
}