import 'package:flutter/material.dart';
import 'package:venom/components/fuel_prices_database.dart';

class ResultsScreen extends StatefulWidget {
  final String timeTraveled;
  final double gasLevel1;
  final double gasLevel2;
  final double odometer1;
  final double odometer2;

  const ResultsScreen(
      {Key? key,
      required this.timeTraveled,
      required this.gasLevel1,
      required this.gasLevel2,
      required this.odometer1,
      required this.odometer2})
      : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  double _distanceTravelled = 0.0;
  double gasUsed = 0.0;
  double gasPrice = 0.0;
  double gasPercentage = 0.0;

  void calculateDistanceTravelled() {
    setState(() {
      _distanceTravelled = widget.odometer2 - widget.odometer1;
    });
  }

  void calculateGasUsed() {
    const fuelCapacity = 10.0; // Replace with actual fuel capacity
    setState(() {
      gasUsed = (widget.gasLevel1 - widget.gasLevel2) * fuelCapacity;
    });
  }

  Future<void> calculateGasPrice() async {
    final db = await DatabaseHelper.instance.database;
    final fuelPrices = await db.query(
      'fuel_prices',
      orderBy: 'id DESC',
      limit: 1,
    );
    final fuelPrice = fuelPrices[0]['price'] as double;
    setState(() {
      gasPrice = gasUsed * fuelPrice;
    });
  }

  void calculateGasPercentage() {
    const fuelCapacity = 10.0; // Replace with actual fuel capacity
    setState(() {
      gasUsed = (widget.gasLevel1 - widget.gasLevel2) * fuelCapacity;
      gasPercentage = (gasUsed / fuelCapacity) * 100.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Results"),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 25,
          ),
          Card(
            child: SizedBox(
              width: 150,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Time traveled: ${widget.timeTraveled}"),
                  Text('Distance traveled: $_distanceTravelled km'),
                  Text("Gas used: $gasUsed Gallons"),
                  Text("Gas percentage: $gasPercentage%"),
                  Text('Money spent: $gasPrice'),
                  Text("Debug Gas Level 1: ${widget.gasLevel1}"),
                  Text("Debug Gas Level 2: ${widget.gasLevel2}"),
                  Text("Debug Odometer 1: ${widget.odometer1}"),
                  Text("Debug Odometer 2: ${widget.odometer2}"),
                ],
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                calculateDistanceTravelled();
                calculateGasUsed();
                await calculateGasPrice();
                calculateGasPercentage();
              },
              child: const Text("Analyze ride"),
            ),
          )
        ],
      ),
    );
  }
}
