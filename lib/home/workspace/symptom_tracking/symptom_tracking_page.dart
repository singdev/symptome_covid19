import 'package:flutter/material.dart';
import 'package:symptomecovid19/home/workspace/symptom_tracking/days_screen.dart';
import 'package:symptomecovid19/home/workspace/symptom_tracking/quiz_screen.dart';
import 'package:symptomecovid19/share/entity/tracking.dart';

import 'diagnostic_screen.dart';

class SymptomTrackingPage extends StatefulWidget {
  final Tracking tracking;

  const SymptomTrackingPage({Key key, @required this.tracking}) : super(key: key);

  @override
  _SymptomTrackingPageState createState() => _SymptomTrackingPageState();
}

class _SymptomTrackingPageState extends State<SymptomTrackingPage> {

  int _currentNavIndex = 1;

  Widget _currentScreen(){
    if(_currentNavIndex == 0){
        return QuizScreen(tracking: widget.tracking,);
    } else if(_currentNavIndex == 1){
        return DaysScreen(tracking: widget.tracking,);
    } else if(_currentNavIndex == 2){
        return DiagnosticScreen(tracking: widget.tracking,);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        onTap: (int index){
          setState(() {
            _currentNavIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text("Questionnaire"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            title: Text("Jours"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            title: Text("Evolution")
          )
        ],
      ),
      body: _currentScreen(),
    );
  }
}
