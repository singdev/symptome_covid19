import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symptomecovid19/home/workspace/workspace_bloc.dart';
import 'package:symptomecovid19/share/entity/tracking.dart';

import '../workspace_event.dart';

class QuizScreen extends StatefulWidget {
  final Tracking tracking;

  const QuizScreen({Key key, this.tracking}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentDay;

  List<String> _month = [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre"
  ];

  List<String> _weeks = [
    "Lundi",
    "Mardi", "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samedi",
    "Dimanche"
  ];

  calculateCurrentDayInde() {
    DateTime today = DateTime.now();
    DateTime firstDate = widget.tracking.firstDate;

    return today.difference(firstDate).inDays;
  }

  Widget _questionView({String title, bool value, Function onChange}) {
    return Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$title",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
                "consectetur adipiscing elit. Phasellus ac augue sed libero fringilla suscipit et quis magna. Donec lobortis turpis lorem, non tincidunt mauris bibendum eu."),
            Row(
              children: <Widget>[
                Expanded(
                  child: RadioListTile(
                    groupValue: value,
                    value: true,
                    title: Text("Oui"),
                    onChanged: (bool value) {
                      setState(() {
                        onChange(value);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    groupValue: value,
                    value: false,
                    title: Text("Non"),
                    onChanged: (bool value) {
                      setState(() {
                        onChange(value);
                      });
                    },
                  ),
                )
              ],
            ),
          ]),
        ));
  }

  @override
  void initState() {
    super.initState();
    _currentDay = calculateCurrentDayInde();
    print(_currentDay);
  }

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<WorkspaceBloc>(context).add(
              UpdateSymptomButtonPressed(
                  symptom: widget.tracking.days[_currentDay],
                  trackingId: widget.tracking.id));
        },
        child: Icon(Icons.check),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0, top: 16.0),
            child: Text(
              "Jour ${_currentDay + 1}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              "${_weeks[today.weekday-1]} ${today.day} ${_month[today.month]} ${today.year}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w100),
            ),
          ),
          _questionView(
              title: "Température",
              value: widget.tracking.days[_currentDay].temperature,
              onChange: (value) {
                widget.tracking.days[_currentDay].temperature = value;
              }),
          _questionView(
              title: "Toux",
              value: widget.tracking.days[_currentDay].toux,
              onChange: (value) {
                widget.tracking.days[_currentDay].toux = value;
              }),
          _questionView(
              title: "Asthenie",
              value: widget.tracking.days[_currentDay].asthenie,
              onChange: (value) {
                widget.tracking.days[_currentDay].asthenie = value;
              }),
          _questionView(
              title: "Difficultés respiratoires",
              value:
                  widget.tracking.days[_currentDay].difficultes_respiratoires,
              onChange: (value) {
                widget.tracking.days[_currentDay].difficultes_respiratoires =
                    value;
              }),
          _questionView(
              title: "Douleurs musculaires",
              value: widget.tracking.days[_currentDay].douleurs_musculaires,
              onChange: (value) {
                widget.tracking.days[_currentDay].douleurs_musculaires = value;
              }),
          _questionView(
              title: "Diarrhées",
              value: widget.tracking.days[_currentDay].diarrhees,
              onChange: (value) {
                widget.tracking.days[_currentDay].diarrhees = value;
              }),
          _questionView(
              title: "Céphalées",
              value: widget.tracking.days[_currentDay].cephalees,
              onChange: (value) {
                widget.tracking.days[_currentDay].cephalees = value;
              }),
          _questionView(
              title: "Maux de gorges",
              value: widget.tracking.days[_currentDay].maux_de_gorges,
              onChange: (value) {
                widget.tracking.days[_currentDay].maux_de_gorges = value;
              }),
          _questionView(
              title: "Yeux rouges",
              value: widget.tracking.days[_currentDay].yeux_rouges,
              onChange: (value) {
                widget.tracking.days[_currentDay].yeux_rouges = value;
              }),
          _questionView(
              title: "Ecoulement nasal",
              value: widget.tracking.days[_currentDay].ecoulement_nasal,
              onChange: (value) {
                widget.tracking.days[_currentDay].ecoulement_nasal = value;
              }),
          _questionView(
              title: "Autres",
              value: widget.tracking.days[_currentDay].autres,
              onChange: (value) {
                widget.tracking.days[_currentDay].autres = value;
              }),
          _questionView(
              title: "Prélèvement",
              value: widget.tracking.days[_currentDay].prelevement,
              onChange: (value) {
                widget.tracking.days[_currentDay].prelevement = value;
              }),
        ],
      ),
    );
  }
}
