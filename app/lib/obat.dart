import 'package:flutter/material.dart';

class Obat extends StatefulWidget {
  @override
  _ObatState createState() => _ObatState();
}

class _ObatState extends State<Obat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konsumsi Obat'),
      ),
      body: SingleChildScrollView(
        child: Image.asset('img/obat.png'),
      ),
    );
  }
}
