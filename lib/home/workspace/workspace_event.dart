import 'package:symptomecovid19/share/entity/symptom.dart';

class WorkspaceEvent {}

class WorkspaceStart extends WorkspaceEvent {}

class StartButtonPressed extends WorkspaceEvent {}

class UpdateSymptomButtonPressed extends WorkspaceEvent {
  final Symptom symptom;
  final String trackingId;

  UpdateSymptomButtonPressed({this.symptom, this.trackingId});
}

class Logout extends WorkspaceEvent {}