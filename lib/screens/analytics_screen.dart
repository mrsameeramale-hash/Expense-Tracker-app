import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kharchabook/Data/database_helper.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List data = [];

  void load() async {
    data = await DBHelper.getAll();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analytics")),
      body: Center(
        child: SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              barGroups: data.asMap().entries.map((e) {
                return BarChartGroupData(
                  x: e.key,
                  barRods: [
                    BarChartRodData(toY: e.value['amount']),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}