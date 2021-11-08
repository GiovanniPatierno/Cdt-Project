import 'package:cdt/login_page/padiglioni.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreferitiRegistrazione extends StatefulWidget {
  const PreferitiRegistrazione({Key? key}) : super(key: key);

  @override
  _PreferitiRegistrazioneState createState() => _PreferitiRegistrazioneState();
}

class _PreferitiRegistrazioneState extends State<PreferitiRegistrazione> {
bool value = false;
final notifications =[
  NotificationSettings(title: 'Auto',icon: Icons.directions_car_sharp),
  NotificationSettings(title: 'Vino',icon: Icons.wine_bar),
  NotificationSettings(title: 'Relax',icon: Icons.bed),
  NotificationSettings(title: 'Benessere',icon: Icons.local_florist),
  NotificationSettings(title: 'Bellezza',icon: Icons.accessibility),
  NotificationSettings(title: 'Regione',icon: Icons.account_balance),
  NotificationSettings(title: 'Sicilia',icon: Icons.photo_size_select_actual_outlined),
  NotificationSettings(title: 'Enti',icon: Icons.add_business),
  NotificationSettings(title: 'Comune',icon: Icons.home_filled),
  NotificationSettings(title: 'Panificio',icon: Icons.breakfast_dining),
  NotificationSettings(title: 'Imprese',icon: Icons.home_repair_service_rounded),
  NotificationSettings(title: 'Bimbi',icon: Icons.child_friendly),
  NotificationSettings(title: 'Congresso',icon: Icons.apartment),
  NotificationSettings(title: 'Artigianato',icon: Icons.construction),
  NotificationSettings(title: 'Ristoro',icon: Icons.restaurant),
  NotificationSettings(title: 'Bevande',icon: Icons.local_drink),
  NotificationSettings(title: 'Innovazione',icon: Icons.architecture),
  NotificationSettings(title: 'Tecnologie',icon: Icons.biotech),
  NotificationSettings(title: 'Mobili',icon: Icons.bed),
  NotificationSettings(title: 'Casa',icon: Icons.home),
  NotificationSettings(title: 'Gastronomia',icon: Icons.restaurant_menu),
  NotificationSettings(title: 'Arredo',icon: Icons.inbox_outlined),
  NotificationSettings(title: 'Edilizia',icon: Icons.location_city),
  NotificationSettings(title: 'Cibo',icon: Icons.restaurant_menu),
  NotificationSettings(title: 'Volontariato',icon: Icons.add),
  NotificationSettings(title: 'Esterni',icon: Icons.deck),
  NotificationSettings(title: 'Usato',icon: Icons.all_inclusive_rounded),
  NotificationSettings(title: 'Regalo',icon: Icons.card_giftcard),
  NotificationSettings(title: 'Fai da te',icon: Icons.construction),
];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
           children : <Widget>[

             Container(
               padding: const EdgeInsets.only(top:50.00),
               child:
               const Text(
               'BENVENUTO!',
               style: TextStyle(
                 fontFamily: 'Roboto',
                 fontSize: 33,
                 color: Color(0xde000000),
                 height: 1.1818181818181819,
               ),
               textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
               textAlign: TextAlign.left,
             ),
        ),
             Container(
               padding: const EdgeInsets.all(30.00),
               child: const Text(
                 'In questa schermata vengono proposti dei temi di interesse. Seleziona i temi che più ti interessano per scoprire quali padiglioni potrebbero interessarti.\n',
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
               padding: const EdgeInsets.only(bottom: 70.00),

                   child:
                   ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       primary: Colors.black,
                       onPrimary: Colors.white,
                     ),
                     onPressed:(){
                       Navigator.push(context, MaterialPageRoute(builder: (contex) => const PadiglioniRegistrazione()));
                     },
                     child: const Text('Avanti'),
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
      title:  Text(notification.title),
      leading: Icon(notification.icon),
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

class NotificationSettings{
  String title;
  bool value;
  IconData icon;

  NotificationSettings({
    required this.title,
    required this.icon,
    this.value=false,
});
}