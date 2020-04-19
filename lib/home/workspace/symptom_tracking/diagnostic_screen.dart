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
          getDate(widget.tracking.firstDate, i), 100 - calculateNote(symptom)));
      i++;
    });
    print(series);
    return series;
  }

  List<String> _getDayData(){
    final List<String> data = [];
    for(int i = 0; i< 14; i++){
      String str = "";
      Map<String, dynamic> symptoms = widget.tracking.days[i].toJson();
      symptoms.forEach((key, value) {
        if(value){
          str = "$str + $key";
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
          child: Text(
            "Evolution des symptômes",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 18.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Etat de santé quotidien", style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: 16.0
          ),),
        ),
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(14, (index){
              String value = _getDayData()[index];
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("$value", textAlign: TextAlign.center,
                          style: TextStyle(
                            wordSpacing: 2.0
                          ),),
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
          padding: const EdgeInsets.all(8.0),
          child: Text("Evolution global des symptômes", style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 16.0
          ),),
        ),
        Expanded(
          child: SimpleTimeSeriesChart(
            SimpleTimeSeriesChart.createSampleData(_getData()),
            animate: false,
          ),
        ),
      ],
    );
  }
}
