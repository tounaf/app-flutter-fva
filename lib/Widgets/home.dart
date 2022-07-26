import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Widgets/first_screen.dart';
import 'package:labs_flutter_pulse/Widgets/tools/app_bar.dart';
import 'package:labs_flutter_pulse/Widgets/vola_list.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: AppBarFva(),
      ),
    );
  }
}