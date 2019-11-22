import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TambahProfil extends StatefulWidget {
  @override
  _TambahProfilState createState() => _TambahProfilState();
}

class _TambahProfilState extends State<TambahProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Profil'),
      ),
      
    );
  }
}
