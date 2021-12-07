import 'package:cdt/account_page.dart';
import 'package:cdt/home_page.dart';
import 'package:cdt/map_page.dart';
import 'package:cdt/padiglioni_page.dart';

import 'package:flutter/material.dart';

import 'new_preferiti.dart';

class Switchh extends StatefulWidget {
   Switchh({Key? key, required this.index2}) : super(key: key);
  int index2;

  @override
  SwitchState createState() => SwitchState();
}


class SwitchState extends State<Switchh> {
  //int currentIndex = 0;


  final screens = [
    const HomePage(),
    const Padiglioni11(),
     const Map1(),
    const Stand2(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    //currentIndex = widget.index2;
    return Scaffold(
      body: IndexedStack(
          index: widget.index2, //currentIndex,
          children: screens
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white30,
        selectedItemColor: Colors.white,
        selectedFontSize: 15,
        currentIndex: widget.index2,//currentIndex,
        onTap: (index) => setState(() => widget.index2 = index),
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
