
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symptomecovid19/home/workspace/workspace_bloc.dart';
import 'package:symptomecovid19/home/workspace/workspace_event.dart';

class GetStartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(flex: 2, child: Image.asset('images/nuage_de_mots.png', width: double.infinity, height: double.infinity, fit: BoxFit.cover,)),
              Expanded(child: Container(),)
            ],
          ),
          Container(decoration: BoxDecoration(color: Color.fromARGB(70, 255, 255, 255)),),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: Container(),),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Cette application vous permet de suivre vos symptôme en suivant la procedure du Centre Opérationnel de Riposte aux Epidémie. Le suivi des symptôme ce fait sur une période de 14 jours. Si tout les symptôme persiste après 14 jours, il faut passer au test Covid19. Vous pouvez commencer le suivi maintenant.",
                  textAlign: TextAlign.justify,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  onPressed: (){
                    //Start new tracking
                    BlocProvider.of<WorkspaceBloc>(context).add(StartButtonPressed());
                  },
                  child: Text("Commencer"),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              )
            ],
          )
        ],
      );
  }
}
