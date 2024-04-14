import 'package:billz/bar-graph/bar_graph.dart';
import 'package:billz/data/expense_data.dart';
import 'package:billz/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  // maxY calculation for bar adjustment
  double calcMax(
      ExpenseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
    double? max = 150;
    List<double> values = [
      value.calcDailyExpenseSummary()[sunday] ?? 0,
      value.calcDailyExpenseSummary()[monday] ?? 0,
      value.calcDailyExpenseSummary()[tuesday] ?? 0,
      value.calcDailyExpenseSummary()[wednesday] ?? 0,
      value.calcDailyExpenseSummary()[thursday] ?? 0,
      value.calcDailyExpenseSummary()[friday] ?? 0,
      value.calcDailyExpenseSummary()[saturday] ?? 0
    ];

    // sort in ascending order
    values.sort();
    // get the largest from -1 index
    max = values.last * 1.1;

    if (max > 150) {
      max = 150;
    }

    return max == 0
        ? 100
        : max; // if max is null then default of 150 will be taken
  }

  // weekly total
  String calcWeekTotal(
      ExpenseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
    List<double> values = [
      value.calcDailyExpenseSummary()[sunday] ?? 0,
      value.calcDailyExpenseSummary()[monday] ?? 0,
      value.calcDailyExpenseSummary()[tuesday] ?? 0,
      value.calcDailyExpenseSummary()[wednesday] ?? 0,
      value.calcDailyExpenseSummary()[thursday] ?? 0,
      value.calcDailyExpenseSummary()[friday] ?? 0,
      value.calcDailyExpenseSummary()[saturday] ?? 0
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of week
    String sunday = convertDateTimeToString(startOfWeek.add(Duration(days: 0)));
    String monday = convertDateTimeToString(startOfWeek.add(Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(Duration(days: 4)));
    String friday = convertDateTimeToString(startOfWeek.add(Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(Duration(days: 6)));

    ExpenseData value = Provider.of<ExpenseData>(context);

    // Calculate weekly total
    String weeklyTotal = calcWeekTotal(
        value, sunday, monday, tuesday, wednesday, thursday, friday, saturday);

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          // week total
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text(
                  'Weekly total: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('\₹$weeklyTotal')
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),

          // bar graph
          SizedBox(
            height: 150,
            child: MyBarGraph(
                maxY: calcMax(value, sunday, monday, tuesday, wednesday,
                    thursday, friday, saturday),
                sunAmount: value.calcDailyExpenseSummary()[sunday] ?? 0,
                monAmount: value.calcDailyExpenseSummary()[monday] ?? 0,
                tueAmount: value.calcDailyExpenseSummary()[tuesday] ?? 0,
                wedAmount: value.calcDailyExpenseSummary()[wednesday] ?? 0,
                thurAmount: value.calcDailyExpenseSummary()[thursday] ?? 0,
                friAmount: value.calcDailyExpenseSummary()[friday] ?? 0,
                satAmount: value.calcDailyExpenseSummary()[saturday] ?? 0),
          ),
        ],
      ),
    );
  }
}
