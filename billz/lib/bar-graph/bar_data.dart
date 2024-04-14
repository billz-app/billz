import 'package:billz/bar-graph/single_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData(
      {required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thurAmount,
      required this.friAmount,
      required this.satAmount});

  List<SingleBar> barData = [];

  // init bar data
  void initializeBarData() {
    barData = [
      SingleBar(x: 0, y: sunAmount),
      SingleBar(x: 1, y: monAmount),
      SingleBar(x: 2, y: tueAmount),
      SingleBar(x: 3, y: wedAmount),
      SingleBar(x: 4, y: thurAmount),
      SingleBar(x: 5, y: friAmount),
      SingleBar(x: 6, y: satAmount)
    ];
  }
}
