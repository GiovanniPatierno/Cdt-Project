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
import 'dettagli1.dart';



class Stand2 extends StatefulWidget {
  const Stand2({Key? key}) : super(key: key);

  @override
  _StandState createState() => _StandState();
}

class _StandState extends State<Stand2> {
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

  Map map1 ={'BE WINE' : Colors.pink, 'SALONE DELL INNOVAZIONE':Colors.black87,'ENTI E ISTITUZIONI':Colors.cyan,'AUTOMOTIVE':Colors.teal,'ARTICOLI DA REGALO':Colors.deepPurple,'ARTICOLI PER LA CASA': Colors.brown,'SICILIA':Colors.purple,'CENTRO CONGRESSI DEL LEVANTE':Colors.green, 'EDILIZIA ABITATIVA':Colors.lightGreen,'ARTIGIANATO ESTERO': Colors.deepOrangeAccent,'ARTIGIANATO ESTERO': Colors.deepOrangeAccent,'SALONE DELL ARREDAMENTO':Colors.blue,'ARREDO PER ESTERNI':Colors.orangeAccent,'AGROALIMENTARE':Colors.lime,'CENTRO SERVIZIO VOLONTARIATO':Colors.blueGrey,'BENESSERE E RELAX': Colors.purpleAccent,'AREA BIMBI':Colors.limeAccent,'MEDITERRANEAN BEAUTY BARI':Colors.yellow};


  @override
  Widget build(BuildContext context) {
    //String color;
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
        appBar: AppBar(
      automaticallyImplyLeading: false,
      title:const Center( child: Text('Personalizza')),
      backgroundColor: Colors.black,
    ),
        body:
        Column(children: <Widget>[
          Expanded(child:
          ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: photos.length,
              itemBuilder: (context, index) {

                if (map1.containsKey(photos[index].stand)){
                  photos[index].color = map1[photos[index].stand];
                }

                return Column(
                    children: <Widget>[
                      Card(margin: const EdgeInsets.only(top: 15),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      Dettagli1(index: index, data: photos)),
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
                                          ),

                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 230),
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
                                        )),
                                    Container(height: 5,color: photos[index].color,)
                                  ]
                              )
                          )),
                    ]);
              }
          )),

         Container(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child:
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) =>  Switchh(index2: 2)));
                _showToast(context);
              },
              child: const Text('Conferma le mie modifiche'),
            ),
          )
        ])

    );
  }
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Mappa aggiornata!'),
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
