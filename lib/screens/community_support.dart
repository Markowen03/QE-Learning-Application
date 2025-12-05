import 'dart:math';
import 'package:flutter/material.dart';

class CommunitySupportPage extends StatelessWidget {
  final List<String> motivationalQuotes = [
    '"Believe you can and you\'re halfway there." – Theodore Roosevelt',
    '"Push yourself, because no one else is going to do it for you."',
    '"Success doesn\'t just find you. You have to go out and get it."',
    '"The harder you work for something, the greater you’ll feel when you achieve it."',
    '"Dream bigger. Do bigger."',
    '"Don’t stop when you’re tired. Stop when you’re done."',
  ];

  CommunitySupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final randomQuote = motivationalQuotes[random.nextInt(motivationalQuotes.length)];

    return Scaffold(
      backgroundColor: const Color(0xFF0077BE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0077BE),
        elevation: 0,
        centerTitle: true,
        title: const Column(
          children: [
            Icon(Icons.groups, size: 30, color: Colors.white),
            SizedBox(height: 4),
            Text("Community & Support", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildCard(
              emoji: "💬",
              title: "Ask a Question",
              description: "Need help? Post your question and get support from peers or mentors.",
              buttonText: "Ask for Help",
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Coming soon in the next version!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildCard(
              emoji: "🎯",
              title: "Daily Motivation",
              description: randomQuote,
              buttonText: "Refresh Quote",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => CommunitySupportPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String emoji,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$emoji $title", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0077BE),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(buttonText, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
