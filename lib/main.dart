// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:todoapp/Screens/Add_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Add_Screen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreeneState();
}

class _HomeScreeneState extends State<HomeScreen> {
  Map<String, double> dataMap = {
    "Expense": 5,
    "Incoming": 3,
    "Saving": 2,
  };

  Map entries = Map();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1, // 10 percent
            child: Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.all(15.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Add_Screen()));
                },
                icon: const Icon(
                  Icons.add,
                  size: 24.0,
                ),
                label: const Text('Add'), // <-- Text
              ),
            ),
          ),
          Expanded(
            flex: 2, // 20 percent
            child: Container(
              child: PieChart(
                dataMap: dataMap,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 60,
                chartRadius: MediaQuery.of(context).size.width / 2.8,
                colorList: [Colors.red, Colors.green, Colors.grey],
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 12,
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: false,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7, // 70 percent
            child: Container(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(15.0),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(2, 2),
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child: ListTile(
                      onTap: () {},
                      leading: Container(
                          margin: EdgeInsets.only(top: 13.5),
                          child: Icon(Icons.arrow_back,
                              color: Colors.red, size: 27.0)),
                      trailing: Container(
                        margin: EdgeInsets.only(top: 13.5),
                        child: Text(
                          "2000",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text("Loan Payment",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          SizedBox(height: 5.0),
                          Text(
                            "Loan paid Affan that he give me 2 months ago for my bike",
                            maxLines: 2,
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            '25 July, 2022 at 3:00 PM',
                            style: TextStyle(fontSize: 12.0),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
