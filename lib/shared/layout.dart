import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Widgets/entry_list.dart';
import 'package:labs_flutter_pulse/Widgets/first_screen.dart';
import 'package:labs_flutter_pulse/Widgets/groupe_list.dart';
import 'package:labs_flutter_pulse/Widgets/user_login.dart';
import 'package:labs_flutter_pulse/Widgets/vola_list.dart';
class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Parametrage'),
            ),
            ListTile(
              title: const Text('Config'),
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title'),
                  content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('A propos'),
              onTap: () {

                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        shadowColor: Colors.red,
        elevation: 15,
        title: const Text('Fva'),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => EntryList()),
            );
          }, icon: Icon(Icons.money)),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => GroupeList()),
              );
            },
            icon: Icon(Icons.group_add_outlined),
          ),
          IconButton(onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserLoginForm()),
            );
          }, icon: Icon(Icons.login)),
          Icon(Icons.more_vert)
        ],
        backgroundColor: Colors.pink.shade400,
      ),
    );
  }
}

