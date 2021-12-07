import 'package:cdt/login_page/stand.dart';
import 'package:cdt/switchh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostStand extends StatefulWidget {
  const PostStand({Key? key}) : super(key: key);

  @override
  _PreStandState createState() => _PreStandState();
}

class _PreStandState extends State<PostStand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(
                    top: 100, right: 20, left: 20, bottom: 20),
                child:
                const Center(
                    child: Text(
                      "Fase di registrazione completata!",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 25,
                        color: Color(0xde000000),
                        letterSpacing: 0.252,
                        height: 1.4285714285714286,
                      ),
                      textAlign: TextAlign.center,
                    ))),
            const Center(
                child: Text(
                  "La tua mappa personalizzata è stata creata \n",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    color: Color(0xde000000),
                    letterSpacing: 0.252,
                    height: 1.4285714285714286,
                  ),
                  textAlign: TextAlign.center,
                )),
            const Center(
                child: Text(
                  "Le tue scelte possono essere cambiate\n nella sezione preferiti \n",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13,
                    color: Color(0xde000000),
                    letterSpacing: 0.252,
                    height: 1.4285714285714286,
                  ),
                  textAlign: TextAlign.center,
                )),
            Center(child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => Switchh(index2: 2)));
              },
              child: const Text('AVANTI'),
            ),)

          ],
        )
    );
  }
}
