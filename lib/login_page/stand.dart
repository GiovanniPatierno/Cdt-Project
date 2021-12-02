import 'dart:convert';
import 'dart:async';
import 'package:cdt/padiglioni_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../dettagli_padiglione.dart';
import '../switchh.dart';



class Stand extends StatefulWidget {
  const Stand({Key? key}) : super(key: key);

  @override
  _StandState createState() => _StandState();
}

class _StandState extends State<Stand> {
  List list = [];
  @override
  Widget build(BuildContext context) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid)
        .get()
        .then((value) {
      list = value.data()!['padiglioni'] as List;
    });
    return  Scaffold(
      body:
      FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return  Center(
              child: Text(snapshot.error.toString()),
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
    );
  }
}

class Photolist2 extends StatelessWidget {
  Photolist2({Key? key, required this.photos}) : super(key: key);
  final List<Photo> photos;


  @override
  Widget build(BuildContext context) {
    //String color;
    return Scaffold(
        body:
        Column(children: <Widget>[
          Expanded(child:
          ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: photos.length,
              itemBuilder: (context, index) {
                if (photos[index].stand == 'BE WINE') {
                  photos[index].color = Colors.pink;
                }
                if (photos[index].stand == 'SALONE DELL INNOVAZIONE') {
                  photos[index].color = Colors.black87;
                }
                if (photos[index].stand == 'ENTI E ISTITUZIONI') {
                  photos[index].color = Colors.cyan;
                }
                if (photos[index].stand == 'AUTOMOTIVE') {
                  photos[index].color = Colors.teal;
                }
                if (photos[index].stand == 'ARTICOLI DA REGALO') {
                  photos[index].color = Colors.deepPurple;
                }
                if (photos[index].stand == 'ARTICOLI PER LA CASA') {
                  photos[index].color = Colors.brown;
                }
                if (photos[index].stand == 'SICILIA') {
                  photos[index].color = Colors.purple;
                }
                if (photos[index].stand == 'CENTRO CONGRESSI DEL LEVANTE') {
                  photos[index].color = Colors.green;
                }
                if (photos[index].stand == 'EDILIZIA ABITATIVA') {
                  photos[index].color = Colors.lightGreen;
                }
                if (photos[index].stand == 'ARTIGIANATO ESTERO') {
                  photos[index].color = Colors.deepOrangeAccent;
                }
                if (photos[index].stand == 'SALONE DELL ARREDAMENTO') {
                  photos[index].color = Colors.blue;
                }
                if (photos[index].stand == 'ARREDO PER ESTERNI') {
                  photos[index].color = Colors.orangeAccent;
                }
                if (photos[index].stand == 'AGROALIMENTARE') {
                  photos[index].color = Colors.lime;
                }
                if (photos[index].stand == 'CENTRO SERVIZIO VOLONTARIATO') {
                  photos[index].color = Colors.blueGrey;
                }
                if (photos[index].stand == 'BENESSERE E RELAX') {
                  photos[index].color = Colors.purpleAccent;
                }
                if (photos[index].stand == 'AREA BIMBI') {
                  photos[index].color = Colors.limeAccent;
                }
                if (photos[index].stand == 'MEDITERRANEAN BEAUTY BARI') {
                  photos[index].color = Colors.yellow;
                }

                // print(photos[index].color);
                //photos[index].color = Colors.primaries random List<blue,green>;
                //print(color);
                return Column(
                    children: <Widget>[
                      Card(margin: const EdgeInsets.only(top: 15),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      Dettagli(index: index, data: photos)),
                                );
                              },
                              child:
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 10),
                                        child:
                                        Text(
                                          photos[index].nome,
                                          //textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 20,
                                            color: Color(0xde000000),
                                            letterSpacing: 0.15000000953674317,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2,
                                          ),
                                        )),
                                    Row(
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 15, top: 10),
                                              child:
                                              const Text(
                                                'descrizione',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 16,
                                                  color: Color(0xde000000),
                                                  letterSpacing: 0.496,
                                                  height: 1.5,
                                                ),
                                              )),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 160),
                                              child: Button1(
                                                photos: photos, index: index,)
                                          )
                                        ]),
                                    Container(margin: const EdgeInsets.only(
                                        left: 15.00, top: 40, bottom: 7),
                                        child:
                                        Text(
                                          photos[index].stand,
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                            color: photos[index].color,
                                            //Colors.black38,
                                            letterSpacing: 0.098,
                                            fontWeight: FontWeight.w500,
                                            height: 1.7142857142857142,
                                          ),
                                          textHeightBehavior: const TextHeightBehavior(
                                              applyHeightToFirstAscent: false),
                                          textAlign: TextAlign.left,
                                        ))
                                  ]
                              )
                          )),
                    ]);
              }
          )),

          Container(
            padding: const EdgeInsets.all(10),
            child:
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => const Switchh()));
              },
              child: const Text('Aggiorna'),
            ),
          )
        ])

    );
  }
}

class Button1 extends StatefulWidget {
  Button1({Key? key, required this.photos, required this.index}) : super(key: key);
  List<Photo> photos;
  int index;


  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button1> {
  DatabaseReference dbRef1 = FirebaseDatabase.instance.reference().child(
      "users");
  final _auth1 = FirebaseAuth.instance;
  bool isButtonPressed = false;


  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(
          widget.photos[widget.index].check? 'Rimuovi' : "Aggiungi", style: TextStyle(
          color:  widget.photos[widget.index].check? widget.photos[widget.index].color : Colors.black38)),
      style: OutlinedButton.styleFrom(
        //primary: Colors.white,
        //backgroundColor: Colors.blueG,
        //onSurface: Colors.orangeAccent,
        side: BorderSide(
            color:  widget.photos[widget.index].check? widget.photos[widget.index].color : Colors.black38, width: 1),
        //elevation: 20,
        //minimumSize: Size(100, 50),
        //shadowColor: Colors.deepOrange,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                30)),
      ),
      onPressed: () {
        setState(() =>
        widget.photos[widget.index].check = !widget.photos[widget.index].check
        );
        if ( widget.photos[widget.index].check == true) {
          postDetailToFirestore1();
          _showToast(context);
        } else {
          _showToast1(context);
          removeDetailtofirestore();
        }
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
      'padiglioni': FieldValue.arrayUnion([widget.photos[widget.index].nome])
    });
  }

  removeDetailtofirestore() async {
    FirebaseFirestore firebaseFirestore1 = FirebaseFirestore.instance;
    User? user = _auth1.currentUser;

    await firebaseFirestore1
        .collection("users")
        .doc(user!.uid)
        .update({
      'padiglioni': FieldValue.arrayRemove([widget.photos[widget.index].nome])
    });
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Padiglione aggiunto ai preferiti'),
        //action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _showToast1(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Padiglione rimosso dai preferiti'),
        //action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }



}
