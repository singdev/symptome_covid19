import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symptomecovid19/home/workspace/workspace_bloc.dart';
import 'package:symptomecovid19/home/workspace/workspace_event.dart';

class GetStartScreen extends StatelessWidget {

  final bool hasLastTracking;

  const GetStartScreen({Key key, this.hasLastTracking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
                'images/drapeau_du_gabon.png',
                width: 150,
                height: 150,
              ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            "Le suivi des symptômes du COVID-19 se fait sur une période de 14 jours. Si tout les symptômes persistes après cette période, il faut passer au test Covid19.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 8.0, bottom: 8.0),
          child: RaisedButton(
            padding: EdgeInsets.all(16.0),
            onPressed: () {
              //Start new tracking
              BlocProvider.of<WorkspaceBloc>(context).add(StartButtonPressed());
            },
            child: Text("Commencer", style: TextStyle(fontSize: 14.0,
                letterSpacing: 1.24,
            ),),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
          ),
        ),
        hasLastTracking ? Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 8.0, bottom: 8.0),
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<WorkspaceBloc>(context).add(ContinueWithLastTracking());
            },
            child: Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Theme.of(context).primaryColor)
                  ),
                  child: Text("Continuer votre suivi actuel", textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14
                  ),),
                ),
              ),
        ): Container(),
      ],
    );
  }
}
