import 'package:flutter/material.dart';
import 'package:symptomecovid19/share/entity/symptom.dart';
import 'package:symptomecovid19/share/entity/tracking.dart';

class DaysScreen extends StatefulWidget {
  final Tracking tracking;

  const DaysScreen({Key key, this.tracking}) : super(key: key);
  @override
  _DaysScreenState createState() => _DaysScreenState();
}

class _DaysScreenState extends State<DaysScreen> {
  DateTime getDate(DateTime firstDate, int index){
     return firstDate.add(Duration(days: index));
  }

  List<String> _month = [ "Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

  int calculateNote(Symptom symptom){
    int count = 0;
    int max = 0;
    symptom.toJson().forEach((key, value) {
      max++;
      if(value){
        count++;
      }
    });

    double note = (count / max) * 100;
    return note.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(14, (index) {
        final DateTime date = getDate(widget.tracking.firstDate, index);
        final String month = _month[date.month-1];
        final int note = calculateNote(widget.tracking.days[index]);
        Color color = note < 50 ? Colors.green : Colors.red;
        if(note == 0){
          color = Colors.grey;
        }

        return ListTile(title: Text("Jour ${index+1}"),
        subtitle: Text("${date.day} $month ${date.year}"),
        leading: CircleAvatar(child: Text("$note"),
        backgroundColor: color,
        foregroundColor: Colors.white,),);
      }),
    );
  }
}
