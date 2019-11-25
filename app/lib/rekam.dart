import 'package:flutter/material.dart';

class Rekam extends StatefulWidget {
  @override
  _RekamState createState() => _RekamState();
}

class _RekamState extends State<Rekam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rekam Medis'),
      ),
      body: Image.asset('img/rekam.png'),
    );
  }
}