import 'dart:convert';
import 'dart:ffi';
import 'package:cdt/padiglioni_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlng/latlng.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:http/http.dart' as http;
import 'dart:async';


Future<List<Padiglioni>> fetchPadiglioni(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://192.168.1.241:9250/api/padiglioni'));
  // Use the compute function to run parsePhotos in a separate isolate.
  //print(response.body);
  return compute(parsePadiglioni, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Padiglioni> parsePadiglioni(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Padiglioni>((json) => Padiglioni.fromJson(json)).toList();
}


class Padiglioni {
  String? id;
  String? nome;
  String? descrizione;
  String? area;
  String? type;
  //Properties? properties;
  Geometry? geometry;
  List<Interessi>? interessi;

  Padiglioni({this.id, this.nome, this.descrizione, this.area, this.type, this.geometry});

  Padiglioni.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.nome = json["nome"];
    this.descrizione = json["descrizione"];
    this.area = json["area"];
    this.type = json["type"];
   // this.properties = json["properties"] == null ? null : Properties.fromJson(json["properties"]);
    this.geometry = json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]);
    this.interessi = json["interessi"]==null ? null : (json["interessi"] as List).map((e)=>Interessi.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["nome"] = this.nome;
    data["descrizione"] = this.descrizione;
    data["area"] = this.area;
    data["type"] = this.type;
   /* if(this.properties != null)
      data["properties"] = this.properties?.toJson();*/
    if(this.geometry != null)
      data["geometry"] = this.geometry?.toJson();
    if(this.interessi != null)
      data["interessi"] = this.interessi?.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Interessi {
  String? id;
  String? name;

  Interessi({this.id, this.name});

  Interessi.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    return data;
  }
}

class Geometry {
  List<dynamic>? coordinates;
  String? type;

  Geometry({this.coordinates, this.type});

  Geometry.fromJson(Map<String, dynamic> json) {
    this.coordinates = json["coordinates"]==null ? null : json["coordinates"][0];
    this.type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.coordinates != null)
      data["coordinates"] = this.coordinates;
    data["type"] = this.type;
    return data;
  }
}

class Properties {
  Properties();

  Properties.fromJson(Map<String, dynamic> json) {

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }
}




class Map1 extends StatefulWidget {
  const Map1({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map1> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Padiglioni>>(
      future: fetchPadiglioni(http.Client()),
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
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
  List<Padiglioni> data;

  var points = <latLng.LatLng> [
     //latLng.LatLng(41.1355051, 16.8378362),
     //latLng.LatLng(41.1354901, 16.8384183),
     //latLng.LatLng(41.1346975, 16.8383944),
     //latLng.LatLng(41.1347136,16.837804),
     //latLng.LatLng(41.1355051, 16.8378362)
   ];

  @override
  Widget build(BuildContext context) {
   // var points;
    //List points  = <latLng.LatLng>[];
    /*  for(int i = 0; i < data.length; i++){
      for(int j = 0; j < data[i].geometry!.coordinates!.length; j++){
        var points = <latLng.LatLng> [ latLng.LatLng(data[i].geometry!.coordinates![j][0], data[i].geometry!.coordinates![j][0]) ];
        print(points);
        //print(data[i].geometry!.coordinates![j][0]);
      }
    }*/
    //print(data[1].geometry!.coordinates![3]);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map'),
          backgroundColor: Colors.black,
        ),
        body: FlutterMap(
          options: MapOptions(
            center: latLng.LatLng(41.136423, 16.838197),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://api.mapbox.com/styles/v1/patierno1/ckwatqb0b6g5115t6scccgw0q/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicGF0aWVybm8xIiwiYSI6ImNrdWZhb3EyYjBnajkydnFlMmdnYXVqenEifQ.CF0aaxP46ecopgUdTrDmpA",
              additionalOptions: {
                'accessToken': 'pk.eyJ1IjoicGF0aWVybm8xIiwiYSI6ImNrdWZhb3EyYjBnajkydnFlMmdnYXVqenEifQ.CF0aaxP46ecopgUdTrDmpA',
                'id': 'mapbox.mapbox-streets-v8'
              },
              attributionBuilder: (_) {
                return const Text("© OpenStreetMap contributors");
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: latLng.LatLng(41.136423, 16.838197),
                  builder: (ctx) =>
                  const FlutterLogo(),
                ),
              ],
            ),
            PolylineLayerOptions(
                polylines: [ Polyline(
                    points: points,
                    strokeWidth: 1.0,
                    color: Colors.white
                )
                ]
            )
          ],
        )
    );
  }


}

