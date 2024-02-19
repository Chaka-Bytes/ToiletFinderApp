import 'package:flutter/material.dart';
import 'package:toilet_app/pages/map_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _responseText = ''; // Variable to hold the response from the server

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url = Uri.parse(
        'http://10.0.2.2:8000/toilets'); // Update the URL with your backend endpoint
    var response = await http.get(url);

    //print the status code of the response in terminal
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _responseText =
            data.toString(); // Update the responseText with the data received
      });
    } else {
      setState(() {
        _responseText =
            'Failed to load data'; // Update responseText with an error message
      });
    }
    print(_responseText);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MapPage(),
    );
  }
}
