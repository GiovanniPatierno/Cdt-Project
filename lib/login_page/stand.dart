import 'dart:convert';
import 'dart:async';
import 'package:cdt/login_page/post_stand.dart';
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
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as Bottom;



class Stand extends StatefulWidget {
  const Stand({Key? key}) : super(key: key);

  @override
  _StandState createState() => _StandState();
}

class _StandState extends State<Stand> {
  List list = [];
  @override
  Widget build(BuildContext context) {


    Future.delayed(Duration.zero, () =>
    Bottom.showMaterialModalBottomSheet(context: context, builder: (builder){
      return Container(
        padding: EdgeInsets.all(20),
        height: 200,
          color: Colors.white,
          child:const Text('Per completare la registrazione inserisci i padiglioni che desideri visitare \n ',style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center)

      );
    }));
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid)
        .get()
        .then((value) {
      list = value.data()!['padiglioni'] as List;
    });
    return  Scaffold(
      body:Column(children: <Widget>[
        Container(
            margin: const EdgeInsets.only(right: 260, top : 40),
            child:
            const Text('Padiglioni:', style: TextStyle(color: Colors.black, fontSize: 20) , textAlign: TextAlign.left, )),
      Expanded(child:
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
      )),
      ]
      )
    );
  }
}

//class Photolist2 extends StatelessWidget {
 // Photolist2({Key? key, required this.photos}) : super(key: key);
  //final List<Photo> photos;

class Photolist2 extends StatefulWidget {
  const Photolist2({Key? key, required this.photos}) : super(key: key);
  final List<Photo> photos;

  @override
  _Photolist2State createState() => _Photolist2State();
}

class _Photolist2State extends State<Photolist2> {

  Map map1 = {
    'Be Wine': Colors.pink,
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


  @override
  Widget build(BuildContext context) {
    //print( map['Be Wine']);
    int? _value = 1;
    return Scaffold(
        body:
        Column(children:
        <Widget>[
          Expanded(child:
          ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.photos.length,
              itemBuilder: (context, index) {
                if (map1.containsKey(widget.photos[index].stand)) {
                  widget.photos[index].color =
                  map1[ widget.photos[index].stand];
                }

                return Column(

                    children: <Widget>[
                      Card(margin: const EdgeInsets.only(top: 25),

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
                                            widget.photos[index].nome,
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

                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 16, top: 13, right: 24),
                                        child:
                                        DropdownButtonHideUnderline(child:
                                            DropdownButton(
                                              elevation: 8,
                                              autofocus: true,
                                              isExpanded: true,
                                            icon: Icon(Icons.info_outline),
                                            value: _value,
                                            items: [
                                              const DropdownMenuItem(
                                                child: Text("Info"),
                                                value: 1,
                                              ),
                                              DropdownMenuItem(
                                                child: Container(padding:EdgeInsets.all(20),
                                              child:Text(widget.photos[index]
                                                    .descrizione!, textAlign: TextAlign.start,)),
                                                value: 2,
                                              ),

                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                _value = value as int?;
                                              });
                                            },hint:Text("info"),

                                      ))),
                                      Container(
                                          padding: const EdgeInsets.only(top:10,
                                              left: 150),
                                          child: Button1(
                                            photos: widget.photos,
                                            index: index,)
                                      ),
                                Container(margin: const EdgeInsets.only(
                                    left: 15.00, top: 40, bottom: 7),
                                    child:
                                    Text(
                                      widget.photos[index].stand,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        color: widget.photos[index].color,
                                        //Colors.black38,
                                        letterSpacing: 0.098,
                                        fontWeight: FontWeight.w500,
                                        height: 1.7142857142857142,
                                      ),
                                      textHeightBehavior: const TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      textAlign: TextAlign.left,
                                    )),
                                Container(height: 5, color: widget.photos[index]
                                    .color,)
                              ]
                          )
                      ),
                    ]);
              }
          )),

          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 45),
            child:
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => const PostStand()));
                _showToast(context);
              },
              child: const Text('Continua'),
            ),
          ),
        ])

    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Mappa creata con successo!'),
        //action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
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
          color:  widget.photos[widget.index].check? Colors.white : Colors.black)),
      style: OutlinedButton.styleFrom(
        //primary: Colors.white,
        backgroundColor: widget.photos[widget.index].check? Colors.black :  Colors.white,
        //onSurface: Colors.orangeAccent,
        side: BorderSide(
            color:  widget.photos[widget.index].check? Colors.white : Colors.black, width: 1),
        //elevation: 20,
        //minimumSize: Size(100, 50),
        //shadowColor: Colors.deepOrange,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                5)),
      ),
      onPressed: () {
        setState(() =>
        widget.photos[widget.index].check = !widget.photos[widget.index].check
        );
        if ( widget.photos[widget.index].check == true) {
          postDetailToFirestore1();

        } else {

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


}
