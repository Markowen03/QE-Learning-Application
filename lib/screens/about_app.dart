import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0077BE),
      appBar: AppBar(
        title: const Text("About App", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0077BE),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "This educational app helps students organize and enhance their learning experience. "
          "\n\nVersion: 1.0.0\nDeveloper: Mark Owen Badua\nUI/UX: Lyndylou Batindaan\nDocumentation: Gerald Navarro\nMark Monsale\nJaym Aplino",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
