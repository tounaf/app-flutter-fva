//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 hubgit
import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Widgets/vola.dart';
import 'package:labs_flutter_pulse/Widgets/vola_list.dart';
import 'package:labs_flutter_pulse/Widgets/vola_new.dart';
import './Widgets/second_screen.dart';
import './Widgets/first_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const SecondScreen(),
        '/vola': (context) => const Vola(),
        '/vola-new': (context) => const VolaForm(),
        '/vola-list': (context) => VolaList(),
      },
    ),
  );
}
