import 'package:flutter/material.dart';
import 'package:sehatia/splash.dart';

void main() => runApp(Sehatia());

class Sehatia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sehat.ia',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'PTSans',
      ),
      home: Splash(),
    );
  }
}