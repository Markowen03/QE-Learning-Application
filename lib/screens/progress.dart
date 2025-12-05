import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  final int completedTests;

  const ProgressPage({super.key, required this.completedTests});

  String _getAchievementTitle(int tests) {
    if (tests >= 20) return "Legendary Learner";
    if (tests >= 15) return "Master Mind";
    if (tests >= 10) return "Star Student";
    if (tests >= 5) return "Quick Thinker";
    if (tests >= 1) return "Beginner";
    return "No Progress Yet";
  }

  String _getAchievementDescription(String title) {
    switch (title) {
      case "Legendary Learner":
        return "You've completed 20+ tests. You're unstoppable!";
      case "Master Mind":
        return "15+ tests completed. You're mastering the subjects!";
      case "Star Student":
        return "10+ tests done! Great job shining bright!";
      case "Quick Thinker":
        return "5+ tests completed. You're picking up fast!";
      case "Beginner":
        return "You've started your journey. Keep going!";
      default:
        return "Take your first test to start tracking progress!";
    }
  }

  @override
  Widget build(BuildContext context) {
    final achievement = _getAchievementTitle(completedTests);
    final description = _getAchievementDescription(achievement);

    return Scaffold(
      backgroundColor: const Color(0xFF0077BE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0077BE),
        elevation: 0,
        title: const Text("Your Progress"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.emoji_events, size: 64, color: Color(0xFFFFC107)),
                    const SizedBox(height: 16),
                    Text(
                      achievement,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0077BE),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Tests Completed: $completedTests",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Back to Dashboard"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0077BE),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
