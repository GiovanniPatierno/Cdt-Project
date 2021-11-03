import 'package:auth_buttons/auth_buttons.dart';
import 'package:cdt/login_page/google_sing_in.dart';
import 'package:cdt/login_page/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../home.dart';
import 'package:provider/provider.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold (
        backgroundColor: Colors.white,
        body: Form(
          key : _formkey,
          child:
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(5.00),
                    margin: const EdgeInsets.only(top:35.0,right: 20.00,left:20.00),
                    child: Image.asset(
                      'assets/images/ex_logo.png',
                    )
                ),
                Container(
                  padding: const EdgeInsets.all(5.00),
                  margin: const EdgeInsets.only(top:70.0,left: 20.00),
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
                    //decoration: const BoxDecoration(
                      //color:  Color(0x0b000000),
                      //borderRadius: BorderRadius.only(
                      // topLeft: Radius.circular(4.0),
                      //topRight: Radius.circular(4.0),
                      //),
                    //),

                    //padding: const EdgeInsets.all(5.00),
                    margin: const EdgeInsets.only(top:0.0,right: 20.00,left:20.00),
                    child:
                    TextFormField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Inserici un email valida (ex. nuovaemail@gmail.com)';
                        }
                      },
                      onSaved: (input) => _email = input!,
                      decoration: const InputDecoration(
                        //border: OutlineInputBorder(),
                        labelText: '   Email',
                     ),
                    )
                ),
                Container(
                  color: const Color(0x0b000000),
                  //decoration: const BoxDecoration(
                    //borderRadius: BorderRadius.only(
                    //topLeft: Radius.circular(4.0),
                    //topRight: Radius.circular(4.0),
                    // ),
                    //color: Color(0x0b000000),
                  //),
                  //padding: const EdgeInsets.all(5.00),
                  margin: const EdgeInsets.only(top:10.0,right: 20.00,left:20.00),
                  child:
                  TextFormField(
                    obscureText: true,
                    validator: (input) {
                      if (input!.length < 6) {
                        return 'Your password need to be at least 6 characters';
                      }
                    },
                    onSaved: (input) => _password = input!,
                    decoration: const InputDecoration(
                      suffixIcon:  Icon(
                          Icons.visibility
                      ),
                      //border: OutlineInputBorder(),
                      labelText: '   Password',
                    ),
                  ),
                  /*Container(
                        child:
                        SvgPicture.string(
                        '<svg viewBox="1.0 4.5 22.0 15.0" ><path transform="translate(1.0, 4.5)" d="M 10.99980068206787 15.00030040740967 C 8.580410957336426 15.00030040740967 6.254580497741699 14.27276039123535 4.273760795593262 12.89632034301758 C 2.339250564575195 11.55207061767578 0.8614106774330139 9.68595027923584 6.820678777330613e-07 7.49970006942749 C 0.8615806698799133 5.313470363616943 2.339420795440674 3.447880268096924 4.273760795593262 2.103860139846802 C 6.254650592803955 0.7275002002716064 8.580471038818359 2.037048290048915e-07 10.99980068206787 2.037048290048915e-07 C 13.41946029663086 2.037048290048915e-07 15.74540042877197 0.7275002002716064 17.72617149353027 2.103860139846802 C 19.66039085388184 3.447870254516602 21.13812065124512 5.313720226287842 21.99960136413574 7.49970006942749 C 21.13801002502441 9.686400413513184 19.6602897644043 11.55226993560791 17.72617149353027 12.89632034301758 C 15.74547100067139 14.27276039123535 13.41952037811279 15.00030040740967 10.99980068206787 15.00030040740967 Z M 10.99980068206787 2.500200271606445 C 8.243070602416992 2.500200271606445 6.000300884246826 4.742969989776611 6.000300884246826 7.49970006942749 C 6.000300884246826 10.25693035125732 8.243070602416992 12.50010013580322 10.99980068206787 12.50010013580322 C 13.75703048706055 12.50010013580322 16.00020027160645 10.25693035125732 16.00020027160645 7.49970006942749 C 16.00020027160645 4.742969989776611 13.75703048706055 2.500200271606445 10.99980068206787 2.500200271606445 Z M 10.99980068206787 10.50030040740967 C 9.345760345458984 10.50030040740967 8.000101089477539 9.154240608215332 8.000101089477539 7.49970006942749 C 8.000101089477539 5.845660209655762 9.345760345458984 4.5 10.99980068206787 4.5 C 12.65434074401855 4.5 14.00040054321289 5.845660209655762 14.00040054321289 7.49970006942749 C 14.00040054321289 9.154240608215332 12.65434074401855 10.50030040740967 10.99980068206787 10.50030040740967 Z" fill="#000000" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),
                      ),*/
                ),
                Center(
                    child:
                    Container(
                        padding: const EdgeInsets.all(10.00),
                        margin: const EdgeInsets.only(top:15.0,right: 110.00,left:110.00),
                        child:
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            onPrimary: Colors.white,
                          ),
                          onPressed:signIn,
                          child: const Text('ACCEDI'),
                        )
                    )
                ),
                Center(
                  child:
                  Container(
                    padding: const EdgeInsets.all(3.00),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30)),
                    child:
                    GoogleAuthButton(
                      darkMode: false,
                      style:  const AuthButtonStyle(
                          borderRadius:  20.00
                      ),
                      text : 'Accedi con Google',
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(context, listen:false);
                        provider.googleLogin();
                        Navigator.push(context,MaterialPageRoute(builder: (contex) => const Home()));
                      },
                    ),
                  ),
                ),
                const OrWidget(),
                Center(
                  child:
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Registration()));
                  },
                    child: const Text(
                  'REGISTRATI ORA',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color:  Color(0xff000000),
                    letterSpacing: 1.246,
                    fontWeight: FontWeight.w500,
                    height: 1.1428571428571428,
                  ),
                ))
                    )

              ]
          ),
        )
    );
  }


  Future<void> signIn() async {
    final formState = _formkey.currentState;
    if(formState!.validate()){
      formState.save();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword( email: _email, password: _password);
        
        Navigator.push(context, MaterialPageRoute(builder: (contex) => const Home()));
      }on FirebaseAuthException catch(e){}
    }
  }
}




class OrWidget extends StatelessWidget {
  const OrWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top:10.00),
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

