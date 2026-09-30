import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '../models/sensor_data.dart';
import '../models/sensor_history.dart';
import '../widgets/hydration_gauge.dart';
import '../widgets/sensor_card.dart';
import '../widgets/goal_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Timer timer;
  final Random random = Random();

  int heartRate = 72;
  double temperature = 36.6;
  int hydration = 82;
  int gsr = 510;

  String lastUpdated = "";

  @override
  void initState() {
    super.initState();

    _updateSensors();

    timer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        _updateSensors();
      });
    });
  }

  void _updateSensors() {
    heartRate = 68 + random.nextInt(15);
    temperature = 36.2 + random.nextDouble();
    hydration = 65 + random.nextInt(26);
    gsr = 480 + random.nextInt(60);

    final now = DateTime.now();

    lastUpdated =
        "${now.month}/${now.day}/${now.year} • ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    SensorHistory.add(
      SensorData(
        heartRate: heartRate,
        temperature: temperature,
        hydration: hydration,
        gsr: gsr,
        timestamp: now,
      ),
    );
  }

  int get wellnessScore {
    int score = 100;

    if (hydration < 75) score -= 15;
    if (heartRate < 60 || heartRate > 100) score -= 10;
    if (temperature < 36 || temperature > 37.8) score -= 10;

    return score.clamp(0, 100);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool lowHydration = hydration < 75;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDF7FF),
              Color(0xFFF8E8FF),
              Color(0xFFFFF3FA),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFE91E63),
                        Color(0xFFBA68C8),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [

                      const CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.favorite,
                          color: Color(0xFFE91E63),
                          size: 40,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "HydraWatch",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Hi Benadryl Bunnies! 🌸",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        "Your wellness summary for today",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        lastUpdated,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.15),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      const Text(
                        "Wellness Score",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "$wellnessScore",
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE91E63),
                        ),
                      ),

                      const Text(
                        "Excellent 💖",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 20),
                if (lowHydration)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Hydration is getting low! Drink some water 💧",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                if (lowHydration)
                  const SizedBox(height: 20),

                HydrationGauge(
                  hydration: hydration.toDouble(),
                ),

                const SizedBox(height: 20),

                GoalCard(
                  hydration: hydration,
                ),

                const SizedBox(height: 20),

                SensorCard(
                  title: "❤️ Heart Rate",
                  value: "$heartRate BPM",
                  icon: Icons.favorite,
                  color: Colors.red,
                ),

                const SizedBox(height: 12),

                SensorCard(
                  title: "🌡 Body Temperature",
                  value: "${temperature.toStringAsFixed(1)} °C",
                  icon: Icons.thermostat,
                  color: Colors.orange,
                ),

                const SizedBox(height: 12),

                SensorCard(
                  title: "💧 Hydration",
                  value: "$hydration%",
                  icon: Icons.water_drop,
                  color: Colors.blue,
                ),

                const SizedBox(height: 12),

                SensorCard(
                  title: "📈 GSR",
                  value: "$gsr",
                  icon: Icons.monitor_heart,
                  color: Colors.purple,
                ),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFE8F5E9),
                        Colors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.15),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.bluetooth_connected,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Smartwatch Connected",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Receiving live biometric data",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 30,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}