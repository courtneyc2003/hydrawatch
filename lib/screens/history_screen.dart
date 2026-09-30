import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/sensor_history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String selectedGraph = "Hydration";

  List<FlSpot> getData() {
    final history = SensorHistory.history;

    if (history.isEmpty) {
      return [const FlSpot(0, 0)];
    }

    return List.generate(history.length, (i) {
      switch (selectedGraph) {
        case "Heart Rate":
          return FlSpot(i.toDouble(), history[i].heartRate.toDouble());

        case "Temperature":
          return FlSpot(i.toDouble(), history[i].temperature);

        case "GSR":
          return FlSpot(i.toDouble(), history[i].gsr.toDouble());

        default:
          return FlSpot(i.toDouble(), history[i].hydration.toDouble());
      }
    });
  }

  Color graphColor() {
    switch (selectedGraph) {
      case "Heart Rate":
        return Colors.red;

      case "Temperature":
        return Colors.orange;

      case "GSR":
        return Colors.purple;

      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = getData();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDF7FF),
              Color(0xFFF8E8FF),
              Color(0xFFFFF2F8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Sensor History 📈",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE91E63),
                  ),
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  value: selectedGraph,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "Hydration",
                      child: Text("💧 Hydration"),
                    ),
                    DropdownMenuItem(
                      value: "Heart Rate",
                      child: Text("❤️ Heart Rate"),
                    ),
                    DropdownMenuItem(
                      value: "Temperature",
                      child: Text("🌡 Temperature"),
                    ),
                    DropdownMenuItem(
                      value: "GSR",
                      child: Text("📊 GSR"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedGraph = value!;
                    });
                  },
                ),

                const SizedBox(height: 25),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.withOpacity(0.15),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: true),
                        borderData: FlBorderData(show: false),
                        titlesData: const FlTitlesData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: data,
                            isCurved: true,
                            color: graphColor(),
                            barWidth: 5,
                            dotData: const FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: graphColor().withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    "Showing ${SensorHistory.history.length} readings",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}