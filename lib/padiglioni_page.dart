import 'dart:convert';
import 'dart:async';
import 'package:cdt/dettagli_padiglione.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dettagli2.dart';

class Padiglioni11 extends StatefulWidget {
  const Padiglioni11({Key? key}) : super(key: key);

  @override
  _PadiglioniState createState() => _PadiglioniState();
}

class _PadiglioniState extends State<Padiglioni11> {
  TextEditingController searchController = TextEditingController();
  List list = [];


  @override
  Widget build(BuildContext context) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid)
        .get()
        .then((value) {
      list = value.data()!['padiglioni'] as List;
    });
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Center( child: Text('Padiglioni')),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[

          Expanded(
            child:
              FutureBuilder<List<Photo>>(
                future: fetchPhotos(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred!'),
                    );
                  } else if (snapshot.hasData) {
                    for (int j = 0; j < snapshot.data!.length; j++) {
                      for (int i = 0; i < list.length; i++) {
                        if (snapshot.data![j].nome == list[i]) {
                          snapshot.data![j].check = true;
                        }
                      }
                    }
                    return Photolist2(photos: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

        ],
      )

    );
  }
}

class Photolist2 extends StatelessWidget {
  Photolist2({Key? key, required this.photos}) : super(key: key);
  bool isChecked = false;
  final List<Photo> photos;

  Map map1 = {
    'BE WINE': Colors.pink,
    'SALONE DELL INNOVAZIONE': Colors.black87,
    'ENTI E ISTITUZIONI': Colors.cyan,
    'AUTOMOTIVE': Colors.teal,
    'ARTICOLI DA REGALO': Colors.deepPurple,
    'ARTICOLI PER LA CASA': Colors.brown,
    'SICILIA': Colors.purple,
    'CENTRO CONGRESSI DEL LEVANTE': Colors.green,
    'EDILIZIA ABITATIVA': Colors.lightGreen,
    'ARTIGIANATO ESTERO': Colors.deepOrangeAccent,
    'ARTIGIANATO ESTERO': Colors.deepOrangeAccent,
    'SALONE DELL ARREDAMENTO': Colors.blue,
    'ARREDO PER ESTERNI': Colors.orangeAccent,
    'AGROALIMENTARE': Colors.lime,
    'CENTRO SERVIZIO VOLONTARIATO': Colors.blueGrey,
    'BENESSERE E RELAX': Colors.purpleAccent,
    'AREA BIMBI': Colors.limeAccent,
    'MEDITERRANEAN BEAUTY BARI': Colors.yellow
  };

  Colorrr(i){
      if (map1.containsKey(photos[i].stand)) {
       photos[i].color = map1[photos[i].stand];
      }

    return  photos[i].color;
  }



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 8.00, left: 10.00, right: 10.00),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.all(8.00),
              child:
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          Dettagli2(index: index, data: photos)),
                    );
                  },
                  child:
                  Card(
                      child:
                      Column(
                          children: <Widget>[
                            Container(
                                height: 20,
                                //width: 400,
                                color: Colorrr(index)
                            ),
                            //Expanded(child:
                           // Row(
                             // mainAxisAlignment: MainAxisAlignment.start,
                               // children:[
                                ListTile(
                                  title: Text(photos[index].nome,

                                )),
                                 Text(photos[index].stand, style: TextStyle(color: Colorrr(index),), textAlign: TextAlign.start,),
                            SizedBox(height: 10)
                                 // const Icon(Icons.arrow_drop_down )
                            //   // ]
                            //)),
                          ]
                      )
                  )
              )
          );
        }

    );
  }
}


Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://192.168.1.241:9250/api/padiglioni'));
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, utf8.decode(response.bodyBytes));
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String id;
  final String nome;
  bool check = false;
  String? descrizione;
  final String stand;
  Color color = Colors.black38;



   Photo( {

    required this.stand,
    required this.id,
    required this.nome,
    required this.check,
     required this.color,
     required this.descrizione
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      nome: json['nome'] as String,
      stand: json['stand'] as String,
      descrizione: json['descrizione'] as String,
      check: false,
        color : Colors.black38
    );
  }

}
