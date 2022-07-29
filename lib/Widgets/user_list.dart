import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Models/user_model.dart';
import 'package:labs_flutter_pulse/Models/vola_model.dart';
import 'package:http/http.dart' as http;
import 'package:labs_flutter_pulse/Services/user_http_service.dart';
import 'package:labs_flutter_pulse/Services/vola_http_service.dart';
import 'package:labs_flutter_pulse/Widgets/vola_new.dart';

class UserList extends StatefulWidget {
  UserList({super.key});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final UserHttpService userHttpService = UserHttpService();
  late Future <List<User>> futureData;
  final _biggerFont = const TextStyle(fontSize: 18); // NEW

  @override
  void initState() {
    super.initState();
    futureData = userHttpService.findAll();
  }

  FutureBuilder<List<User>> buildFutureBuilder() {
    return FutureBuilder <List<User>>(
      future: futureData,
      builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) {
      return snapshot.hasData
          ? ListView.builder(
        // render the list
        itemCount: snapshot.data!.length,
        itemBuilder: (BuildContext context, index) => Card(
          margin: const EdgeInsets.all(10),
          // render list item
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            title: Text(snapshot.data![index].firstname.toString()),
            subtitle: Text(snapshot.data![index].lastname.toString()),
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
          title: const Text('Users'),
        ),
        body: Column(
          children: [
            Card(child: SizedBox(
              width: 400,
              height: 100,
              child: Center(child: const Text('Users'),),
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
      );
  }
}