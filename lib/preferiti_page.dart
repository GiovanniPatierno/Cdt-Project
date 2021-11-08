import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Preferiti extends StatefulWidget {
  const Preferiti({Key? key}) : super(key: key);

  @override
  _PreferitiState createState() => _PreferitiState();
}

class _PreferitiState extends State<Preferiti> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferiti'),
        backgroundColor: Colors.black,
      ),
    );
  }
}
