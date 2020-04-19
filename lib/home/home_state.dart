
class HomeState {}

class SplashScreenState extends HomeState {}

class SignState extends HomeState {}

class WorkspaceState extends HomeState {
  final String username;

  WorkspaceState({this.username});
}