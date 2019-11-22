import 'package:flutter/material.dart';
import 'package:sehatia/home_page.dart';
import 'package:sehatia/periksa.dart';
import 'package:sehatia/profil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  List<Widget> _pages = [
    HomePage(),
    Periksa(),
    SizedBox.shrink(),
    Profil(),
  ];

  List<String> _titles = [
    'Home',
    'Periksa',
    'Riwayat',
    'Profil',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_index],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_index],
      floatingActionButton: _index == 3
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TambahProfil()));
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Image.asset('img/Home.png'),
            activeIcon: Image.asset('img/HomeActive.png'),
          ),
          BottomNavigationBarItem(
            title: Text('Periksa'),
            icon: Image.asset('img/Periksa.png'),
            activeIcon: Image.asset('img/PeriksaActive.png'),
          ),
          BottomNavigationBarItem(
            title: Text('Riwayat'),
            icon: Image.asset('img/Riwayat.png'),
            activeIcon: Image.asset('img/RiwayatActive.png'),
          ),
          BottomNavigationBarItem(
            title: Text('Profil'),
            icon: Image.asset('img/Profil.png'),
            activeIcon: Image.asset('img/ProfilActive.png'),
          ),
        ],
      ),
    );
  }
}
