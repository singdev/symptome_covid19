class WorkspaceEvent {}

class WorkspaceStart extends WorkspaceEvent {}

class StartSymptomTracking extends WorkspaceEvent {
  final String trackingId;

  StartSymptomTracking({this.trackingId});
}

class Logout extends WorkspaceEvent {}