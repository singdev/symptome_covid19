
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symptomecovid19/home/login/login_event.dart';
import 'package:symptomecovid19/home/login/login_state.dart';
import 'package:symptomecovid19/share/repository/user_repository.dart';
import 'package:symptomecovid19/share/security/authentication_management.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final UserRepository userRepository = new UserRepository();
  final AuthenticationManagement authenticationManagement = new AuthenticationManagement();

  @override
  LoginState get initialState => InitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
      if(event is LoginButtonPressed){
        yield LoginLoadingState();

        try {
          final String accessToken = await userRepository.login(
              event.username, event.password);
          print(accessToken);
          await authenticationManagement.persistToken(accessToken: accessToken);
          yield SignSuccessState(token: accessToken);
        } catch(error){
          print(error);
          yield SignFailureState(username: event.username, password: event.password);
        }
      }

      if(event is RegisterButtonPressed){
        yield LoginLoadingState();

        try {
          final String uid = await userRepository.createUser(
              event.username, event.password);
          final String accessToken = await userRepository.login(
              event.username, event.password);
          await authenticationManagement.persistToken(accessToken: accessToken);
          yield SignSuccessState(token: accessToken);
        } catch(error){
          yield SignFailureState(username: event.username, password: event.password);
        }

      }
  }

}