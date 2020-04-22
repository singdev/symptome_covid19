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

  calculateCurrentDayIndex() {
    final now = DateTime.now();
    final today = new DateTime(now.year, now.month, now.day);
    final firstDate = new DateTime(widget.tracking.firstDate.year, widget.tracking.firstDate.month, widget.tracking.firstDate.day);
    return today.difference(firstDate).inDays;
  }

  Widget _questionView({String title, String description, bool value, Function onChange}) {
    return Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$title",
                style: TextStyle(fontSize: 20.0, letterSpacing: 0.15, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("$description",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.5
              ),),
            ),
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
    _currentDay = calculateCurrentDayIndex();
  }

  @override
  Widget build(BuildContext context) {
    _currentDay = calculateCurrentDayIndex();
    final DateTime today = DateTime.now();
    return _currentDay >= 14 ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Votre suivi est terminé!",
          textAlign: TextAlign.center,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Si vous avez toujours des symptômes, appelez le 1410",
          textAlign: TextAlign.center,),
        )
      ],
    )
        : Scaffold(
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
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 48.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              "${_weeks[today.weekday-1]} ${today.day} ${_month[today.month]} ${today.year}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, letterSpacing: 0),
            ),
          ),
          _questionView(
              title: "Température",
              description: "Avez vous plus de 38° de fièvre ?",
              value: widget.tracking.days[_currentDay].temperature,
              onChange: (value) {
                widget.tracking.days[_currentDay].temperature = value;
              }),
          _questionView(
              title: "Toux",
              description: "Avez vous une toux sèche (une toux dite productive, cela signifie qu'elle permet de désencombrer les poumons en évacuant les sécrétions. Ces sécrétions, composées d’eau et de mucus, un liquide épais et collant permettent de nettoyer les bronches)?",
              value: widget.tracking.days[_currentDay].toux,
              onChange: (value) {
                widget.tracking.days[_currentDay].toux = value;
              }),
          _questionView(
              title: "Asthenie",
              description: "Avez vous un état de fatigue récurrent non lié à une activité physique intense?",
              value: widget.tracking.days[_currentDay].asthenie,
              onChange: (value) {
                widget.tracking.days[_currentDay].asthenie = value;
              }),
          _questionView(
              title: "Difficultés respiratoires",
              description: "Avez vous une sensation de gêne, d’oppression et d’essoufflement. Chaque mouvement respiratoire devient il un effort et n’est plus automatique?",
              value:
                  widget.tracking.days[_currentDay].difficultes_respiratoires,
              onChange: (value) {
                widget.tracking.days[_currentDay].difficultes_respiratoires =
                    value;
              }),
          _questionView(
              title: "Douleurs musculaires",
              description: "Avez vous des douleurs musculaires non lié à une activité physique intense",
              value: widget.tracking.days[_currentDay].douleurs_musculaires,
              onChange: (value) {
                widget.tracking.days[_currentDay].douleurs_musculaires = value;
              }),
          _questionView(
              title: "Diarrhées",
              description: "Avez vous des selles de consistance liquide ou molle, plus volumineuses et nombreuses qu’à l’habitude (plus de 3 selles par jour)",
              value: widget.tracking.days[_currentDay].diarrhees,
              onChange: (value) {
                widget.tracking.days[_currentDay].diarrhees = value;
              }),
          _questionView(
              title: "Céphalées",
              description: "Avez vous des maux de tête récurent?",
              value: widget.tracking.days[_currentDay].cephalees,
              onChange: (value) {
                widget.tracking.days[_currentDay].cephalees = value;
              }),
          _questionView(
              title: "Maux de gorges",
              description: "Avez vous des picotements, des douleurs ou des sensations de brûlures, ainsi que des difficultés à avaler ou à parler?",
              value: widget.tracking.days[_currentDay].maux_de_gorges,
              onChange: (value) {
                widget.tracking.days[_currentDay].maux_de_gorges = value;
              }),
          _questionView(
              title: "Yeux rouges",
              description: "Vos yeux sont ils rouge? ou avez vous une irritation, des brûlures, des démangeaison des yeux, une sécheresse, des douleur, de l’écoulement, des yeux larmoyants, de la sensibilité à la lumière, une vision floue?",
              value: widget.tracking.days[_currentDay].yeux_rouges,
              onChange: (value) {
                widget.tracking.days[_currentDay].yeux_rouges = value;
              }),
          _questionView(
              title: "Ecoulement nasal",
              description: "Avez vous des éternuements et des reniflements",
              value: widget.tracking.days[_currentDay].ecoulement_nasal,
              onChange: (value) {
                widget.tracking.days[_currentDay].ecoulement_nasal = value;
              }),
          _questionView(
              title: "Autres",
              description: "Avez vous des symptômes autre que ceux cités avant?",
              value: widget.tracking.days[_currentDay].autres,
              onChange: (value) {
                widget.tracking.days[_currentDay].autres = value;
              }),
          _questionView(
              title: "Prélèvement",
              description: "Question réservé aux personnes en quarantaire. Dans le cas contraire vous pouvez répondre non.",
              value: widget.tracking.days[_currentDay].prelevement,
              onChange: (value) {
                widget.tracking.days[_currentDay].prelevement = value;
              }),
        ],
      ),
    );
  }
}
