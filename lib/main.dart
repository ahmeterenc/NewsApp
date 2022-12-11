import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // API URL
  final String apiUrl = "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=f28908e701a3466e8efb5ed6ca0b64fb";
  List<dynamic> data = [];

  // JSON verileri burada saklanacak

  @override
  void initState() {
    super.initState();

    // API'den verileri getir
    this.getJSONData();
  }

  Future<String> getJSONData() async {
    var response = await http.get(
      // API adresini buraya yazın
       Uri.parse(apiUrl),
        headers: {
          "Accept": "application/json"
        }
    );
    Map<String, dynamic> map = new Map<String, dynamic>.from(json.decode(response.body));
    data = map["articles"];
    print(data[0]["title"]);
    setState(() {
      // Gelen verileri data değişkenine ata
      var dataConvertedToJSON = json.decode(response.body);
      data = dataConvertedToJSON;
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON Örneği"),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        data[index]["title"],
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
