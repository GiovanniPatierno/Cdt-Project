  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';

  class HomePage extends StatefulWidget {
    const HomePage({Key? key}) : super(key: key);

    @override
    _HomePageState createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:const Center( child: Text('Home')),
          backgroundColor: Colors.black,
        ),
        body: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child:
              Container(
                  //padding: const EdgeInsets.only(top:10.00, right:20.00, left:20.00),
                child:
               ListView(
               //padding: const EdgeInsets.all(8),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(bottom: 10.00),
                      child:
                      Image.asset(
                        'assets/images/entrata.jpg',
                      )
                  ),
                  Card(
                      margin: const EdgeInsets.only(right: 15.00, left: 15.00),
                      elevation: 1,
                      child:
                      Container(
                          padding: const EdgeInsets.all(10),
                          child:
                          Column(
                              children: const <Widget>[
                                Center(
                                    child:
                                    Text(
                                      'ORARI DI APERTURA/CHIUSURA',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20,
                                        color: Color(0xde000000),
                                        height: 1,
                                      ),
                                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                      textAlign: TextAlign.center,
                                    )
                                ),
                                SizedBox(height: 6),
                                Center(
                                    child:
                                    Text(
                                      'Lunedi-Martedì : 10.00 - 16.00',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        color: Color(0xde000000),
                                        letterSpacing: 0.144,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.start,
                                    )
                                ),
                                SizedBox(height: 2),
                                Center(child:Text(
                                  'Mercoledì-Giovedì: 10.00-18.00',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    color: Color(0xde000000),
                                    letterSpacing: 0.144,
                                    height: 1.5,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                )
                                ),
                                SizedBox(height: 2),
                                Center(child:Text(
                                  'Venerdì-Sabato: 13.00-00.00',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    color: Color(0xde000000),
                                    letterSpacing: 0.144,
                                    height: 1.5,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                )
                                ),
                                SizedBox(height: 2),
                                Center(child: Text(
                                  'Domenica: 10.00- 20.00',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    color: Color(0xde000000),
                                    letterSpacing: 0.144,
                                    height: 1.5,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                )
                                ),
                              ]
                          )
                      )
                  ),
                  Card(
                    margin: const EdgeInsets.only(right: 15.00, left: 15.00,bottom: 5, top:5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        ListTile(
                          leading: Icon(Icons.add_box_outlined, size: 50),
                          title: Text('Regole anti Covid-19'),
                          subtitle: Text('prevenzione'),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(right: 15.00, left: 15.00,bottom: 5, top:5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        ListTile(
                          leading: Icon(Icons.event, size: 50),
                          title: Text('Living Dinosaur'),
                          subtitle: Text('22-10-2021'),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(right: 15.00, left: 15.00,bottom: 5, top:5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        ListTile(
                          leading: Icon(Icons.event, size: 50),
                          title: Text('ENOLINEXPO'),
                          subtitle: Text('10-03-2022'),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(right: 15.00, left: 15.00,bottom: 5, top:5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        ListTile(
                          leading: Icon(Icons.event, size: 50),
                          title: Text('SMART BUILDING LEVANTE'),
                          subtitle: Text('10-05-2022'),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(right: 15.00, left: 15.00,bottom: 5, top:5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        ListTile(
                          leading: Icon(Icons.event, size: 50),
                          title: Text('85° Fiera del Levante'),
                          subtitle: Text('19-02-2022'),
                        ),
                      ],
                    ),
                  ),

                ],
              )
              )
              )
            ]
        )
      );
    }
  }
