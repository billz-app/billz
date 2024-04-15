import 'package:billz/components/expense_summary.dart';
import 'package:billz/components/expense_tile.dart';
import 'package:billz/data/expense_data.dart';
import 'package:billz/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // prep data
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // add new expense
  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add New Expense!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // expense name
                  TextField(
                    controller: newExpenseNameController,
                    decoration:
                        const InputDecoration(hintText: 'Enter your name'),
                  ),
                  // expense amount
                  TextField(
                      controller: newExpenseAmountController,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(hintText: 'Enter the amount'))
                ],
              ),
              actions: [
                //save btn
                MaterialButton(
                  onPressed: save,
                  child: const Text('Save'),
                ),

                // cancel btn
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("Cancel"),
                )
              ],
            ));
  }

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // save function
  void save() {
    // have to save only when all the fields are filled
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text.trim(),
          amount: newExpenseAmountController.text.trim(),
          dateTime: DateTime.now());

      // adding the new expense
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }

    Navigator.pop(context);
    clear();
  }

  // cancel function
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // clear controllers
  void clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            // expense summary (bar-graph)
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),
            const SizedBox(
              height: 20,
            ),
            // expense list
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                      name: value.getAllExpenseList()[index].name,
                      amount: value.getAllExpenseList()[index].amount,
                      dateTime: value.getAllExpenseList()[index].dateTime,
                      deleteTapped: (p0) =>
                          deleteExpense(value.getAllExpenseList()[index]),
                    ))
          ],
        ),
      ),
    );
  }
}
