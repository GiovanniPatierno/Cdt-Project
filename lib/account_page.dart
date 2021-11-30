import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {



  @override
  Widget build(BuildContext context) {


    final signUpButton = Center(
      child:
      Container(
          padding: const EdgeInsets.only(top:30.00),
          //margin: const EdgeInsets.only(top:15.0,right: 110.00,left:110.00),
          child:
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              //Registrati( passwordEditingController.text);},
            },
            child: const Text('LOGOUT',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color:  Colors.white,
                letterSpacing: 1.246,
                fontWeight: FontWeight.w500,
                height: 1.1428571428571428,
              ),
            ),
          )
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Center( child: Text('Account')),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(child:
      Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
           children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 10.00),
                  child:
               const CircleAvatar(
                  radius: 80,
                backgroundColor: Colors.grey,
              )),
              Container(
                width: 1000,
                height: 200,
                color: Colors.black38,
              ),
                ]),
           Container(
             padding: const EdgeInsets.all(10),
           child: const Text("Giovanni Paolo Patierno",
             style: TextStyle(
                 color: Colors.white
             ),
           ),

           )
               ]

    ),
          const SizedBox(
            height: 20,
          ),
          Row(children: <Widget>[
            Container(
                margin: EdgeInsets.all(20),
                width: 180,
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:  const Color(0x0b000000),
                  //border: Border.all(color:  const Color(0x0b000000), width: 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child:
                const Text("Giovanni Paolo",
                    style: TextStyle(
                      //fontSize: 30,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                    )
                )
            ),
            Container(
                //margin: EdgeInsets.all(10),
                width: 152,
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:  const Color(0x0b000000),
                  //border: Border.all(color:  const Color(0x0b000000), width: 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child:
                const Text("Patierno",
                    style: TextStyle(
                      //fontSize: 30,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                    )
                )
            ),

          ],
          ),
                Container(
                    padding: const EdgeInsets.only(left:20.00, right: 20.00),
                  child:
                    Column(
                      children: <Widget>[

                         const SizedBox(height: 190),
                         signUpButton,
                            const SizedBox(height: 5),
                           const Divider(
                         color: Colors.black,
                          height: 1,
                            ),
                    const SizedBox(height: 10),
                ])),
                        Center(
                            child:
                            GestureDetector(
                                onTap: () {
                   // Navigator.push(context, MaterialPageRoute(
                        //builder: (context) => const Registration()));
                  },
                  child: const Text(
                    'cancella account',
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
          )
          )
          );
  }
}
