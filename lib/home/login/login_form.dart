import 'package:english_words/english_words.dart';
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
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  String state = "login";

  final placeholders = {
    "login": {
      "title": "Je me connecte",
      "username": "Indiquez votre identifiant",
      "password": "Indiquez le mot de passe",
      "button": "Connectez vous",
      "other": "Pas d'identifiant?",
      "button2": "Générez en un"
    },
    "register": {
      "title": "Je m'inscris",
      "username": "Choisissez un identifiant",
      "password": "Indiquez le mot de passe",
      "button": "Inscrivez vous",
      "other": "Déjà un identifiant?",
      "button2": "Utilisez le!"
    }
  };

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();

    if(state == "register"){
      setState(() {
        _usernameController.text = wordPair.join();
      });
    }

    return  ListView(
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(20.0),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(placeholders[state]["title"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.25
                  ),),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: placeholders[state]["username"],
                        contentPadding: EdgeInsets.all(14.0),
                        errorText: widget.error ? "Identifiant incorrecte" : null,
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _passwordController,
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
                      final String username = _usernameController.text;
                      final String password = _passwordController.text;
                      if(state == "login") {
                        BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
                          username: username, password: password
                        ));
                      } else if(state == "register") {
                        BlocProvider.of<LoginBloc>(context).add(RegisterButtonPressed(
                          username: username, password: password
                        ));
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
                      Expanded(child: Text( placeholders[state]["other"],
                        textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 14.0,
                        letterSpacing: 0.25,
                        fontWeight: FontWeight.normal
                      ),)),
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
                          child: Text( placeholders[state]["button2"], textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 0.5
                          ),),
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
