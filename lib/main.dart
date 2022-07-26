//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 hubgit
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Widgets/home.dart';
import 'package:labs_flutter_pulse/Widgets/user_login.dart';
import 'package:labs_flutter_pulse/Widgets/vola.dart';
import 'package:labs_flutter_pulse/Widgets/vola_list.dart';
import 'package:labs_flutter_pulse/Widgets/vola_new.dart';
import './Widgets/second_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
      return super.createHttpClient(context)
        ..badCertificateCallback = (X509Certificate cert, String host, int por) => true;
  }
}
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = PostHttpOverrides();
  await dotenv.load(fileName: '.env');

  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const UserLoginForm(),
        '/home': (context) => const Home(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const SecondScreen(),
        '/vola': (context) => const Vola(),
        '/vola-new': (context) => const VolaForm(),
        '/vola-list': (context) => VolaList(),
      },
    ),
  );
}
