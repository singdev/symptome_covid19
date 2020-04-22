
import 'package:symptomecovid19/share/entity/tracking.dart';

class IWorkspaceState {}

class WorkspaceLoading extends IWorkspaceState {}

class SymptomTrackingState extends IWorkspaceState {
  final Tracking tracking;

  SymptomTrackingState({ this.tracking });
}

class GetStartState extends IWorkspaceState {
  final bool hasLastTracking;

  GetStartState({this.hasLastTracking});
}

class LogoutState extends IWorkspaceState {}