import 'package:flutter/material.dart';

class BluetoothScreen extends StatelessWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bluetooth"),
        centerTitle: true,
        backgroundColor: Colors.pink.shade100,
      ),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.15),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 38,
                        backgroundColor: Color(0xFFE3F2FD),
                        child: Icon(
                          Icons.bluetooth_connected,
                          size: 45,
                          color: Colors.blue,
                        ),
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        "HydraWatch Device",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Connected Successfully 💙",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "Your HydraWatch smartwatch is actively sending live biometric data.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.12),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.bluetooth, color: Colors.blue),
                        title: Text("Connection Status"),
                        trailing: Text(
                          "Connected",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Divider(),

                      ListTile(
                        leading: Icon(Icons.battery_full, color: Colors.green),
                        title: Text("Battery"),
                        trailing: Text("94%"),
                      ),

                      Divider(),
                                            ListTile(
                        leading: Icon(
                          Icons.signal_cellular_alt,
                          color: Colors.deepPurple,
                        ),
                        title: Text("Signal Strength"),
                        trailing: Text("Excellent"),
                      ),

                      Divider(),

                      ListTile(
                        leading: Icon(
                          Icons.sync,
                          color: Colors.pink,
                        ),
                        title: Text("Last Sync"),
                        trailing: Text("Just Now"),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.refresh),
                    label: const Text(
                      "Reconnect Device",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE91E63),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
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