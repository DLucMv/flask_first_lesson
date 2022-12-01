import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = '';
  dynamic data;
  String output = 'Saida inicial';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASCII'),
      ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              data = await fetchData(url);
              var decoded = jsonDecode(data);
              setState(() {
                output = decoded['output'];
              });
            },
            label: const Text('Testar api')),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(output, style: const TextStyle(fontSize: 30.0),),
              TextField(
                onChanged: (value) {
                  url ='http://10.0.2.2:5000/api?query=$value';
                },
              ),
            ],
          ),
        ));
  }

  fetchData(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }
}
