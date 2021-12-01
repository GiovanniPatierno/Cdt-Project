import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:flutter_map/plugin_api.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:geolocator/geolocator.dart' ;
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';






Future<List<Padiglioni88>> fetchPadiglioni(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://192.168.1.241:9250/api/padiglioni'));
  // Use the compute function to run parsePhotos in a separate isolate.
  //print(response.body);
  return compute(parsePadiglioni, response.body);
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


  Padiglioni88({this.id, this.nome, this.descrizione, this.area, this.type, this.geometry,   required this.check});

  Padiglioni88.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nome = json["nome"];
    descrizione = json["descrizione"];
    area = json["area"];
    type = json["type"];
    geometry = json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]);
    interessi = json["interessi"]==null ? null : (json["interessi"] as List).map((e)=>Interessi.fromJson(e)).toList();
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


    Color Colorrr(int i) {
      Color color = Colors.black87.withOpacity(0.5);
      if (data[i].check == true) {
        color = Colors.green.withOpacity(0.5);
      }
      return color;
    }


    var markers = <Marker>[];
    for (int i = 0; i < data.length; i++) {
      markers.add(Marker(
          width: 10.0,
          height: 10.0,
          point: getCenter(i),//latLng.LatLng(data[i].geometry!.coordinates![2][1],
              //data[i].geometry!.coordinates![2][0]),
          builder: (ctx) =>
              Container(
                  padding: EdgeInsets.all(10),
                  width: 0.1,
                  height: 0.1,
                  decoration: BoxDecoration(color: Colors.white,
                      border: Border.all(color: Colors.black)
                  ),
                  child: const Text(
                      "204"
                  )
              )));
    }

    var poli = <Polygon>[];
    for (int i = 0; i < data.length; i++) {
      poli.add(Polygon(
        points: points = CratorPoints(i),
        //strokeWidth: 5.00,
        color: Colorrr(i),
        borderColor: Colorrr(i),
        borderStrokeWidth: 1.0,

      ));
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
              LocationMarkerPlugin(),
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
                color: Colors.green,
              ),
              markerSize: const Size(20, 20),
              accuracyCircleColor: Colors.green.withOpacity(0.1),
              headingSectorColor: Colors.green.withOpacity(0.8),
              headingSectorRadius: 120,
              markerAnimationDuration: Duration.zero, // disable animation
            ),
            PolygonLayerOptions(
                polygons: poli
            ),
            MarkerLayerOptions(
                markers: markers
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

    latLng.LatLng center = latLng.LatLng(
      (data[index].geometry!.coordinates![0][1] + data[index].geometry!.coordinates![4][1]) / 2,
      (data[index].geometry!.coordinates![0][0] +data[index].geometry!.coordinates![4][0]) / 2,
    );

    return center;
  }
}




