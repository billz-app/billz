import 'package:billz/bar-graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  MyBarGraph(
      {required this.maxY,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thurAmount,
      required this.friAmount,
      required this.satAmount});

  @override
  Widget build(BuildContext context) {
    // initialize bar data
    BarData myBarData = BarData(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thurAmount: thurAmount,
        friAmount: friAmount,
        satAmount: satAmount);
    myBarData.initializeBarData();

    return BarChart(BarChartData(
        maxY: 100,
        minY: 0,
        titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: getBottomTiles))),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: Colors.grey[800],
                      width: 25,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true, toY: maxY, color: Colors.grey[200]))
                ]))
            .toList()));
  }
}

// bottom tiles has the weekday's name
Widget getBottomTiles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'Su',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'M',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'Tu',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'W',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'Th',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'F',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'Sa',
        style: style,
      );
      break;
    default:
      text = const Text(
        '',
        style: style,
      );
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
