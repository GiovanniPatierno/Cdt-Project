
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:flutter_map/plugin_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:geolocator/geolocator.dart' ;
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

import 'dettagli_padiglione.dart';
//import 'package:universe/universe.dart';






Future<List<Padiglioni88>> fetchPadiglioni(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://192.168.1.241:9250/api/padiglioni'));
  // Use the compute function to run parsePhotos in a separate isolate.
  //print(response.body);
  return compute(parsePadiglioni, utf8.decode(response.bodyBytes));
}

// A function that converts a response body into a List<Photo>.
List<Padiglioni88> parsePadiglioni(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Padiglioni88>((json) => Padiglioni88.fromJson(json)).toList();
}


class Padiglioni88 {
  String? id;
  String? nome;
  String? descrizione;
  String? area;
  String? type;
  //Properties? properties;
  Geometry? geometry;
  List<Interessi>? interessi;
  bool check = false;
  Color color = Colors.black38;
  String? stand;
  int capienzaMax = 30;
  int capienzaAttuale= 17;


  Padiglioni88({this.id, this.nome, this.descrizione, this.area, this.type, this.geometry,   required this.check,  required this.color, required this.stand,});

  Padiglioni88.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nome = json["nome"];
    descrizione = json["descrizione"];
    area = json["area"];
    type = json["type"];
    geometry = json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]);
    interessi = json["interessi"]==null ? null : (json["interessi"] as List).map((e)=>Interessi.fromJson(e)).toList();
    stand = json['stand'] as String;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["nome"] = nome;
    data["descrizione"] = descrizione;
    data["area"] = area;
    data["type"] = type;
   /* if(this.properties != null)
      data["properties"] = this.properties?.toJson();*/
    if(geometry != null) {
      data["geometry"] = geometry?.toJson();
    }
    if(interessi != null) {
      data["interessi"] = interessi?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}

class Interessi {
  String? id;
  String? name;
  Interessi({this.id, this.name});
  Interessi.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Geometry {
  List<dynamic>? coordinates;
  String? type;

  Geometry({this.coordinates, this.type});

  Geometry.fromJson(Map<String, dynamic> json) {
    coordinates = json["coordinates"]==null ? null : json["coordinates"][0];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(coordinates != null) {
      data["coordinates"] = coordinates;
    }
    data["type"] = type;
    return data;
  }
}

class Properties {
  Properties();
  Properties.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}




class Map1 extends StatefulWidget {
  const Map1({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map1>  {
  List list = [];




  @override
  Widget build(BuildContext context) {
    var firebaseUser =  FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).get().then((value){
      print(value.data()!['padiglioni']);
      list = value.data()!['padiglioni'] as List;
    });
    return FutureBuilder<List<Padiglioni88>>(
      future: fetchPadiglioni(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          for (int j = 0; j < snapshot.data!.length; j++) {
            for (int i = 0; i < list.length; i++) {
             if (snapshot.data![j].nome == list[i]) {
                snapshot.data![j].check = true;
              }
            }
          }

          return Lists(data: snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class Lists extends StatelessWidget {
  Lists({Key? key, required this.data}) : super(key: key);
  final List<Padiglioni88> data;
  var points = <latLng.LatLng>[];
  var locations = "";

  var bounds = LatLngBounds();


  @override
  Widget build(BuildContext context) {
    Position currentPostion;
    latLng.LatLng utente;
    Geolocator geolocator;
    Position position;


    locatePosition() async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentPostion = position;
      utente = latLng.LatLng(position.latitude, position.longitude);
    }

    // locatePosition();
    //print(utente);

    Map map1 ={'Be Wine' : Colors.pink, 'SALONE DELL INNOVAZIONE':Colors.black87,'ENTI E ISTITUZIONI':Colors.cyan,'AUTOMOTIVE':Colors.teal,'ARTICOLI DA REGALO':Colors.deepPurple,'ARTICOLI PER LA CASA': Colors.brown,'SICILIA':Colors.purple,'CENTRO CONGRESSI DEL LEVANTE':Colors.green, 'EDILIZIA ABITATIVA':Colors.lightGreen,'ARTIGIANATO ESTERO': Colors.deepOrangeAccent,'ARTIGIANATO ESTERO': Colors.deepOrangeAccent,'SALONE DELL ARREDAMENTO':Colors.blue,'ARREDO PER ESTERNI':Colors.orangeAccent,'AGROALIMENTARE':Colors.lime,'CENTRO SERVIZIO VOLONTARIATO':Colors.blueGrey,'BENESSERE E RELAX': Colors.purpleAccent,'AREA BIMBI':Colors.limeAccent,'MEDITERRANEAN BEAUTY BARI':Colors.yellow};

    Colorrr(i){
      if(data[i].check == true) {
        if (map1.containsKey(data[i].stand)) {
          data[i].color = map1[data[i].stand];
        }
      }
      return  data[i].color;
    }

    Colorr(i){

        if (map1.containsKey(data[i].stand)) {
          data[i].color = map1[data[i].stand];
        }

      return  data[i].color;
    }

    Map map2 = {0: 10, 1:24, 2:9, 3:5, 4:19, 5:29, 6:18, 7:10, 8:23, 9:30, 10:20, 11:2, 12: 26, 13:21, 14:14, 15:1, 16:25, 17:22, 18:17, 19:2, 20:10, 21: 2, 22: 16, 23:19, 24:7, 25: 13, 26:9 };
    String Rischio(map, int Max, int i){
      String rischio = '';
      if(Max - map[i] < 7 ){
        rischio = 'Alto';
      }
      if( 14 >= Max - map[i] && Max - map[i] >= 7){
        rischio = 'Medio';
      }if(Max - map[i] > 14){
        rischio = 'Basso';
      }
      return rischio;
    }

    Color ColorRischio(map, int Max, int i){
      Color rischio = Colors.black;
      if(Max - map[i] < 7 ){
        rischio = Colors.red;
      }
      if( 14 >= Max - map[i] && Max - map[i] >= 7){
        rischio = Colors.amber;
      }if(Max - map[i] > 14){
        rischio = Colors.green;
      }
      return rischio;
    }

    var markers = <Marker>[];
    for (int i = 0; i < data.length; i++) {
      markers.add(Marker(
         // width: 10.0,
         // height: 10.0,
          point: getCenter(i),
          builder: (ctx) =>
          InkWell(
            child:
            Container(
              height: 40,
              width: 40,
            ),
              onTap: () {
                showModalBottomSheet(context: context, builder: (builder){
                  return Container(
                    color: Colors.white,
                    child:
                      Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                              child:
                          Text(data[i].nome!,style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            color: Color(0xde000000),
                            letterSpacing: 0.252,
                            height: 1.4285714285714286,
                          ))),
                          const SizedBox(height: 20),
                          Text(
                            data[i].stand!,
                            style: TextStyle(color: Colorr(i)),
                          ),
                          const SizedBox(height: 30),
                           Text('Capienza massima: '+data[i].capienzaMax.toString()),
                          const SizedBox(height: 15),
                           Text('Visitatori all interno :'+ map2[i].toString()),
                          const SizedBox(height: 20),

                          Center(child:
                          Row(children:  [
                           Container(
                             margin: EdgeInsets.only(left: 130),
                               child:
                               const Text("Rischio: ",style: TextStyle(fontSize: 20))
                           ),
                            Text(Rischio(map2,30,i),
                              style: TextStyle(fontSize: 20,
                                  color: ColorRischio(map2,30, i)
                              ),
                            ),
                          ])),
                          const SizedBox(height: 40),
                          Text( data[i].descrizione!, textAlign: TextAlign.center,)
                        ],
                      )
                  );
                });
              },
                )
      )

    );
    }

    Map map3 = {'Nuovo padiglione - Salone dell innovazione': 1,'Palesano': 2, 'Padiglioni 85-89': 85, 'Padiglione 90': 90, 'Padiglione 94': 94, 'Padiglione 139': 139, 'Centro congressi del Levante': 3,'Apulia film house': 4, 'Padiglione 19' : 19, 'Padiglione 96': 96, 'Padiglione 20 - Be wine': 20, 'Nuovo padiglione - Salone dell arredamento': 5, 'Nuovo padiglione - Arredo per esterni': 6, 'Padiglione 18': 18, 'Padiglione 20 - Centro servizio volontario': 21, 'Padiglione 71': 71, 'Nuovo padiglione - Benessere e relax': 7, 'Comune di Bari': 8,'Padiglione 149': 149, 'Cineporto':9, 'Padiglione 168': 168, 'Regione Puglia':10, 'Padiglioni 47 Ovest': 47, 'Confartigianato': 11, 'Puglia promozione': 12 ,'Nuovo padiglione - Mediterranean beauty Bari':13};

    var poli = <Polygon>[];
    for (int i = 0; i < data.length; i++) {
      poli.add(Polygon(
        points: points = CratorPoints(i),
        //strokeWidth: 5.00,
        color: Colorrr(i).withOpacity(0.3),
        borderColor: Colorrr(i),
        borderStrokeWidth: 1.0,

      ));
    }

    var markers2 = <Marker>[];
    for (int i = 0; i < data.length; i++) {
      markers2.add(Marker(
         width: 30,
         height: 30,
        //anchorPos: getCenter(i),
        point: getCenter(i),
        builder: (ctx) =>
        Container(child:
          Center(child: Text(map3[data[i].nome].toString(),style: const TextStyle(fontSize: 15),),))));
      }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:const Center( child: Text('Map')),
          backgroundColor: Colors.black,
        ),
        body: FlutterMap(
          options: MapOptions(
            center: latLng.LatLng(41.136423, 16.838197),
            zoom: 15.0,
            plugins: [
              const LocationMarkerPlugin(),
            ],
          ),
          mapController: MapController(),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://api.mapbox.com/styles/v1/patierno1/ckwlyz6455mvj14n4c872coe4/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicGF0aWVybm8xIiwiYSI6ImNrdWZhb3EyYjBnajkydnFlMmdnYXVqenEifQ.CF0aaxP46ecopgUdTrDmpA",
              additionalOptions: {
                'accessToken': 'pk.eyJ1IjoicGF0aWVybm8xIiwiYSI6ImNrdWZhb3EyYjBnajkydnFlMmdnYXVqenEifQ.CF0aaxP46ecopgUdTrDmpA',
              },
              attributionBuilder: (_) {
                return const Text("© OpenStreetMap contributors");
              },
            ),

            LocationMarkerLayerOptions(
              marker: const DefaultLocationMarker(
                color: Colors.blueAccent,

              ),
              markerSize: const Size(10, 10),
              accuracyCircleColor: Colors.blueAccent.withOpacity(0.1),
              headingSectorColor: Colors.blueAccent.withOpacity(0.8),
              headingSectorRadius: 90,
              markerAnimationDuration: Duration.zero, // disable animation
            ),
            PolygonLayerOptions(
                polygons: poli
            ),
            MarkerLayerOptions(
                markers: markers
            ),
           MarkerLayerOptions(
               markers: markers2
            )
          ],
        )
    );
  }

  List<latLng.LatLng> CratorPoints(int index) {
    var points = <latLng.LatLng>[];
    for (int j = 0; j < data[index].geometry!.coordinates!.length; j++) {
      points.add(latLng.LatLng(data[index].geometry!.coordinates![j][1],
          data[index].geometry!.coordinates![j][0]));
    }
    return points;
  }

  getCenter(int index)  {
    double lat = 0, long = 0;
    for(int i = 0; i<data[index].geometry!.coordinates!.length; i++){
      lat = lat + data[index].geometry!.coordinates![i][1];
    }
    for(int i = 0; i<data[index].geometry!.coordinates!.length; i++){
      long = long + data[index].geometry!.coordinates![i][0];
    }
    latLng.LatLng center = latLng.LatLng(
      lat / data[index].geometry!.coordinates!.length,
      long / data[index].geometry!.coordinates!.length
    );

    return center;
  }
}




