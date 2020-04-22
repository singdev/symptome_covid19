import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symptomecovid19/home/login/login_bloc.dart';
import 'package:symptomecovid19/home/login/login_form.dart';
import 'package:symptomecovid19/home/workspace/workspace_page.dart';

import 'login_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String coronavirusImageUrl =
      "https://images.unsplash.com/photo-1584118624012-df056829fbd0?ixlib=rb-1.2.1&auto=format&fit=crop&w=889&q=80";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      coronavirusImageUrl,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Container(
                      color: Color.fromARGB(128, 0, 0, 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Symptôme Covid-19",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0.25,
                                  fontSize: 34.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Pour suivre l'évolution des symptômes du COVID-19 au quotidien",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                fontSize: 16.0,
                                letterSpacing: 0.15,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Expanded(
                  flex: 2,
                  child: BlocProvider<LoginBloc>(
                    create: (BuildContext context) => LoginBloc(),
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is InitialState) {
                          return LoginForm(
                            error: false,
                          );
                        }

                        if (state is LoginLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is SignFailureState) {
                          return LoginForm(
                            error: true,
                          );
                        }

                        if (state is SignSuccessState) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => WorkSpacePage(
                                          username: state.username,
                                        )));
                          });
                        }

                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
