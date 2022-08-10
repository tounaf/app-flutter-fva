import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Models/groupe_model.dart';
import 'package:labs_flutter_pulse/Widgets/member_list.dart';
import 'package:labs_flutter_pulse/Widgets/user_detail.dart';
class GroupeDetail extends StatelessWidget {
  const GroupeDetail({super.key, required this.groupe});
  final Groupe groupe;

  buildFutureBuilder() {
    var members = groupe.members;
    print('----mbers');
    print(members);
    return ListView.builder(
      // render the list
      itemCount: members.length,
      itemBuilder: (BuildContext context, index) {
        String firstname = members[index]['firstname'].toString();
        return Card(
          margin: const EdgeInsets.all(10),
          // render list item

            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.white24))),
                child: Icon(Icons.autorenew, color: Colors.blue),
              ),
              // contentPaddin
              title: Text(members[index]['username'].toString()),
              subtitle: Row(
                children: <Widget>[
                  // Icon(Icons.linear_scale, color: Colors.yellowAccent),
                  Text("$firstname", style: TextStyle(color: Colors.blueAccent))
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  print('-----------------members');
                  print(members[index]);
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MemberDetail(member: members[index])),
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
    var groupeName = groupe.name;
    var nbrMembre = groupe.members.length;
    var child = nbrMembre > 0 ? buildFutureBuilder() : const Text('Aucun utilisateur');
  
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.red,
          elevation: 15,
          title: Text('$groupeName: $nbrMembre membre(s)'),
          backgroundColor: Colors.pink.shade400,
        ),
      body: Column(
        children: [
            Expanded(child: child)
        ],
      ),
    );
  }
}
