import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sehat.ia'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'RS Husada',
                style: TextStyle(color: Colors.white, fontSize: 48),
              ),
              decoration: BoxDecoration(color: Colors.red),
            ),
            ListTile(
              title: Text('Antrian'),
              leading: Icon(Icons.av_timer),
              onTap: () {
                setState(() {
                  _index = 0;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Reminder'),
              leading: Icon(Icons.schedule),
              onTap: () {
                setState(() {
                  _index = 0;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Imunisasi'),
              leading: Icon(Icons.local_hospital),
              onTap: () {
                setState(() {
                  _index = 0;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Rekam Medis'),
              leading: Icon(Icons.list),
              onTap: () {
                setState(() {
                  _index = 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
