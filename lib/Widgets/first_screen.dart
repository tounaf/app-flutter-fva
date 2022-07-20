import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Widgets/vola.dart';
import 'package:labs_flutter_pulse/Widgets/vola_list.dart';
import './second_screen.dart';
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Vola()),
                    );
                  },
                  child: Text('VOLA')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VolaList()),
                    );
                  },
                  child: Text('ASA')),
            ],
          )
      ),
    );
  }
}