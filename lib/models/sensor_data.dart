class SensorData {
  final int heartRate;
  final double temperature;
  final int hydration;
  final int gsr;
  final DateTime timestamp;

  SensorData({
    required this.heartRate,
    required this.temperature,
    required this.hydration,
    required this.gsr,
    required this.timestamp,
  });
}