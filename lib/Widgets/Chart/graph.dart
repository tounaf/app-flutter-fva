import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> availableColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.cyan,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.deepPurple,
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, int>> getValues() async {
    await Future.delayed(Duration(seconds: 3));
    return {'A': 12, 'B': 32, 'C': 44};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(60),
          child: FutureBuilder<Map<String, int>>(
            future: getValues(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, int> rawData = snapshot.data!;
                List<PieChartSectionData> pieSectionsData = _mapToPieSectionsData(rawData);
                return PieChart(
                  PieChartData(sections: pieSectionsData),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _mapToPieSectionsData(Map<String, int> rawData) {
    return rawData.entries.map((entry) {
      String title = entry.key;
      int value = entry.value;
      return PieChartSectionData(
        value: value.toDouble(),
        title: '$title: $value',
        color: availableColors[value % availableColors.length],
      );
    }).toList();
  }
}