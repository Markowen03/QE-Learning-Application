import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  final String subject; 

  const TestPage({super.key, required this.subject});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int currentQuestion = 0;
  int score = 0;
  String? selectedAnswer;

  late List<Map<String, dynamic>> questions;

  @override
  void initState() {
    super.initState();
    questions = _getQuestionsForSubject(widget.subject);
  }

  List<Map<String, dynamic>> _getQuestionsForSubject(String subject) {
    
    switch (subject) {
      case "SCIENCE":
        return [
          {
            'question': 'What planet is known as the Red Planet?',
            'options': ['Earth', 'Mars', 'Jupiter', 'Saturn'],
            'answer': 'Mars'
          },
          {
            'question': 'What gas do plants absorb from the air?',
            'options': ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
            'answer': 'Carbon Dioxide'
          },
        ];
      case "MATH":
        return [
          {
            'question': 'What is 8 x 7?',
            'options': ['54', '56', '64', '58'],
            'answer': '56'
          },
          {
            'question': 'What is the square root of 81?',
            'options': ['7', '8', '9', '10'],
            'answer': '9'
          },
        ];
      default:
        return [
          {
            'question': 'This is a sample question.',
            'options': ['A', 'B', 'C', 'D'],
            'answer': 'A'
          },
        ];
    }
  }

  void _submitAnswer() {
    if (selectedAnswer == questions[currentQuestion]['answer']) {
      score++;
    }
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Quiz Completed!"),
        content: Text("You scored $score out of ${questions.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Back"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionData = questions[currentQuestion];
    return Scaffold(
      backgroundColor: const Color(0xFF0077BE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0077BE),
        elevation: 0,
        title: Text("${widget.subject} Quiz", style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${currentQuestion + 1} of ${questions.length}",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              questionData['question'],
              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...questionData['options'].map<Widget>((option) {
              return RadioListTile<String>(
                value: option,
                groupValue: selectedAnswer,
                title: Text(option, style: const TextStyle(color: Colors.white)),
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    selectedAnswer = value;
                  });
                },
              );
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: selectedAnswer != null ? _submitAnswer : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF0077BE),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
