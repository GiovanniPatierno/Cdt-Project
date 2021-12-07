import 'package:cdt/login_page/stand.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../switchh.dart';

class PostLogin extends StatefulWidget {
  const PostLogin({Key? key}) : super(key: key);

  @override
  _PreStandState createState() => _PreStandState();
}

class _PreStandState extends State<PostLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(
                      top: 220, right: 20, left: 20, bottom: 20),
                  child:
                  const Center(
                      child: Text(
                        "Bentornato! \n Le tue scelte per l'ultima visita sono state salvate. Vuoi visitare gli stessi stand o preferisci selezionarne di nuovi?",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          color: Color(0xde000000),
                          letterSpacing: 0.252,
                          height: 1.4285714285714286,
                        ),
                        textAlign: TextAlign.center,
                      ))),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (contex) => Switchh(index2: 2)));
                },
                child: const Text('CONTINUA'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (contex) => const Stand()));
                },
                child: const Text('NUOVO PERCORSO'),
              )
            ]
        )
    );
  }
}
