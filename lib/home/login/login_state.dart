
class LoginState {}

class LoginLoadingState extends LoginState {}

class InitialState extends LoginState {}

class SignFailureState extends LoginState {
  final String username;
  final String password;

  SignFailureState({ this.username, this.password});
}

class SignSuccessState extends LoginState {
  final String token;
  final String username;

  SignSuccessState({this.token, this.username});
}