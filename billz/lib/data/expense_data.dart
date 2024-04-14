import 'package:billz/data/hive_db.dart';
import 'package:billz/datetime/date_time_helper.dart';
import 'package:billz/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  //listing all expenses
  List<ExpenseItem> overallExpenseList = [];

  //get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  // display of data
  final db = HiveDB();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  //adding new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //removing expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //weekday management (bar-graph)
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      //weekday returns int (7 for sunday)
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  //get date
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //get today's date
    DateTime today = DateTime.now();

    //finding nearest sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  // conversion of data to hold amount spent on a daily basis
  Map<String, double> calcDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};
    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
