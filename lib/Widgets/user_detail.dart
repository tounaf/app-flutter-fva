import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Widgets/entry_new.dart';
import 'package:labs_flutter_pulse/Widgets/member_list.dart';
class MemberDetail extends StatelessWidget {
  const MemberDetail({super.key, required this.member});
  final member;

  buildFutureBuilder() {
    var entries = member['entries'];
    print('----entries');
    print(entries);
    return ListView.builder(
      // render the list
      itemCount: entries.length,
      itemBuilder: (BuildContext context, index) {
        String firstname = entries[index]['description'].toString();
        String date = entries[index]['date'].toString();
        return Card(
          margin: const EdgeInsets.all(10),
          // render list item

            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: const EdgeInsets.only(right: 12.0),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24))),
                child: const Icon(Icons.autorenew, color: Colors.blue),
              ),
              // contentPaddin
              title: Text(entries[index]['amount'].toString()),
              subtitle: Row(
                children: <Widget>[
                  // Icon(Icons.linear_scale, color: Colors.yellowAccent),
                  Text("$firstname | $date", style: const TextStyle(color: Colors.blueAccent))
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MemberList()),
                  );
                },
                icon: Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
              )
          ),
        );
      } ,
    );
  }

  @override
  Widget build(BuildContext context) {
    var name = member['firstname'];
    var child = member['entries'].length > 0 ? buildFutureBuilder() : const Text('Aucune cotisation payée');
  
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.red,
          elevation: 15,
          title: Text('$name'),
          backgroundColor: Colors.pink.shade400,
        ),
      body: Column(
        children: [
            Expanded(child: child)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EntryForm()),
          );
        },
      ),
    );
  }
}
