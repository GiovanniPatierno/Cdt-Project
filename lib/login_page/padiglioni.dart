import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../switchh.dart';

class PadiglioniRegistrazione extends StatefulWidget {
  const PadiglioniRegistrazione({Key? key}) : super(key: key);

  @override
  _PadiglioniRegistrazioneState createState() => _PadiglioniRegistrazioneState();
}

class _PadiglioniRegistrazioneState extends State<PadiglioniRegistrazione> {
  bool value = false;
  final notifications =[
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
    NotificationSettings(title: 'Padiglione 1', image: const AssetImage('assets/images/ex_logo.png')),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Column(
          children : <Widget>[

            Container(
              padding: const EdgeInsets.only(top:80.00,right: 10.00,left: 10.00),
              child: const Text(
                'Qui puoi trovare i padiglioni selezionati in base ai temi scelti da te. Puoi selezionare anche altri stand da visitare cliccando sulla spunta in alto a destra. Clicca Avanti per completare l\'operazione. Potrai sempre cambiare le tue scelte nella sezione Preferiti\n',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  color: Color(0xde000000),
                  letterSpacing: 0.144,
                  height: 1.5,
                ),
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child:
              Container(
                padding: const EdgeInsets.only(top:10.00,bottom: 40.00),
                child:
                ListView(
                    padding: const EdgeInsets.all(10),
                    children: [
                      ...notifications.map(buildSingleCheckbox).toList(),
                    ]
                ),

              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 50.00),

              child:
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                ),
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (contex) => const Switchh()));
                },
                child: const Text('AVANTI'),
              ),
            )
          ]
      )
  );

  Widget buildCheckBox({
    required NotificationSettings notification,
    required VoidCallback onClicked
  }) =>  ListTile(
    onTap: onClicked,
    title:  Center(child:Text(notification.title)),
     leading: Image(image:notification.image,width: 70.00),
    trailing: Checkbox(
      activeColor: Colors.black,
      value: notification.value,
      onChanged: (value)=> onClicked(),
    ),
  );

  Widget buildSingleCheckbox(NotificationSettings notifications) =>
      buildCheckBox(notification: notifications,
          onClicked: (){
            setState(() {
              final newValue =!notifications.value;
              notifications.value = newValue;
            });
          });
}

class NotificationSettings {
  String title;
  bool value;
  AssetImage image;

  NotificationSettings({
    required this.title,
    required this.image,
    this.value = false,
  });
}