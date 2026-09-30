import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final sexController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  final contactNameController = TextEditingController();
  final contactPhoneController = TextEditingController();
  final relationshipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      ageController.text = prefs.getString('age') ?? '';
      sexController.text = prefs.getString('sex') ?? '';
      heightController.text = prefs.getString('height') ?? '';
      weightController.text = prefs.getString('weight') ?? '';

      contactNameController.text =
          prefs.getString('contactName') ?? '';
      contactPhoneController.text =
          prefs.getString('contactPhone') ?? '';
      relationshipController.text =
          prefs.getString('relationship') ?? '';
    });
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', nameController.text);
    await prefs.setString('age', ageController.text);
    await prefs.setString('sex', sexController.text);
    await prefs.setString('height', heightController.text);
    await prefs.setString('weight', weightController.text);

    await prefs.setString(
      'contactName',
      contactNameController.text,
    );

    await prefs.setString(
      'contactPhone',
      contactPhoneController.text,
    );

    await prefs.setString(
      'relationship',
      relationshipController.text,
    );
  }
    Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE91E63),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
                            buildSectionTitle("User Information"),

              buildTextField(
                nameController,
                "Name",
                Icons.person,
              ),

              buildTextField(
                ageController,
                "Age",
                Icons.cake,
              ),

              buildTextField(
                sexController,
                "Sex",
                Icons.wc,
              ),

              buildTextField(
                heightController,
                "Height",
                Icons.height,
              ),

              buildTextField(
                weightController,
                "Weight",
                Icons.monitor_weight,
              ),

              const SizedBox(height: 20),

              buildSectionTitle("Emergency Contact"),

              buildTextField(
                contactNameController,
                "Contact Name",
                Icons.contact_phone,
              ),

              buildTextField(
                contactPhoneController,
                "Phone Number",
                Icons.phone,
              ),

              buildTextField(
                relationshipController,
                "Relationship",
                Icons.favorite,
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await saveData();

                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Information saved successfully!"),
                      ),
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text(
                    "Save Information",
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

              const SizedBox(height: 20),
                            SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
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
    );
  }
    @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    sexController.dispose();
    heightController.dispose();
    weightController.dispose();

    contactNameController.dispose();
    contactPhoneController.dispose();
    relationshipController.dispose();

    super.dispose();
  }
}