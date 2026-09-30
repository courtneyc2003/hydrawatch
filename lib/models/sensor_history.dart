import 'sensor_data.dart';

class SensorHistory {
  static final List<SensorData> history = [];

  static void add(SensorData data) {
    history.add(data);

    // Keep only the most recent 50 readings
    if (history.length > 50) {
      history.removeAt(0);
    }
  }
}