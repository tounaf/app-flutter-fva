import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Models/groupe_model.dart';
import 'package:http/http.dart' as http;
import 'package:labs_flutter_pulse/Services/groupe_http_service.dart';
import 'package:labs_flutter_pulse/Widgets/entry_new.dart';
import 'package:labs_flutter_pulse/Widgets/groupe_detail.dart';
import 'package:labs_flutter_pulse/Widgets/home.dart';
import 'package:labs_flutter_pulse/Widgets/member_list.dart';
import 'package:labs_flutter_pulse/Widgets/user_new.dart';
import 'package:labs_flutter_pulse/Widgets/vola_new.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class GroupeList extends StatefulWidget {
  GroupeList({super.key});

  @override
  _GroupeListState createState() => _GroupeListState();
}

class _GroupeListState extends State<GroupeList> {
  final GroupeHttpService groupeHttpService = GroupeHttpService();
  late Future <List<Groupe>> futureData;
  final _biggerFont = const TextStyle(fontSize: 18); // NEW

  @override
  void initState() {
    super.initState();
    futureData = groupeHttpService.fetchGroupe();
  }

  FutureBuilder<List<Groupe>> buildFutureBuilder() {
    return FutureBuilder <List<Groupe>>(
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: const EdgeInsets.only(right: 12.0),
              decoration: const BoxDecoration(
                  border:  Border(
                      right: BorderSide(width: 1.0, color: Colors.white24))),
              child: const Icon(Icons.autorenew, color: Colors.blue),
            ),
            // contentPadding: const EdgeInsets.all(10),
            title: Text(snapshot.data![index].name.toString()),
            subtitle: Row(
              children: const <Widget>[
                Icon(Icons.linear_scale, color: Colors.yellowAccent),
                Text(" Intermediate", style: TextStyle(color: Colors.white))
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GroupeDetail(groupe: snapshot.data![index])),
                );
              },
              icon: const Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
            )
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
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _page = 0;

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
        ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.monetization_on, size: 30),
          Icon(Icons.perm_identity, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
          if(index == 0) {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          }
          if(index == 1) {
            // Navigator.push(context,
            //   MaterialPageRoute(builder: (context) => const EntryForm(member: ,)),
            // );
          }

          if(index == 2) {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserNewForm()),
            );
          }
        },
        letIndexChange: (index) => true,
      ),

      );
  }
}