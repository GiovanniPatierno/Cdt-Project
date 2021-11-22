import 'dart:convert';
import 'dart:async';
import 'package:cdt/login_page/padiglioni.dart';
import 'package:cdt/switchh.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
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
  final String id;
  final String name;
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

class PreferitiRegistrazione extends StatefulWidget {
  const PreferitiRegistrazione({Key? key}) : super(key: key);

  @override
  _PreferitiRegistrazioneState createState() => _PreferitiRegistrazioneState();
}

class _PreferitiRegistrazioneState extends State<PreferitiRegistrazione> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return MaterialApp(
        home: Scaffold(
            body: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(right: 330.00),
                    child:
                    Image.asset("assets/images/main_top.png",
                      width: size.width * 0.3,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 30.00),
                    child:
                    const Text(
                      'BENVENUTO!',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 33,
                        color: Color(0xde000000),
                        height: 1.1818181818181819,
                      ),
                      textHeightBehavior: TextHeightBehavior(
                          applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(30.00),
                    child: const Text(
                      'In questa schermata vengono proposti dei temi di interesse. Seleziona i temi che più ti interessano per scoprire quali padiglioni potrebbero interessarti.\n',
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
                      padding: const EdgeInsets.only(bottom: 40.00),
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
                  Container(
                    padding: const EdgeInsets.only(bottom: 20.00),
                    child:
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (
                            contex) => const PadiglioniRegistrazione()));
                      },
                      child: const Text('Avanti'),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(bottom: 60.00),
                      child:
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const Switchh()));
                          },
                          child:
                          const Text(
                            'Salta questo passaggio',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 15,
                              color: Color(0xde000000),
                              letterSpacing: 0.495,
                              height: 1.3333333333333333,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          )
                      )
                  )
                ]
            )
        )
    );
  }


}

class PhotosList extends StatelessWidget {
  PhotosList({Key? key, required this.photos}) : super(key: key);
  bool check = false;
  final List<Photo> photos;


  @override
  Widget build(BuildContext context) {
    ControlPhoto();
   return  ListView.builder(
     padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: photos.length,
      itemBuilder: (context, index) {
        check = photos[index].check;
        return ListTile(
          title: Text(photos[index].name),
          leading: const Icon(Icons.circle),
          trailing: Box(photos: photos, index: index, check: photos[index].check)
        );
      },
    );
  }

  ControlPhoto() async {
    final _auth1 = FirebaseAuth.instance;
    User? user = _auth1.currentUser;
    DocumentSnapshot variable = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    List<dynamic> interesse = variable['interessi'];
    print(variable['interessi']);
    for (int j = 0; j < photos.length; j++) {
      for (int i = 0; i < interesse.length; i++) {
        if (photos[j].name == variable['interessi'][i]) {
          photos[j].check = true;
        }
      }
    }
  }
}


class Box extends StatefulWidget {
   Box({Key? key, required this.photos, required this.index, required this.check}) : super(key: key);
  final List<Photo> photos;
  final int index;
   bool check;

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  bool isChecked = false;
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




