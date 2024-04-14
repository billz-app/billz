import 'package:billz/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDB {
  // ref the box (main.dart)
  final myBox = Hive.box("expense_db");

  // write data
  void saveData(List<ExpenseItem> allExpense) {
    // conversion of obj to primitive items
    List<List<dynamic>> allExpensesFormat = [];
    for (var expense in allExpense) {
      // converting list to storable types (strs, date)
      List<dynamic> expensesFormat = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      allExpensesFormat.add(expensesFormat);
    }
    myBox.put("EXPENSES", allExpensesFormat);
  }

  // read the data
  List<ExpenseItem> readData() {
    // reversal of writing data
    List savedExpenses = myBox.get("EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      // grab individual expense data
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      // create expense item obj
      ExpenseItem expense =
          ExpenseItem(name: name, amount: amount, dateTime: dateTime);
      // add expense to overall list
      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
