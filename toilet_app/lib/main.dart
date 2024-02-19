import 'package:flutter/material.dart';
import 'package:toilet_app/pages/map_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _responseText = ''; // Variable to hold the response from the server

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> fetchData() async {
    var url = Uri.parse(
        'http://localhost:8000/toilets'); // Update the URL with your backend endpoint
    var response = await http.get(url);

    print(response.statusCode); // Print the response status code

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
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Response from Server:', // Display a label for the response
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _responseText, // Display the response text
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
