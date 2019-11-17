import 'package:flutter/material.dart';
import 'package:sehatia_dashboard/splash.dart';

void main() => runApp(SehatiaWeb());

class SehatiaWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sehat.ia',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Splash(),
    );
  }
}