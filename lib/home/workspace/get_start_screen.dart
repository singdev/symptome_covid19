import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symptomecovid19/home/workspace/workspace_bloc.dart';
import 'package:symptomecovid19/home/workspace/workspace_event.dart';

class GetStartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Image.asset(
              'images/nuage_de_mots.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Le suivi des symptômes du COVID-19 ce fait sur une période de 14 jours. Si tout les symptômes persistes après cette période, il faut passer au test Covid19.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(" Vous pouvez commencer le suivi de vos symptômes dès maintenant.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,

          ),),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: RaisedButton(
            onPressed: () {
              //Start new tracking
              BlocProvider.of<WorkspaceBloc>(context).add(StartButtonPressed());
            },
            child: Text("Commencer"),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
          ),
        )
      ],
    );
  }
}
