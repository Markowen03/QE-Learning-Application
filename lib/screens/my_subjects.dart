import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'subject_detail.dart';

class MyCoursePage extends StatefulWidget {
  const MyCoursePage({super.key});

  @override
  State<MyCoursePage> createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage> {
  final Color primaryBlue = const Color(0xFF0077BE);
  List<String> savedSubjects = [];

  final Map<String, String> subjectImages = {
    'SCIENCE': 'assets/images/science_book.png',
    'ENGLISH': 'assets/images/english_book.png',
    'FILIPINO': 'assets/images/filipino_book.png',
    'MATH': 'assets/images/math_book.png',
  };

  @override
  void initState() {
    super.initState();
    _loadSavedSubjects();
  }

  Future<void> _loadSavedSubjects() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('savedSubjects') ?? [];
    setState(() {
      savedSubjects = list;
    });
  }

  Future<void> _removeSubject(String subject) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('savedSubjects') ?? [];

    list.remove(subject);
    await prefs.setStringList('savedSubjects', list);

    setState(() {
      savedSubjects = list;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$subject has been removed.')),
    );
  }

  void _showRemoveConfirmation(String subject) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Subject'),
        content: Text('Are you sure you want to remove "$subject"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removeSubject(subject);
            },
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        title: const Text(
          'My Subjects',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: savedSubjects.isEmpty
            ? const Center(
                child: Text(
                  'No saved subjects yet.',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: savedSubjects.length,
                itemBuilder: (context, index) {
                  final subject = savedSubjects[index];
                  final imagePath = subjectImages[subject.toUpperCase()] ??
                      'assets/images/lessons.png';
                  return _buildCourseCard(subject, imagePath);
                },
              ),
      ),
    );
  }

  Widget _buildCourseCard(String subject, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SubjectDetailPage(subject: subject),
          ),
        );
      },
      onLongPress: () => _showRemoveConfirmation(subject),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                subject,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showRemoveConfirmation(subject),
            )
          ],
        ),
      ),
    );
  }
}
