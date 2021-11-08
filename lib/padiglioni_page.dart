import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Padiglioni extends StatefulWidget {
  const Padiglioni({Key? key}) : super(key: key);

  @override
  _PadiglioniState createState() => _PadiglioniState();
}

class _PadiglioniState extends State<Padiglioni> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Padiglioni'),
        backgroundColor: Colors.black,
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(),
          ],

        ),
      )
    );
  }
}
