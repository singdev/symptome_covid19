import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symptomecovid19/share/repository/user_repository.dart';
import 'package:symptomecovid19/share/security/authentication_management.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final AuthenticationManagement authenticationManagement = new AuthenticationManagement();
  final UserRepository userRepository = new UserRepository();

  @override
  get initialState => SplashScreenState();

  @override
  Stream<HomeState> mapEventToState(event) async* {

    if(event is AppStarted){
      yield SplashScreenState();
      await new Future.delayed(const Duration(seconds : 5));
      bool isConnected = await authenticationManagement.hasToken();
      if(isConnected){
        String username = await userRepository.getUsername();
        yield WorkspaceState(username: username);
      } else {
        yield SignState();
      }
    }
  }

}