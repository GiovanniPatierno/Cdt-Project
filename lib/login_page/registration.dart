import 'package:cdt/login_page/preferiti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../switchh.dart';



class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationCreateState createState() =>  _RegistrationCreateState();
}

class  _RegistrationCreateState extends State<Registration> {
  late String _nome,_cog, _password1, _email1;

  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");
  final GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();
  //final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body:  SingleChildScrollView(
            child:
            Form(
              key : _formkey1,
              child:
              Column(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.all(5.00),
                        margin: const EdgeInsets.only(top:35.0,right: 20.00,left:20.00),
                        child: Image.asset(
                          'assets/images/ex_logo.png',
                        )
                    ),
                    Container(
                      color: const Color(0x0b000000),
                      margin: const EdgeInsets.only(top:70.00,right: 20.00,left:20.00),
                      child:
                      TextFormField(
                        validator: (input) {
                          if (input!.isEmpty) {
                            return 'Inserici il tuo nome';
                          }
                        },
                        onSaved: (input) => _nome = input!,
                        decoration: const InputDecoration(
                          //fillColor: Colors.white,
                          border: InputBorder.none,
                          labelText: '   Nome',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color:  Color(0x0b000000)
                              )),
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      color: const Color(0x0b000000),
                      margin: const EdgeInsets.only(top:20.0,right: 20.00,left:20.00),
                      child:
                      TextFormField(
                        validator: (input) {
                          if (input!.isEmpty) {
                            return 'Inserici il tuo cognome';
                          }
                        },
                        onSaved: (input) => _cog = input!,
                        decoration: const InputDecoration(
                          //fillColor: Colors.white,
                          border: InputBorder.none,
                          labelText: '   Cognome',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color:  Color(0x0b000000)
                              )),
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      color: const Color(0x0b000000),
                      margin: const EdgeInsets.only(top:20.0,right: 20.00,left:20.00),
                      child:
                      TextFormField(
                        validator: (input1) {
                          if (input1!.isEmpty) {
                            return 'Inserici la tua Email';
                          }
                        },
                        onSaved: (input1) => _email1 = input1!,
                        decoration: const InputDecoration(
                          //fillColor: Colors.white,
                          border: InputBorder.none,
                          labelText: '   Email',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color:  Color(0x0b000000)
                              )),
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      color: const Color(0x0b000000),
                      margin: const EdgeInsets.only(top:20.0,right: 20.00,left:20.00),
                      child:
                      TextFormField(
                        validator: (input) {
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (input!.isEmpty) {
                            return 'Inserisci la tua password';
                          }
                          if(!regex.hasMatch(input)){
                            ("Onserisci una password valida(Min. 6 caratteri)");
                          }
                        },
                        obscureText: true,
                        onSaved: (input) => _password1 = input!,
                        decoration: const InputDecoration(
                          //fillColor: Colors.white,
                          border: InputBorder.none,
                          suffixIcon:  Icon(
                              Icons.visibility
                          ),
                          labelText: '   Password',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color:  Color(0x0b000000)
                              )),
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      color: const Color(0x0b000000),
                      margin: const EdgeInsets.only(top:20.0,right: 20.00,left:20.00),
                      child:
                      TextFormField(
                        validator: (input) {
                          if (input!.isEmpty) {
                            return 'Reinserisci la password';
                          }
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          //fillColor: Colors.white,
                          border: InputBorder.none,
                          suffixIcon:  Icon(
                              Icons.visibility
                          ),
                          labelText: '   Reinserisci Password',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color:  Color(0x0b000000)
                              )),
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:20.00),
                      child:
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                        ),
                        onPressed:Registrati,
                        child: const Text('REGISTRATI'),
                      ),
                    )
                  ]
              ),
            ),

          )
      );
  }

  Future<void> Registrati () async{
    final formState = _formkey1.currentState;
    if(formState!.validate()){
      formState.save();
     try {
       await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email1, password: _password1);
       postDetailToFirestore;
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex) => const PreferitiRegistrazione()));
     }on FirebaseAuthException catch(e){}
      }
    }

  postDetailToFirestore() async{

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user?.email;
    userModel.name = _nome;
    userModel.secondname = _cog;
    userModel.uid = user?.uid;

    await firebaseFirestore
        .collection("user")
        .doc(user?.uid)
        .set(userModel.toMap());

  }
}

class UserModel {
  String? uid;
  String? name;
  String? secondname;
  String? email;

  UserModel({this.uid, this.name, this.secondname, this.email});

  //data from server
  factory UserModel.fromMap(map){
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        secondname: map['secondname']
    );
  }

  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'secondname': secondname
    };
  }

}




