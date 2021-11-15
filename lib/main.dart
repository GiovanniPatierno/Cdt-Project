import 'package:cdt/login_page/google_sing_in.dart';
import 'package:cdt/login_page/login.dart';
import 'package:cdt/login_page/padiglioni.dart';
import 'package:cdt/login_page/preferiti.dart';
import 'package:cdt/padiglioni_page.dart';
import 'package:cdt/preferiti_page.dart';
import 'package:cdt/switchh.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child :const MaterialApp(
          home: Login(),
        //home: Switchh()
    ),
  );
}


