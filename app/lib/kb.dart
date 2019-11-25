import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KB extends StatefulWidget {
  @override
  _KBState createState() => _KBState();
}

class _KBState extends State<KB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KB'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('KB').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return ListTile(
                    title: Text(
                      document['tipe'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(document['deskripsi']),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RSKB()));
                    },
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}

class RSKB extends StatefulWidget {
  @override
  _RSKBState createState() => _RSKBState();
}

class _RSKBState extends State<RSKB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RS Penyedia KB'),
      ),
      body: Image.asset('img/rs_imunisasi.png'),
    );
  }
}
