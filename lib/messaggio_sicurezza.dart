import 'package:cdt/login_page/login.dart';
import 'package:cdt/login_page/stand.dart';
import 'package:cdt/switchh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagioSicurezza extends StatefulWidget {
  const MessagioSicurezza({Key? key}) : super(key: key);

  @override
  _PreStandState createState() => _PreStandState();
}

class _PreStandState extends State<MessagioSicurezza> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
          children:  <Widget>[
            Container(
                padding: const EdgeInsets.only(top: 150, right: 20, left: 20, bottom: 20),
                child:
                const Center(
                    child: Text(
                    "Sei proprio sicuro di voler cancellare il tuo account?",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        color: Color(0xde000000),
                        letterSpacing: 0.252,
                        height: 1.4285714285714286,
                      ),
                      textAlign: TextAlign.center,
                    ))),
            Center(child:  ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
              ),
              onPressed:(){ Navigator.push(context,
                  MaterialPageRoute(builder: (contex) => const Login()));} ,
              child: const Text('ELIMINA DEFINITIVAMENTE'),
            ),)

          ],
        )
    );
  }
}
