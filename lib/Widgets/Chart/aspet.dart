import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Models/groupe_model.dart';
import 'package:labs_flutter_pulse/Services/groupe_http_service.dart';
import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  final GroupeHttpService groupeHttpService = GroupeHttpService();
  late Future <List<Groupe>> futureData;

  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    futureData = groupeHttpService.fetchGroupe();
  }

  FutureBuilder<List<Groupe>> buildFutureBuilder() {
    return FutureBuilder <List<Groupe>>(
      future: futureData,
      builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) {
      return snapshot.hasData
          ? ListView.builder(
        // render the list
        itemCount: snapshot.data!.length,
        itemBuilder: (BuildContext context, index) => Card(
          margin: const EdgeInsets.all(10),
          // render list item
          child: 
          Indicator(
                  color: Color(0xff0293ee),
                  text: snapshot.data![index].name.toString(),
                  isSquare: true,
                ),
        ),
      )
          : const Center(
        // render the loading indicator
        child: CircularProgressIndicator(),
      );
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('charg'),),
      body: AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ),
            ),
            

            Column(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 4,
                ),
                Expanded(child: buildFutureBuilder()),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}