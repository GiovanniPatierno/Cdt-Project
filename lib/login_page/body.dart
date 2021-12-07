import 'dart:convert';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:cdt/login_page/google_sing_in.dart';
import 'package:cdt/login_page/post_login.dart';
import 'package:cdt/login_page/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../switchh.dart';
import 'package:provider/provider.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  String?errorMessage;
  late String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child:
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.all(5.00),
                        margin: const EdgeInsets.only(
                            top: 35.0, right: 20.00, left: 20.00),
                        child: Image.asset(
                          'assets/images/ex_logo.png',
                        )
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.00),
                      margin: const EdgeInsets.only(top: 70.0, left: 20.00),
                      child:
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 48,
                          color: Color(0xde000000),
                          height: 1.1666666666666667,
                        ),
                        textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                        color: const Color(0x0b000000),
                        margin: const EdgeInsets.only(
                            top: 10.0, right: 20.00, left: 20.00),
                        child:
                        TextFormField(
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'Inserici un email valida (ex. nuovaemail@gmail.com)';
                            }
                          },
                          onSaved: (input) => _email = input!,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: '   Email',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0)),
                                borderSide: BorderSide(color: Color(0x0b000000))
                            ),
                            filled: true,
                          ),
                        )
                    ),
                    Container(
                      color: const Color(0x0b000000),
                      margin: const EdgeInsets.only(
                          top: 20.0, right: 20.00, left: 20.00),
                      child:
                      TextFormField(
                        validator: (input) {
                          if (input!.length < 6) {
                            return 'Your password need to be at least 6 characters';
                          }
                        },
                        onSaved: (input) => _password = input!,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(
                              Icons.visibility
                          ),
                          labelText: '   Password',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5.0)),
                              borderSide: BorderSide(color: Color(0x0b000000),
                              )),
                          filled: true,
                        ),
                      ),
                    ),
                    Center(
                        child:
                        Container(
                            padding: const EdgeInsets.all(10.00),
                            margin: const EdgeInsets.only(
                                top: 15.0, right: 110.00, left: 110.00),
                            child:
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                onPrimary: Colors.white,
                              ),
                              onPressed: signIn,
                              child: const Text('ACCEDI'),
                            )
                        )
                    ),
                    Center(
                      child:
                      Container(
                        padding: const EdgeInsets.only(top: 50.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child:
                        GoogleAuthButton(
                          darkMode: false,
                          style: const AuthButtonStyle(
                              borderRadius: 20.00
                          ),
                          text: 'Accedi con Google',
                          onPressed: () {
                            final provider = Provider.of<GoogleSignInProvider>(
                                context, listen: false);
                            provider.googleLogin();
                            Navigator.push(context, MaterialPageRoute(builder: (
                                contex) =>  Switchh( index2: 2,)));
                          },
                        ),
                      ),
                    ),
                    const OrWidget(),
                    Center(
                        child:
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const Registration()));
                            },
                            child: const Text(
                              'REGISTRATI ORA',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Color(0xff000000),
                                letterSpacing: 1.246,
                                fontWeight: FontWeight.w500,
                                height: 1.1428571428571428,
                              ),
                            ))
                    )
                  ]
              ),
            )
        )
    );
  }


  Future<void> signIn() async {
    final formState = _formkey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (contex) => const PostLogin()));
        _showToast(context);
      }on FirebaseAuthException catch (error){switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";

          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }}
    }
  }
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Login avvenuto con successo!'),
        //action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}



class OrWidget extends StatelessWidget {
  const OrWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top:0.00),
        padding: const EdgeInsets.all(30.00),
        child:
        Row(
            children:<Widget>[
              Container(
                  margin: const EdgeInsets.only(right:15.00),
                  child:
                  SvgPicture.string(
                    '<svg viewBox="42.0 717.0 129.0 1.0" ><path transform="translate(42.0, 717.0)" d="M 0 0 L 129 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  )
              ),
              const Text(
                'oppure',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: Color(0xde000000),
                  letterSpacing: 0.252,
                  height: 1.4285714285714286,
                ),
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.left,
              ),
              Container(
                  margin: const EdgeInsets.only(left:14.00),
                  child:
                  SvgPicture.string(
                    '<svg viewBox="42.0 717.0 129.0 1.0" ><path transform="translate(42.0, 717.0)" d="M 0 0 L 129 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  )
              )
            ]
        )
    );
  }
}

