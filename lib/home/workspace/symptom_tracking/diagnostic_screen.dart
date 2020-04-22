import 'package:flutter/material.dart';
import 'package:symptomecovid19/home/workspace/symptom_tracking/chart.dart';
import 'package:symptomecovid19/share/entity/symptom.dart';
import 'package:symptomecovid19/share/entity/tracking.dart';

class DiagnosticScreen extends StatefulWidget {
  final Tracking tracking;

  const DiagnosticScreen({Key key, this.tracking}) : super(key: key);

  @override
  _DiagnosticScreenState createState() => _DiagnosticScreenState();
}

class _DiagnosticScreenState extends State<DiagnosticScreen> {
  int calculateNote(Symptom symptom) {
    int count = 0;
    int max = 0;
    symptom.toJson().forEach((key, value) {
      max++;
      if (value) {
        count++;
      }
    });

    double note = (count / max) * 100;
    return note.toInt();
  }

  DateTime getDate(DateTime firstDate, int index) {
    return firstDate.add(Duration(days: index));
  }

  List<TimeSeriesSales> _getData() {
    List<TimeSeriesSales> series = [];
    int i = 0;
    widget.tracking.days.forEach((symptom) {
      series.add(TimeSeriesSales(
          getDate(widget.tracking.firstDate, i), calculateNote(symptom)));
      i++;
    });
    return series;
  }

  Map<String, String> _symptomName = {
    "temperature": "Température",
    "toux": "Toux",
    "douleurs_musculaire": "Douleurs musculaires",
    "asthenie": "Asthénie",
    "difficulte_respiratoire": "Difficultés respiratoires",
    "diarrhe": "Diarrhé",
    "cephalees": "Céphalées",
    "maux_de_gorges": "Maux de gorges",
    "yeux_rouges": "Yeux rouge",
    "ecoulement_nasal": "Ecoulement nasal",
    "autres": "Autres",
    "prelevement": "Prélèvement"
  };

  List<List<String>> _getDayData(){
    final List<List<String>> data = [];
    for(int i = 0; i< 14; i++){
      List<String> str = [];
      Map<String, dynamic> symptoms = widget.tracking.days[i].toJson();
      symptoms.forEach((key, value) {
        if(value){
           str.add("${_symptomName[key]}");
        }
      });
      data.add(str);
    }
    return data;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Etat de santé quotidien", style: TextStyle(
            letterSpacing: 0.15,
            fontSize: 20.0
          ),),
        ),
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(14, (index){
              List<String> value = _getDayData()[index];
              return Container(
                width: 350,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text("Jour ${index+1}", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                        ),),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.count(crossAxisCount: 3,
                                childAspectRatio: 6/3,
                              children: List.generate(value.length, (index2){
                                return  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.0),
                                        color: Colors.blue),
                                    margin: EdgeInsets.all(4.0),
                                    padding: EdgeInsets.all(2.0),
                                    child: Center(child: Text("${value[index2]}", textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      letterSpacing: 0.25
                                    ),)));
                              })),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text("Evolution global des symptômes",
            style: TextStyle(
              letterSpacing: 0.15,
              fontSize: 20.0
          ),),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SimpleTimeSeriesChart(
              SimpleTimeSeriesChart.createSampleData(_getData()),
              animate: false,
            ),
          ),
        ),
      ],
    );
  }
}
