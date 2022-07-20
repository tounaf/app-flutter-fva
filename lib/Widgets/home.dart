import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Widgets/first_screen.dart';
import 'package:labs_flutter_pulse/Widgets/vola_list.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.money)),
                Tab(icon: Icon(Icons.local_activity)),
              ],
            ),
            title: const Text('Fva'),
          ),
          body: TabBarView(
            children: [
              FirstScreen(),
              VolaList(),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}