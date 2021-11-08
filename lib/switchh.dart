import 'package:cdt/account_page.dart';
import 'package:cdt/home_page.dart';
import 'package:cdt/map_page.dart';
import 'package:cdt/padiglioni_page.dart';
import 'package:cdt/preferiti_page.dart';
import 'package:flutter/material.dart';

class Switchh extends StatefulWidget {
  const Switchh({Key? key}) : super(key: key);

  @override
  SwitchState createState() => SwitchState();
}


class SwitchState extends State<Switchh> {
  int currentIndex = 0;

  final screens =[
    const HomePage(),
    const Padiglioni(),
    const Map(),
    const Preferiti(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white30,
        selectedItemColor: Colors.white,
        selectedFontSize: 15,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance),
              label: 'Padiglioni',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Preferiti'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account'
          )
        ],
      ),
    );
  }
}
