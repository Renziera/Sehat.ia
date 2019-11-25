import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Imunisasi extends StatefulWidget {
  @override
  _ImunisasiState createState() => _ImunisasiState();
}

class _ImunisasiState extends State<Imunisasi> {
  List<DocumentSnapshot> _list;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    QuerySnapshot qs = await Firestore.instance
        .collection('pengguna')
        .document(user.uid)
        .collection('profil')
        .getDocuments();
    setState(() {
      _list = qs.documents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _list == null
        ? Scaffold(
            appBar: AppBar(
              title: Text('Imunisasi'),
            ),
            body: Center(child: CircularProgressIndicator()),
          )
        : DefaultTabController(
            length: _list.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Imunisasi'),
                bottom: TabBar(
                  tabs: _list.map((doc) {
                    return Tab(text: doc['nama']);
                  }).toList(),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.send),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RSImunisasi()));
                },
              ),
              body: TabBarView(
                children: _list.map((doc) {
                  int umur = num.parse(doc['umur']);

                  return StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('imunisasi')
                        .where('balita', isEqualTo: (umur < 5))
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          return ListView(
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return CardImunisasi(document: document);
                            }).toList(),
                          );
                      }
                    },
                  );
                }).toList(),
              ),
            ),
          );
  }
}

class CardImunisasi extends StatefulWidget {
  final DocumentSnapshot document;

  const CardImunisasi({Key key, @required this.document}) : super(key: key);

  @override
  _CardImunisasiState createState() => _CardImunisasiState();
}

class _CardImunisasiState extends State<CardImunisasi> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Card(
                  color:
                      widget.document['penting'] ? Colors.blue : Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      widget.document['penting'] ? 'Wajib' : 'Opsional',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Checkbox(
                  onChanged: (x) {
                    setState(() {
                      _isChecked = x;
                    });
                  },
                  value: _isChecked,
                ),
              ],
            ),
            Text(
              widget.document['nama'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.document['umur'],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Text(
              widget.document['deskripsi'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RSImunisasi extends StatefulWidget {
  @override
  _RSImunisasiState createState() => _RSImunisasiState();
}

class _RSImunisasiState extends State<RSImunisasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RS Imunisasi'),
      ),
      body: Image.asset('img/rs_imunisasi.png'),
    );
  }
}
