import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:cdt/login_page/padiglioni.dart';
import 'package:cdt/switchh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://192.168.1.241:9250/api/interessi'));
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
  final String name;

  const Photo({
    required this.id,
    required this.name,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}

Future<List<Photo1>> fetchPhotos1(http.Client client1) async {
  final response1 = await client1
      .get(Uri.parse('http://192.168.1.241:9250/api/padiglioni'));
  print(response1.body);
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos1, response1.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo1> parsePhotos1(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo1>((json) => Photo1.fromJson(json)).toList();
}

class Photo1 {
  final String id;
  final String nome;
  //final String descrizione;
  final String area;
  //final String immagine;

  const Photo1( {
    //required this.immagine,
    //required this.descrizione,
    required this.area,
    required this.id,
    required this.nome,
  });

  factory Photo1.fromJson(Map<String, dynamic> json) {
    return Photo1(
      id: json['id'] as String,
      nome: json['nome'] as String,
      area: json['area'] as String,
      //immagine: json['immagine'] as String,
      //descrizione: json['descrizione'] as String,
    );
  }
}

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
      body:Container( padding: EdgeInsets.all(20),
          child: Column(
        children: <Widget>[
          const Temi(),
          Expanded(
            child:
            Container(
              padding: const EdgeInsets.all(5),
              child:
              FutureBuilder<List<Photo>>(
                future: fetchPhotos(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred!'),
                    );
                  } else if (snapshot.hasData) {
                    return PhotosList(photos: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          const Pad(),
          Expanded(
            child:
            Container(
              padding: const EdgeInsets.all(5),
              child:
              FutureBuilder<List<Photo1>>(
                future: fetchPhotos1(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred!'),
                    );
                  } else if (snapshot.hasData) {
                    return Photolist2(photos1: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      )
      )
    );
  }
}

class PhotosList extends StatelessWidget {
  PhotosList({Key? key, required this.photos}) : super(key: key);
  bool isChecked = false;
  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {

    return  ListView.builder(
      //padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(photos[index].name),
            leading: const Icon(Icons.circle),
            trailing: const Box1()
        );
      },
    );
  }
}

class Box1 extends StatefulWidget {
  const Box1({Key? key}) : super(key: key);

  @override
  _BoxState1 createState() => _BoxState1();
}

class _BoxState1 extends State<Box1> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
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

class Photolist2 extends StatelessWidget {
  Photolist2({Key? key, required this.photos1}) : super(key: key);
  bool isChecked = false;
  final List<Photo1> photos1;


  @override
  Widget build(BuildContext context) {
    return Container( child:
    GridView.count(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
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
                    children:<Widget> [
                      Expanded(
                        child:
                      Stack( children: [
                        Container(//padding : const EdgeInsets.only(bottom: 5.00),
                          child:
                          Image.asset('assets/images/padiglione-francia-expo.jpg'),
                        ),
                        Container(
                            alignment: Alignment.topRight,
                            child: const Box()),
                      ]
                      )
                      ),
                      ListTile(
                        //leading: const Box(),
                        title: Text(photos1[index].nome, overflow: TextOverflow.ellipsis,maxLines: 1),
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

class Temi extends StatelessWidget {
  const Temi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top:0.00),
        //padding: const EdgeInsets.all(30.00),
        child:
        Row(
            children:<Widget>[
              buildDivider(),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child:
               Text(
                'Seleziona i temi di interesse',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: Color(0xde000000),
                  letterSpacing: 0.252,
                  height: 1.4285714285714286,
                ),
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.left,
              )),
              buildDivider()
            ]
        )
    );
  }
  buildDivider(){
    return const Expanded(child: Divider(
      color: Colors.black,
      height: 1,
    ));
  }
}

class Pad extends StatelessWidget {
  const Pad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top:0.00),
        //padding: const EdgeInsets.all(30.00),
        child:
        Row(
            children:<Widget>[
              buildDivider(),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child:
              Text(
                'Seleziona i padiglioni da visitare',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: Color(0xde000000),
                  letterSpacing: 0.252,
                  height: 1.4285714285714286,
                ),
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.left,
              )),
              buildDivider()
            ]
        )
    );
  }

  buildDivider(){
    return const Expanded(child: Divider(
      color: Colors.black,
      height: 1,
    ));
  }
}