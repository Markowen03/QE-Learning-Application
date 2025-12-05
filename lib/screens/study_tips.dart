import 'package:flutter/material.dart';

class StudyTipsPage extends StatelessWidget {
  const StudyTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0077BE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0077BE),
        elevation: 0,
        centerTitle: true,
        title: const Column(
          children: [
            Icon(Icons.lightbulb, size: 30, color: Colors.white),
            SizedBox(height: 4),
            Text("Study Tips", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTipCard("🗓️ Create a Study Schedule",
                "Organize your study time and set goals to stay on track."),
            _buildTipCard("📵 Eliminate Distractions",
                "Turn off notifications and find a quiet study spot."),
            _buildTipCard("⏱️ Take Regular Breaks",
                "Use techniques like Pomodoro to maintain focus."),
            _buildTipCard("🧠 Practice Active Recall",
                "Test yourself instead of just rereading notes."),
            _buildTipCard("💧 Stay Hydrated & Rested",
                "Drink water and get enough sleep to improve concentration."),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(description, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
