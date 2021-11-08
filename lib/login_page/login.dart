import 'package:cdt/login_page/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}


class LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body:LoginBody(),
    );


  }
}



