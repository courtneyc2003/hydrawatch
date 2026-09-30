import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  final int hydration;

  const GoalCard({
    super.key,
    required this.hydration,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (hydration / 100).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFF3FA),
            Color(0xFFF6E8FF),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Hydration Goal 💧",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE91E63),
            ),
          ),

          const SizedBox(height: 15),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 14,
              backgroundColor: Colors.pink.shade100,
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFF64B5F6),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "$hydration% of your daily goal",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}