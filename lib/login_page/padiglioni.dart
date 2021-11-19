import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../switchh.dart';

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://192.168.1.241:9250/api/padiglioni'));
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
  final String area;
  bool check = false;


   Photo( {
    required this.area,
    required this.id,
    required this.nome,
    required this.check

  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      nome: json['nome'] as String,
      area: json['area'] as String,
      check: false,
    );
  }
}

Future<List<Interessi>> fetchPreferiti(http.Client client) async {
  //Comunicazione con firebase
  final _auth1 = FirebaseAuth.instance;
  User? user = _auth1.currentUser;
  DocumentSnapshot variable = await FirebaseFirestore.instance.collection('uid').doc(user!.uid).get();
  //print(variable['interessi']);
  String totale ='';
  List<dynamic> interesse =  variable['interessi'];
   for(int i=0; i<interesse.length; i++){
     totale = totale+","+variable['interessi'][i];
   }


  //parte che comunica con api
   String Url = 'http://192.168.1.241:9250/api/padiglioni?interessi=';
  final response1 = await client
      .get(Uri.parse(Url + totale));
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePreferiti, response1.body);
}




// A function that converts a response body into a List<Interessi>.
List<Interessi> parsePreferiti(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Interessi>((json) => Interessi.fromJson(json)).toList();
}

class Interessi {
  final String id;
  final String nome;
  final String area;

  const Interessi( {
    required this.area,
    required this.id,
    required this.nome,


  });

  factory Interessi.fromJson(Map<String, dynamic> json) {
    return Interessi(
      id: json['id'] as String,
      nome: json['nome'] as String,
      area: json['area'] as String,
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
  bool check = false;

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
                          return Photolist2(photos: snapshot.data!, check: check);
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
  Photolist2({Key? key, required this.photos, required this.check}) : super(key: key);
  final List<Photo> photos;
  bool check = false;



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Interessi>>(
      future: fetchPreferiti(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
             return PreferList(interessi: snapshot.data!, photos:photos, check: check);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

  }
}

class PreferList extends StatelessWidget {
  PreferList({Key? key,  required this.interessi, required this.photos, required this.check}) : super(key: key);
  final List<Interessi> interessi;
  final List<Photo> photos;
  bool check = false;


  @override
  Widget build(BuildContext context) {
    return Container(child:
    GridView.count(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        primary: false,
        children:
        List.generate(27, (index) {
          return
            Card(
                child:
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Container(padding: const EdgeInsets.only(bottom: 5.00),
                          child:
                          Image.asset(
                              'assets/images/padglione.jpg', width: 1000,
                              height: 120),
                        ),
                        Container(
                            alignment: Alignment.topRight,
                            child: Box(interessi: interessi,
                                photos: photos,
                                index: index,
                                check: Control(index, check)
                            ))
                      ]
                      ),
                      ListTile(
                        //leading: const Box(),
                        title: Text(
                            photos[index].nome, overflow: TextOverflow.ellipsis,
                            maxLines: 2),
                      )
                    ]
                )
            );
        }
        )
    )
    );
  }
  bool Control(int index, bool value) {
    for (int j = 0; j < interessi.length; j++) {
      if (photos[index].nome == interessi[j].nome) {
        photos[index].check = true;
      }
      value = photos[index].check;
    }
    return value;
  }
}


class Box extends StatefulWidget {
  Box({Key? key,required this.interessi, required this.photos, required this.index, required this.check}) : super(key: key);
  final List<Photo> photos;
  final List<Interessi> interessi;
  final int index;
  bool check = false;

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: const CircleBorder(),
      activeColor: Colors.black,
      value: widget.check ,
      onChanged: (bool? value) {
        setState(()  {
          widget.check = value!;
          /*if(value1 == true)
        {
          isChecked != value!;
        }else{
            isChecked = value!;
          }*/
        });
      },
    );
  }




}

