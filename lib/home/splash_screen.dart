import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final String backgroundUrl =
      "https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset(
        "images/symptom_covid19_logo.png",
        width: 200,
        height: 200,
      ),
    ));
  }
}
