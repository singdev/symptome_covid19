
class IWorkspaceState {}

class WorkspaceLoading extends IWorkspaceState {}

class SymptomTrackingState extends IWorkspaceState {
  final String trackingId;

  SymptomTrackingState({ this.trackingId });
}

class GetStartState extends IWorkspaceState {}

class LogoutState extends IWorkspaceState {}