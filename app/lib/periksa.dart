import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Periksa extends StatefulWidget {
  @override
  _PeriksaState createState() => _PeriksaState();
}

class _PeriksaState extends State<Periksa> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Cari Dokter / RS / Puskesmas'),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.filter_list, color: Colors.red),
                    Text(
                      'Filter',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Lokasi:    ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Cari Lokasi'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Spesialisasi:    ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FlatButton(
                      color: _filter == 'anak' ? Colors.red : Colors.white,
                      textColor:
                          _filter == 'anak' ? Colors.white : Colors.black,
                      child: Text('Anak'),
                      onPressed: () {
                        setState(() {
                          _filter = 'anak';
                        });
                      },
                    ),
                    FlatButton(
                      color: _filter == 'gigi' ? Colors.red : Colors.white,
                      textColor:
                          _filter == 'gigi' ? Colors.white : Colors.black,
                      child: Text('Gigi'),
                      onPressed: () {
                        setState(() {
                          _filter = 'gigi';
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('dokter')
                .where('spesialisasi', isEqualTo: _filter)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return ListTile(
                        title: Text(document['nama']),
                        subtitle: Text(document['jadwal'] + '\nRS HUSADA'),
                        isThreeLine: true,
                        leading: Image.asset('img/dokter.png'),
                        trailing: RaisedButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: Text('PERIKSA'),
                          onPressed: () async {
                            FirebaseUser user =
                                await FirebaseAuth.instance.currentUser();
                            Firestore.instance.collection('antrian').add({
                              'dokter': document['nama'],
                              'pasien': user.displayName,
                              'uid': user.uid,
                              'waktu': FieldValue.serverTimestamp(),
                            });
                          },
                        ),
                      );
                    }).toList(),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
