
import 'package:bloc/bloc.dart';
import 'package:symptomecovid19/home/workspace/workspace_event.dart';
import 'package:symptomecovid19/home/workspace/workspace_state.dart';
import 'package:symptomecovid19/share/security/authentication_management.dart';
import 'package:symptomecovid19/share/tracking_management.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, IWorkspaceState> {

  final TrackingManager trackingManager = new TrackingManager();
  final AuthenticationManagement authenticationManagement = new AuthenticationManagement();

  @override
  IWorkspaceState get initialState => WorkspaceLoading();

  @override
  Stream<IWorkspaceState> mapEventToState(WorkspaceEvent event) async* {

    if(event is WorkspaceStart){
      yield WorkspaceLoading();
      bool onTracking = await trackingManager.onTracking();

      if(onTracking){
        String trackingId = await trackingManager.getCurrentTrackingId();
        yield SymptomTrackingState(trackingId: trackingId);
      } else {
        yield GetStartState();
      }
    }

    if(event is Logout){
      yield WorkspaceLoading();
      await authenticationManagement.removeToken();
      yield LogoutState();
    }

    if(event is StartSymptomTracking){
      yield WorkspaceLoading();
      //TODO
    }
  }

}