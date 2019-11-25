import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Riwayat extends StatefulWidget {
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  String _uid;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _uid == null
        ? SizedBox.shrink()
        : StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('pengguna')
                .document(_uid)
                .collection('riwayat')
                .orderBy('waktu', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  return ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return ListTile(
                        title: Text('qwe'),
                        subtitle: Text('ASD'),
                        isThreeLine: true,
                      );
                    }).toList(),
                  );
              }
            },
          );
  }
}
