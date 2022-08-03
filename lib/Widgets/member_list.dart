import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Models/groupe_model.dart';
import 'package:http/http.dart' as http;
import 'package:labs_flutter_pulse/Models/user_model.dart';
import 'package:labs_flutter_pulse/Services/groupe_http_service.dart';
import 'package:labs_flutter_pulse/Services/member_http_service.dart';
import 'package:labs_flutter_pulse/Widgets/vola_new.dart';

class MemberList extends StatefulWidget {
  MemberList({super.key});

  @override
  _MemberListState createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  final MemberHttpService memberHttpService = MemberHttpService();
  late Future <List<Member>> futureData;
  final _biggerFont = const TextStyle(fontSize: 18); // NEW

  @override
  void initState() {
    super.initState();
    futureData = memberHttpService.fetchGroupe();
  }

  FutureBuilder<List<Member>> buildFutureBuilder() {
    return FutureBuilder <List<Member>>(
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
            title: Text(snapshot.data![index].username.toString()),
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
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.red,
          elevation: 15,
          title: const Text('Liste groupe'),
          backgroundColor: Colors.pink.shade400,
        ),
        body: Column(
          children: [
            Expanded(child: buildFutureBuilder())
          ],
        )

      );
  }
}