import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symptomecovid19/home/login/login_event.dart';

import 'login_bloc.dart';

class LoginForm extends StatefulWidget {

  final bool error;

  const LoginForm({Key key, this.error}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String state = "login";

  final placeholders = {
    "login": {
      "username": "Indiquez votre identifiant",
      "password": "Indiquez le mot de passe",
      "button": "Connectez vous",
      "other": "Pas d'identifiant?",
      "button2": "Générez en un"
    },
    "register": {
      "username": "Choisissez un identifiant",
      "password": "Indiquez le mot de passe",
      "button": "Inscrivez vous",
      "other": "Déjà un identifiant?",
      "button2": "Utilisez le!"
    }
  };

  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(20.0),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 64.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(labelText: placeholders[state]["username"],
                        contentPadding: EdgeInsets.all(14.0),
                        errorText: widget.error ? "Identifiant incorrecte" : null,
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(labelText:  placeholders[state]["password"],
                        contentPadding: EdgeInsets.all(14.0),
                        errorText: widget.error ? "Identifiant incorrecte": null,
                        border: OutlineInputBorder()),
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: (){
                      if(state == "login") {
                        BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed());
                      } else if(state == "register") {
                        BlocProvider.of<LoginBloc>(context).add(RegisterButtonPressed());
                      }
                    },
                    child: Text( placeholders[state]["button"]),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child: Text( placeholders[state]["other"], textAlign: TextAlign.end,)),
                      Expanded(
                        child: FlatButton(
                          onPressed: (){
                            setState(() {
                              if(state == "login"){
                                state = "register";
                              } else if(state == "register"){
                                state = "login";
                              }
                            });
                          },
                          child: Text( placeholders[state]["button2"], textAlign: TextAlign.start,),
                          textColor: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
