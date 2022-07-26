import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Widgets/user_login.dart';
import 'package:labs_flutter_pulse/Widgets/vola.dart';
import 'package:labs_flutter_pulse/Widgets/vola_list.dart';
import 'package:labs_flutter_pulse/Widgets/vola_new.dart';
import './second_screen.dart';
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const VolaForm()),
                    );
                  },
                  child: Text('VOLA')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserLoginForm()),
                    );
                  },
                  child: Text('LOGIN')),
            ],
          )
      ),
    );
  }
}