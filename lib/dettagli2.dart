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

  Map map2 = {0: 10, 1:24, 2:9, 3:5, 4:19, 5:29, 6:18, 7:10, 8:23, 9:30, 10:20, 11:2, 12: 26, 13:21, 14:14, 15:1, 16:25, 17:22, 18:17, 19:2, 20:10, 21: 2, 22: 16, 23:19, 24:7, 25: 13, 26:9 };
  String Rischio(map, int Max, int i){
    String rischio = '';
    if(Max - map[i] < 7 ){
      rischio = 'Alto';
    }
    if( 14 >= Max - map[i] && Max - map[i] >= 7){
      rischio = 'Medio';
    }if(Max - map[i] > 14){
      rischio = 'Basso';
    }
    return rischio;
  }

  Color ColorRischio(map, int Max, int i){
    Color rischio = Colors.black;
    if(Max - map[i] < 7 ){
      rischio = Colors.red;
    }
    if( 14 >= Max - map[i] && Max - map[i] >= 7){
      rischio = Colors.amber;
    }if(Max - map[i] > 14){
      rischio = Colors.green;
    }
    return rischio;
  }
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
            Center(child: Container(

                margin: const EdgeInsets.only(top: 30),
                child:
                Text(data[index].nome, style: const TextStyle(fontSize: 25),))),
            const SizedBox(height: 50),
            Center(child:
            Row(children:  [
              Container(
                  margin: EdgeInsets.only(left: 140),
                  child:
                  const Text("Rischio: ",style: TextStyle(fontSize: 20))
              ),
              Text(Rischio(map2,30,index),
                style: TextStyle(fontSize: 20,
                    color: ColorRischio(map2,30, index)
                ),
              ),
            ])),

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
