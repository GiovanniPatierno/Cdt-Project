import 'dart:convert';
import 'dart:async';
import 'package:cdt/dettagli_padiglione.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Padiglioni11 extends StatefulWidget {
  const Padiglioni11({Key? key}) : super(key: key);

  @override
  _PadiglioniState createState() => _PadiglioniState();
}

class _PadiglioniState extends State<Padiglioni11> {
  TextEditingController searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Center( child: Text('Padiglioni')),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          /*Container(
            padding: const EdgeInsets.only(top:8.00,left:15.00, right: 15.00, bottom: 3.00),
            child:
          Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)),
              child:
              FutureBuilder<List<Photo>>(
              future: fetchPhotos(http.Client()),
               builder: (context, snapshot) {
              return TextField(
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      Photolist2(photos: snapshot.data!).filter();
                      setState(() {});
                    },
                    child: const Icon(Icons.search)),
                  contentPadding: EdgeInsets.all(12.00),
                  labelText: "Search...",
                  border: InputBorder.none));})
              ),
          ),*/
          //Text("Result: " + filter()),
          Expanded(
            child:
              FutureBuilder<List<Photo>>(
                future: fetchPhotos(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred!'),
                    );
                  } else if (snapshot.hasData) {
                    return Photolist2(photos: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

        ],
      )

    );
  }
}

class Photolist2 extends StatelessWidget {
  Photolist2({Key? key, required this.photos}) : super(key: key);
  bool isChecked = false;
  final List<Photo> photos;


 /* String filter(){
    if (_PadiglioniState().searchController.text == "") return "null";
    String result = "";
    int i = 0;
    for (i; i<27; i++){
      if(photos[i].nome.contains(_PadiglioniState().searchController.text)){
        result = result + photos[i].nome +',';
      }
    }
    if (result == '') return 'null';
    return Text(photos[i].nome).toString();
  }*/

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          padding: EdgeInsets.only(top:8.00,left:10.00, right: 10.00),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(8.00),
                child:
             InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dettagli(index: index, data:photos)),
                );
              },
              child:
                Card(
                child:
                Column(
                children: <Widget> [
                  Center(
                      child:
                      ListTile(
                        title: Text(photos[index].nome, overflow: TextOverflow.ellipsis,maxLines: 2),
                      )
                  ),
                    Image.asset('assets/images/padiglione-francia-expo.jpg'),
                  ]
                )
              )
              )
              );
            }

    );
  }
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://192.168.1.241:9250/api/padiglioni'));
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, utf8.decode(response.bodyBytes));
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String id;
  final String nome;
  bool check = false;
  //final String descrizione;
  final String stand;
  Color color = Colors.black38;
  //final String immagine;


   Photo( {
    //required this.immagine,
    //required this.descrizione,
    required this.stand,
    required this.id,
    required this.nome,
    required this.check,
     required this.color
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      nome: json['nome'] as String,
      stand: json['stand'] as String,
      //immagine: json['immagine'] as String,
      //descrizione: json['descrizione'] as String,
      check: false,
        color : Colors.black38
    );
  }

}
