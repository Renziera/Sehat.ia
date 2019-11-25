import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
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
                .collection('profil')
                .orderBy('waktu')
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
                        title: Text(document['nama']),
                        subtitle: Text(document['umur'] + ' tahun'),
                        leading: Image.asset('img/anak.png'),
                        onLongPress: () {
                          document.reference.delete();
                        },
                      );
                    }).toList(),
                  );
              }
            },
          );
  }
}

class TambahProfil extends StatefulWidget {
  @override
  _TambahProfilState createState() => _TambahProfilState();
}

class _TambahProfilState extends State<TambahProfil> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _umurController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Nama Lengkap'),
              controller: _controller,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Umur'),
              keyboardType: TextInputType.number,
              controller: _umurController,
            ),
            RaisedButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('TAMBAH'),
              onPressed: () async {
                if (_controller.text.isEmpty || _umurController.text.isEmpty)
                  return;
                FirebaseUser user = await FirebaseAuth.instance.currentUser();
                await Firestore.instance
                    .collection('pengguna')
                    .document(user.uid)
                    .collection('profil')
                    .add({
                  'nama': _controller.text,
                  'umur': _umurController.text,
                  'waktu': FieldValue.serverTimestamp(),
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
