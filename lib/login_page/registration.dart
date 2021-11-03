import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:cdt/login_page/google_sing_in.dart';
import 'package:cdt/login_page/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../home.dart';
import 'package:provider/provider.dart';


class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationCreateState createState() =>  _RegistrationCreateState();
}

class  _RegistrationCreateState extends State<Registration> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String _nome,_cognome,_password, _email;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Form(
            key : _formkey,
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
                    //border: OutlineInputBorder(),
                    labelText: '   Nome',
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
                  onSaved: (input) => _cognome = input!,
                  decoration: const InputDecoration(
                    //border: OutlineInputBorder(),
                    labelText: '   Cognome',
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
                      return 'Inserici la tua Email';
                    }
                  },
                  onSaved: (input) => _email = input!,
                  decoration: const InputDecoration(
                    //border: OutlineInputBorder(),
                    labelText: '   Email',
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
                    onSaved: (input) => _password = input!,
                    decoration: const InputDecoration(
                      //border: OutlineInputBorder(),
                      labelText: '   Password',
                    ),
                  ),
                ),
               /* Container(
                  color: const Color(0x0b000000),
                  margin: const EdgeInsets.only(top:20.0,right: 20.00,left:20.00),
                  child:
                  TextFormField(
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'Reinserisci la password';
                      }
                    },
                    onSaved: (input) => _Password = input!,
                    decoration: const InputDecoration(
                      //border: OutlineInputBorder(),
                      labelText: '   Conferma Password',
                    ),
                  ),
                ),*/
                Container(
                  margin: const EdgeInsets.only(top:20.00),
                  child:
                ElevatedButton(
                   style: ElevatedButton.styleFrom(
                   primary: Colors.black,
                   onPrimary: Colors.white,
                   ),
                  onPressed:(){
                     Registrati();
                  },
                   child: const Text('REGISTRATI'),
                ),
                )
                ]
            ),
          )
      );
  }

  void Registrati () async{
    if(_formkey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
      postDetailToFirestore();
    }
  }


  postDetailToFirestore() async{
    //call firestor
    //call UserModel
    //sending values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = _email;
    userModel.name = _nome;
    userModel.secondname = _cognome;
    userModel.uid = user!.uid;

    await firebaseFirestore
    .collection("user")
    .doc(user.uid)
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
      uid : map['uid'],
      email: map['email'],
      name: map['name'],
      secondname: map['secondname']
    );
  }

  //sending data to server
  Map<String, dynamic> toMap(){
    return {
      'uid' : uid,
      'email': email,
      'name': name,
      'secondname': secondname
    };
  }
}




