import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../switchh.dart';

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://192.168.1.241:9250/api/padiglioni'));
  print(response.body);
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String id;
  final String nome;
  //final String descrizione;
  final String area;
  //final String immagine;

  const Photo( {
    //required this.immagine,
    //required this.descrizione,
    required this.area,
    required this.id,
    required this.nome,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      nome: json['nome'] as String,
      area: json['area'] as String,
      //immagine: json['immagine'] as String,
      //descrizione: json['descrizione'] as String,
    );
  }
}

class PadiglioniRegistrazione extends StatefulWidget {
  const PadiglioniRegistrazione({Key? key}) : super(key: key);

  @override
  _PadiglioniRegistrazioneState createState() => _PadiglioniRegistrazioneState();
}

class _PadiglioniRegistrazioneState extends State<PadiglioniRegistrazione> {
  bool value = false;


  @override
  Widget build(BuildContext context) =>
      Scaffold(
          body: Column(
              children: <Widget>[

                Container(
                  padding: const EdgeInsets.only(
                      top: 80.00, right: 10.00, left: 10.00),
                  child: const Text(
                    'Qui puoi trovare i padiglioni selezionati in base ai temi scelti da te. Puoi selezionare anche altri stand da visitare cliccando sulla spunta in alto a destra. Clicca Avanti per completare l\'operazione. Potrai sempre cambiare le tue scelte nella sezione Preferiti\n',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: Color(0xde000000),
                      letterSpacing: 0.144,
                      height: 1.5,
                    ),
                    textHeightBehavior: TextHeightBehavior(
                        applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child:
                  Container(
                    padding: const EdgeInsets.only(top: 10.00, bottom: 40.00),
                    child:
                    FutureBuilder<List<Photo>>(
                      future: fetchPhotos(http.Client()),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('An error has occurred!'),
                          );
                        } else if (snapshot.hasData) {
                          return Photolist2(photos: snapshot.data!);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 30.00),
                  child:
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (contex) => const Switchh()));
                    },
                    child: const Text('AVANTI'),
                  ),
                )
              ]
          )
      );
}


class Photolist2 extends StatelessWidget {
  Photolist2({Key? key, required this.photos}) : super(key: key);
  bool isChecked = false;
  final List<Photo> photos;


  @override
  Widget build(BuildContext context) {
    return Container( child:
        GridView.count(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        primary: false,
            children:
      List.generate(27, (index)
    {
      return
      Card(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack( children: [
                Container(padding : const EdgeInsets.only(bottom: 5.00),
            child:
            Image.asset('assets/images/padglione.jpg',width: 1000 ,height: 120),
                ),
                  Container(
                    alignment: Alignment.topRight,
                      child: const Box()),
            ]
                ),
            ListTile(
              //leading: const Box(),
              title: Text(photos[index].nome, overflow: TextOverflow.ellipsis,maxLines: 2),
              )
          ]
          )
      );
    }
          )
        )
    );
  }
}

class Box extends StatefulWidget {
  const Box({Key? key}) : super(key: key);

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: const CircleBorder(),
      activeColor: Colors.black,
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
