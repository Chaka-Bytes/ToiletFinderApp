import 'package:flutter/material.dart';
import 'package:toilet_app/pages/map_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var data = [];
  LocationData? locationData = null;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url = Uri.parse(
        'http://10.0.2.2:8000/toilets'); // Update the URL with your backend endpoint
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        isLoading = false;
      });
    }
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: Center(
            child: Text('Please wait...'),
          ),
        ),
      );
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MapPage(data: data),
      );
    }
  }
}
