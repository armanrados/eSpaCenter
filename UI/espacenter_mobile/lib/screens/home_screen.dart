import 'package:espacenter_mobile/screens/galerija_list_screen.dart';
import 'package:espacenter_mobile/screens/novosti_list_screen.dart';
import 'package:espacenter_mobile/screens/proizvod_screen.dart';
import 'package:espacenter_mobile/screens/recenzija_screen.dart';
import 'package:espacenter_mobile/screens/profile_screen.dart';
import 'package:espacenter_mobile/screens/termini_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Widget> _pages = <Widget>[
    NovostiListScreen(),
    TerminiScreen(),
    ProizvodScreen(),
    GalerijaListScreen(),
    RecenzijaScreen(),
    ProfileScreen()];
  int _currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
    
      body:_pages.elementAt(_currentIndex),
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor:Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 33, 103, 243),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Naslovna',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Termini',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Proizvodi',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Galerija',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Recenzije',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profil',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}