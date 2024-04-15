import 'package:billz/data/expense_data.dart';
import 'package:billz/pages/intro-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() async {
  // init hive (db)
  await Hive.initFlutter();

  // open a hive box
  await Hive.openBox("expense_db");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/home': (BuildContext context) => const HomePage()
          },
          debugShowCheckedModeBanner: false,
          home: const IntroScreen()),
    );
  }
}
