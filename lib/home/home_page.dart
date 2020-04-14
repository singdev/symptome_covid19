import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symptomecovid19/home/home_bloc.dart';
import 'package:symptomecovid19/home/home_event.dart';
import 'package:symptomecovid19/home/home_state.dart';
import 'package:symptomecovid19/home/login/login_screen.dart';
import 'package:symptomecovid19/home/workspace/workspace_page.dart';

import 'splash_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(AppStarted()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is SplashScreenState) {
            return SplashScreen();
          }

          if (state is SignState) {
            return LoginScreen();
          }

          if (state is WorkspaceState) {
            return WorkSpacePage();
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
