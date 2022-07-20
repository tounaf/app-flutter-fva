import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Modeles/vola_model.dart';
import 'package:http/http.dart' as http;

Future<List<Vola>> fetchVola() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/user/list'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    // print('=========');
    // print(jsonResponse);
    return jsonResponse.map((data) => Vola.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class VolaList extends StatefulWidget {
  VolaList({super.key});

  @override
  _VolaListState createState() => _VolaListState();
}

class _VolaListState extends State<VolaList> {
  late Future <List<Vola>> futureData;
  final _biggerFont = const TextStyle(fontSize: 18); // NEW

  @override
  void initState() {
    super.initState();
    futureData = fetchVola();
  }

  FutureBuilder<List<Vola>> buildFutureBuilder() {
    return FutureBuilder <List<Vola>>(
      future: futureData,
      builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) {
        print('============== ');
      print(snapshot);
      return snapshot.hasData
          ? ListView.builder(
        // render the list
        itemCount: snapshot.data!.length,
        itemBuilder: (BuildContext context, index) => Card(
          margin: const EdgeInsets.all(10),
          // render list item
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            title: Text(snapshot.data![index].montant.toString()),
            subtitle: Text(snapshot.data![index].description),
          ),
        ),
      )
          : const Center(
        // render the loading indicator
        child: CircularProgressIndicator(),
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API and ListView Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter ListView'),
        ),
        body: buildFutureBuilder()
      ),
    );
  }
}