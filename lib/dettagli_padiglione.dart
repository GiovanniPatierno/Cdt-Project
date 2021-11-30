import 'package:cdt/padiglioni_page.dart' as pad;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'map_page.dart';

class Dettagli extends StatelessWidget {
  const Dettagli({Key? key, required this.index, required this.data})
      : super(key: key);
  final int index;
  final List<pad.Photo> data;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
          children: <Widget>[
            Container(

                margin: EdgeInsets.only(top: 100, right: 20, left: 20),
                child:
                Text(data[index].nome, style: const TextStyle(fontSize: 25),)),
            Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.only(top: 50, right: 20, left: 20),
                child:

                Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child:
                      Image.asset('assets/images/padiglione-francia-expo.jpg'),
                      //Image.asset('assets/images/padiglione-francia-expo.jpg'),
                      //Image.asset('assets/images/padiglione-francia-expo.jpg'),
                      //Image.asset('assets/images/padiglione-francia-expo.jpg'),
                      //Image.asset('assets/images/padiglione-francia-expo.jpg'),
                    )
                  ],
                )),
            Container(
                margin: const EdgeInsets.only(top: 150, right: 20, left: 20),
                child:
                const Text(
                    "Qui verrà la descrizione di ogni padiglione recuperata dall' Api",
                    textAlign: TextAlign.start)
            ),
            Container(
                margin: const EdgeInsets.only(top: 100, right: 20, left: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Map1()),
                    );
                  },
                  child: const Text('Vai alla Mappa'),
                )
            )
          ]
      ),
    );
  }
}

