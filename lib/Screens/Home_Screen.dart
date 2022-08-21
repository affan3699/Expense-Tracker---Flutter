// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:todoapp/Screens/Add_Screen.dart';
import 'package:todoapp/globalVar.dart' as g;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  String _title,
      _description,
      _date,
      _time,
      _amount,
      _expense; // Private Variables

  HomeScreen(this._title, this._description, this._date, this._time,
      this._amount, this._expense); // Constructor

  @override
  State<HomeScreen> createState() => _HomeScreeneState();
}

class _HomeScreeneState extends State<HomeScreen> {
  NumberFormat numberFormat = NumberFormat.decimalPattern(
      'en_us'); // Adding commas digit grouping to large number

  @override
  void initState() {
    super.initState();

    setState(() {
      if (widget._expense == 'Expense') {
        g.dataMap['Expense'] = g.expense++;
      } else if (widget._expense == 'Income') {
        g.dataMap['Income'] = g.income++;
      }

      g.dataMap['Saving'] = g.income - g.expense;
    });

    g.entries.add({
      'title': widget._title,
      'description': widget._description,
      'date': widget._date,
      'time': widget._time,
      'amount': widget._amount,
      'expense': widget._expense,
      'count': g.count++
    });

    g.entries.sort(
        (a, b) => b["count"].compareTo(a["count"])); // Sort by Latest Entry
    print(g.entries);
  }

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
                dataMap: g.dataMap,
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
                itemCount: g.entries.length,
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
                          child: Icon(
                              g.entries[i]['expense'] == 'Expense'
                                  ? Icons.arrow_back
                                  : Icons.arrow_forward,
                              color: g.entries[i]['expense'] == 'Expense'
                                  ? Colors.red
                                  : Colors.green,
                              size: 27.0)),
                      trailing: Container(
                        margin: EdgeInsets.only(top: 13),
                        child: Text(
                          numberFormat
                              .format(int.parse(g.entries[i]['amount']))
                              .toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(g.entries[i]['title'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          SizedBox(height: 5.0),
                          Text(
                            g.entries[i]['description'],
                            maxLines: 2,
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            '${g.entries[i]['date']} at ${g.entries[i]['time']}',
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
