import 'package:flutter/material.dart';

class HydrationGauge extends StatelessWidget {
  final double hydration;

  const HydrationGauge({
    super.key,
    required this.hydration,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (hydration / 100).clamp(0.0, 1.0);

    Color gaugeColor;

    if (hydration >= 80) {
      gaugeColor = Colors.blue;
    } else if (hydration >= 60) {
      gaugeColor = Colors.orange;
    } else {
      gaugeColor = Colors.red;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFF7FC),
            Color(0xFFF6EAFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Hydration Level 💧",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE91E63),
            ),
          ),

          const SizedBox(height: 25),

          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 170,
                height: 170,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 14,
                  backgroundColor: Colors.pink.shade100,
                  valueColor: AlwaysStoppedAnimation(gaugeColor),
                ),
              ),
                            Container(
                width: 135,
                height: 135,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.water_drop,
                      color: Colors.blue,
                      size: 36,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "${hydration.toInt()}%",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE91E63),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Text(
            hydration >= 80
                ? "Excellent Hydration 💖"
                : hydration >= 60
                    ? "Stay Hydrated 🌸"
                    : "Drink More Water 💧",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: gaugeColor,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Keep drinking water throughout the day to maintain healthy hydration levels.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}