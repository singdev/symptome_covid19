
import 'package:bloc/bloc.dart';
import 'package:symptomecovid19/home/workspace/workspace_event.dart';
import 'package:symptomecovid19/home/workspace/workspace_state.dart';
import 'package:symptomecovid19/share/entity/tracking.dart';
import 'package:symptomecovid19/share/repository/tracking_repository.dart';
import 'package:symptomecovid19/share/security/authentication_management.dart';
import 'package:symptomecovid19/share/tracking_management.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, IWorkspaceState> {

  final TrackingManager trackingManager = new TrackingManager();
  final AuthenticationManagement authenticationManagement = new AuthenticationManagement();
  final TrackingRepository trackingRepository = new TrackingRepository();

  @override
  IWorkspaceState get initialState => WorkspaceLoading();

  @override
  Stream<IWorkspaceState> mapEventToState(WorkspaceEvent event) async* {

    if(event is WorkspaceStart){
      yield WorkspaceLoading();
      bool onTracking = await trackingManager.onTracking();

      if(onTracking){
        String trackingId = await trackingManager.getCurrentTrackingId();
        String token = await authenticationManagement.getToken();
        try {
          Tracking tracking = await trackingRepository.getTracking(
              token: token, id: trackingId);
          yield SymptomTrackingState(tracking: tracking);
        } catch(error){
          yield GetStartState(hasLastTracking: false);
        }
      } else {
        String token = await authenticationManagement.getToken();
        List<Tracking> list = await trackingRepository.getAllTracking(token: token);
        yield GetStartState(hasLastTracking: list.isNotEmpty);
      }
    }

    if(event is Logout){
      yield WorkspaceLoading();
      await authenticationManagement.removeToken();
      await trackingManager.removeTrackingData();
      yield LogoutState();
    }

    if(event is StartButtonPressed){
      yield WorkspaceLoading();

      final String token = await authenticationManagement.getToken();
      try {
        Tracking tracking = await trackingRepository.createTracking(
            token: token);
        await trackingManager.persistTrackingId(id: tracking.id);
        yield SymptomTrackingState(tracking: tracking);
      } catch(error){
        print(error);
      }
    }

    if(event is ContinueWithLastTracking){
      yield WorkspaceLoading();
      String token = await authenticationManagement.getToken();
      List<Tracking> list = await trackingRepository.getAllTracking(token: token);
      if(list.last != null) {
        yield SymptomTrackingState(tracking: list.last);
      } else {
        yield GetStartState(hasLastTracking: false);
      }
    }

    if(event is UpdateSymptomButtonPressed){
      yield WorkspaceLoading();

      final String token = await authenticationManagement.getToken();

      try {
        await trackingRepository.updateSymptomForCurrentDay(token: token, id: event.trackingId, symptom: event.symptom);
        Tracking tracking = await trackingRepository.getTracking(token: token, id: event.trackingId);
        yield SymptomTrackingState(tracking: tracking);
      } catch(error){
        print(error);
      }
    }
  }

}