import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//interessi
Future<List<Photo>> fetchPhotos(http.Client client) async {
  //comunicazione con api
  final response = await client
      .get(Uri.parse('http://192.168.1.241:9250/api/interessi'));
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
    String id;
    String name;
    bool check = false;

    Photo({
    required this.id,
    required this.name,
    required this.check
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      name: json['name'] as String,
      check : false
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
//padiglioni
Future<List<Photo1>> fetchPhotos1(http.Client client1) async {
  final response1 = await client1
      .get(Uri.parse('http://192.168.1.241:9250/api/padiglioni'));
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
  final String area;
  bool check = false;

   Photo1( {
    required this.area,
    required this.id,
    required this.nome,
    required this.check
  });

  factory Photo1.fromJson(Map<String, dynamic> json) {
    return Photo1(
      id: json['id'] as String,
      nome: json['nome'] as String,
      area: json['area'] as String,
      check: false
    );
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//parte degli interessi
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
                    ControlPhoto1(snapshot);
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
                    ControlPhoto(snapshot);
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
  ControlPhoto(AsyncSnapshot<List<Photo1>> snapshot) async {
    final _auth1 = FirebaseAuth.instance;
    User? user = _auth1.currentUser;
    DocumentSnapshot variable = await FirebaseFirestore.instance.collection(
        'users').doc(user!.uid).get();

    List<dynamic> interesse = variable['padiglioni'];
    for (int j = 0; j < snapshot.data!.length; j++) {
      for (int i = 0; i < interesse.length; i++) {
        if (snapshot.data![j].nome == variable['padiglioni'][i]) {
          snapshot.data![j].check = true;
        }
      }
    }
  }

  ControlPhoto1(AsyncSnapshot<List<Photo>> snapshot) async {
    final _auth1 = FirebaseAuth.instance;
    User? user = _auth1.currentUser;
    DocumentSnapshot variable = await FirebaseFirestore.instance.collection(
        'users').doc(user!.uid).get();

    List<dynamic> interesse = variable['interessi'];
    for (int j = 0; j < snapshot.data!.length; j++) {
      for (int i = 0; i < interesse.length; i++) {
        if (snapshot.data![j].name == variable['interessi'][i]) {
          snapshot.data![j].check = true;
        }
      }
    }
  }
}

class PhotosList extends StatelessWidget {
  PhotosList({Key? key, required this.photos}) : super(key: key);
  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
   // ControlPhoto();
    return ListView.builder(
      //padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(photos[index].name),
            leading: const Icon(Icons.circle),
            trailing: Box1(photos: photos,
                index: index,
                check: photos[index].check
            )//getFetailfromFirestore(index, check)
        );
      },
    );
  }
}

class Box1 extends StatefulWidget {
  Box1({Key? key, required this.photos, required this.index, required this.check}) : super(key: key);
  final List<Photo> photos;
  final int index;
  bool check;

  @override
  _BoxState1 createState() => _BoxState1();
}

class _BoxState1 extends State<Box1> {
  DatabaseReference dbRef1 = FirebaseDatabase.instance.reference().child("users");
  final _auth1 = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.black,
      value: widget.check,
      onChanged: (bool? value) {
        setState(() {
          widget.check = value!;
          if (widget.check == true) {
            postDetailToFirestore2();
          }else{
            removeDetailtofirestore3();
          }
        });
      },
    );
  }

  postDetailToFirestore2() async {
    FirebaseFirestore firebaseFirestore1 = FirebaseFirestore.instance;
    User? user = _auth1.currentUser;

    await firebaseFirestore1
        .collection("users")
        .doc(user!.uid)
        .update({
      'interessi': FieldValue.arrayUnion([widget.photos[widget.index].name])
    });

  }
  removeDetailtofirestore3() async {
    FirebaseFirestore firebaseFirestore1 = FirebaseFirestore.instance;
    User? user = _auth1.currentUser;

    await firebaseFirestore1
        .collection("users")
        .doc(user!.uid)
        .update({
      'interessi': FieldValue.arrayRemove([widget.photos[widget.index].name])
    });

  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//parte dei padiglioni
class Photolist2 extends StatelessWidget {
  Photolist2({Key? key, required this.photos1}) : super(key: key);
  final List<Photo1> photos1;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: photos1.length,
        itemBuilder: (context, index) {
          return Card(
                child:
                 Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                          Stack(children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child:
                              Image.asset(
                                  'assets/images/padiglione-francia-expo.jpg'),
                            ),
                            Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.topRight,
                                child: Box(photos1: photos1,
                                    index: index,
                                    check: photos1[index].check)),
                          ]
                          ),
                      ListTile(
                        title: Text(photos1[index].nome, overflow: TextOverflow.ellipsis, maxLines: 1),
                      )
                    ]
                )
            );
        }
    );
  }

}

class Box extends StatefulWidget {
  Box({Key? key, required this.photos1, required this.index, required this.check}) : super(key: key);
  final List<Photo1> photos1;
  final int index;
  bool check;

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  DatabaseReference dbRef1 = FirebaseDatabase.instance.reference().child("users");
  final _auth1 = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: const CircleBorder(),
      activeColor: Colors.black,
      value: widget.check,
      onChanged: (bool? value) {
        setState(()  {
          widget.check = value!;
          if(widget.check == true) {
            postDetailToFirestore1();
          }else{
            removeDetailtofirestore();
          }
        });
      },
    );
  }

  postDetailToFirestore1() async {
    FirebaseFirestore firebaseFirestore1 = FirebaseFirestore.instance;
    User? user = _auth1.currentUser;

    await firebaseFirestore1
        .collection("users")
        .doc(user!.uid)
        .update({
      'padiglioni': FieldValue.arrayUnion([widget.photos1[widget.index].nome])
    });

  }
  removeDetailtofirestore() async {
    FirebaseFirestore firebaseFirestore1 = FirebaseFirestore.instance;
    User? user = _auth1.currentUser;

    await firebaseFirestore1
        .collection("users")
        .doc(user!.uid)
        .update({
      'padiglioni': FieldValue.arrayRemove([widget.photos1[widget.index].nome])
    });

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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////