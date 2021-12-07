import 'package:cdt/padiglioni_page.dart' as pad;
import 'package:cdt/switchh.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class Dettagli2 extends StatelessWidget {
  Dettagli2({Key? key, required this.index, required this.data})
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
                margin: const EdgeInsets.only(top: 50, right: 320),
                child:
                GestureDetector(
                  child: const Icon(Icons.arrow_back,color: Colors.black,size: 30),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  Switchh(index2: 1)),
                    );
                  },
                )),
            Container(

                margin: const EdgeInsets.only(top: 30 , right: 20, left: 20),
                child:
                Text(data[index].nome, style: const TextStyle(fontSize: 25),)),

            Container(
                margin: const EdgeInsets.only(top: 150, right: 20, left: 20),
                child:
                 Text(data[index].descrizione!,)
            ),
            const SizedBox(height: 150),
            Button1(photos: data, index: index)
          ]
      ),
    );
  }
}

class Button1 extends StatefulWidget {
  Button1({Key? key, required this.photos, required this.index}) : super(key: key);
  List<pad.Photo> photos;
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
