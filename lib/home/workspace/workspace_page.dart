import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symptomecovid19/home/home_page.dart';
import 'package:symptomecovid19/home/workspace/get_start_screen.dart';
import 'package:symptomecovid19/home/workspace/symptom_tracking/symptom_tracking_page.dart';
import 'package:symptomecovid19/home/workspace/workspace_bloc.dart';
import 'package:symptomecovid19/home/workspace/workspace_event.dart';
import 'package:symptomecovid19/home/workspace/workspace_state.dart';

class WorkSpacePage extends StatefulWidget {

  final String username;

  const WorkSpacePage({Key key, @required this.username}) : super(key: key);

  @override
  _WorkSpacePageState createState() => _WorkSpacePageState();
}

class _WorkSpacePageState extends State<WorkSpacePage> {
  WorkspaceBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = new WorkspaceBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkspaceBloc>(
      create: (context) => _bloc..add(WorkspaceStart()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Symptôme COVID-19"),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Bienvenue!", style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 0.15
                      ),),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "${widget.username}",
                          style: TextStyle(
                              color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 24.0),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("images/wallpaper.png"),
                          fit: BoxFit.cover))),
              ListTile(
                title: Text("Recommencer le suivi"),
                leading: Icon(Icons.favorite),
                onTap: () {
                  Navigator.of(context).pop();
                  _bloc..add(StartButtonPressed());
                },
              ),
              ListTile(
                title: Text("Déconnexion"),
                leading: Icon(Icons.power_settings_new),
                onTap: () {
                  _bloc.add(Logout());
                },
              )
            ],
          ),
        ),
        body: BlocBuilder<WorkspaceBloc, IWorkspaceState>(
          builder: (context, state) {
            if (state is WorkspaceLoading) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is GetStartState) {
              return GetStartScreen(hasLastTracking: state.hasLastTracking,);
            }

            if (state is LogoutState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => HomePage()));
              });
            }

            if (state is SymptomTrackingState) {
              return SymptomTrackingPage(
                tracking: state.tracking,
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
