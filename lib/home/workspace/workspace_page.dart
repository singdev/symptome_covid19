import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symptomecovid19/home/home_page.dart';
import 'package:symptomecovid19/home/workspace/get_start_screen.dart';
import 'package:symptomecovid19/home/workspace/workspace_bloc.dart';
import 'package:symptomecovid19/home/workspace/workspace_event.dart';
import 'package:symptomecovid19/home/workspace/workspace_state.dart';

class WorkSpacePage extends StatefulWidget {
  @override
  _WorkSpacePageState createState() => _WorkSpacePageState();
}

class _WorkSpacePageState extends State<WorkSpacePage> {

  WorkspaceBloc _bloc;

  @override
  void initState(){
    super.initState();

    _bloc = new WorkspaceBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkspaceBloc>(
      create: (context) => _bloc..add(WorkspaceStart()),
      child: Scaffold(
        appBar: AppBar(title: Text("Symptom COVID-19 Tracking"),),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    Text("Symptom COVID-19 Tracking", style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                    ),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Pour ceux qui ressentent les symptômes du covid-19",
                      style: TextStyle(
                        color: Colors.white
                      ),),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark
                ),
              ),
              ListTile(
                title: Text("Déconnexion"),
                leading: Icon(Icons.power_settings_new),
                onTap: (){
                  _bloc.add(Logout());
                },
              )
            ],
          ),
        ),
        body: BlocBuilder<WorkspaceBloc, IWorkspaceState>(
          builder: (context, state){
            if(state is WorkspaceLoading) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator(),),
              );
            }

            if(state is GetStartState){
              return GetStartScreen();
            }

            if(state is LogoutState){
              WidgetsBinding.instance.addPostFrameCallback((_){
                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => HomePage()));
              });
            }

            if(state is SymptomTrackingState){
              return Container(child: Text("Workspace"),);
            }

            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
