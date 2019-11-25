import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';

class Antrian extends StatefulWidget {
  @override
  _AntrianState createState() => _AntrianState();
}

class _AntrianState extends State<Antrian> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          firestore().collection('antrian').orderBy('waktu', 'asc').onSnapshot,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Center(child: Text(snapshot.error));
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        return ListView(
          children: snapshot.data.docs.map((doc) {
            DateTime waktu = doc.data()['waktu'];
            return ListTile(
              title: Text(doc.data()['pasien']),
              subtitle: Text(doc.data()['dokter'] + '\n' + waktu.toString()),
              isThreeLine: true,
              trailing: RaisedButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('SELESAI'),
                onPressed: () async {
                  await firestore()
                      .collection('pengguna')
                      .doc(doc.data()['uid'])
                      .collection('riwayat')
                      .add({
                    'nama': doc.data()['dokter'],
                    'waktu': FieldValue.serverTimestamp(),
                  });
                  await doc.ref.delete();
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
