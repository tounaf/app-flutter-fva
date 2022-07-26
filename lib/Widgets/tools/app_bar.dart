import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Widgets/first_screen.dart';
import 'package:labs_flutter_pulse/Widgets/vola_list.dart';
class AppBarFva extends StatelessWidget {
  const AppBarFva({Key? key}) : super(key: key);

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
        // flexibleSpace: Container(clipBehavior: Clip.hardEdge,),
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(70.0),
        //         bottomRight: Radius.circular(70.0)
        //     )
        // ),
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.money)),
            Tab(icon: Icon(Icons.people)),
          ],
        ),
        title: const Text('Fva'),
        actions: const [
          Icon(Icons.favorite),
          Icon(Icons.more_vert)
        ],
        backgroundColor: Colors.pink.shade400,
      ),
      body: TabBarView(
        children: [
          const FirstScreen(),
          VolaList(),
          const Icon(Icons.directions_bike),
        ],
      ),
    );
  }
}

