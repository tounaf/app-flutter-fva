import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:labs_flutter_pulse/Models/entry_model.dart';
import 'package:labs_flutter_pulse/Services/entry_http_service.dart';
import 'package:labs_flutter_pulse/Widgets/vola_new.dart';

class EntryList extends StatefulWidget {
  EntryList({super.key});

  @override
  _EntryListState createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  final EntryHttpService entryHttpService = EntryHttpService();
  late Future <List<Entries>> futureData;
  final _biggerFont = const TextStyle(fontSize: 18); // NEW

  @override
  void initState() {
    super.initState();
    futureData = entryHttpService.fetchEntry();
  }

  FutureBuilder<List<Entries>> buildFutureBuilder() {
    return FutureBuilder <List<Entries>>(
      future: futureData,
      builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) {
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
        body: Column(
          children: [
            Card(child: SizedBox(
              width: 400,
              height: 100,
              child: Center(child: const Text('Somme'),),
            ),
                color: Colors.yellow[300],
                shadowColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Colors.greenAccent

                  )
                )),
            Expanded(child: buildFutureBuilder())
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const VolaForm()),
            );
          },
        ),
      ),
    );
  }
}