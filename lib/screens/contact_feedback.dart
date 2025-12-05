import 'package:flutter/material.dart';

class ContactFeedbackPage extends StatelessWidget {
  const ContactFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0077BE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0077BE),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Contact & Feedback',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSection(
              title: 'Contact Us',
              icon: Icons.email,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("A quick way for students, parents, or teachers to get in touch."),
                  SizedBox(height: 8),
                  Text("✉️ Email Support: qualityeducation@gmail.com"),
                  Text("💬 Chat with Us (if live chat is available)"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Give Feedback',
              icon: Icons.star,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("How was your experience today?"),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Text("Rate: "),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star_border, color: Colors.amber),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildInputField("What do you like?"),
                  const SizedBox(height: 8),
                  _buildInputField("What can we improve?"),
                  const SizedBox(height: 8),
                  _buildInputField("Suggestions?"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.amber),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  static Widget _buildInputField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
