import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:intl/intl.dart';

class SubjectDetailPage extends StatefulWidget {
  final String subject;

  const SubjectDetailPage({super.key, required this.subject});

  @override
  State<SubjectDetailPage> createState() => _SubjectDetailPageState();
}

class _SubjectDetailPageState extends State<SubjectDetailPage> {
  String? pdfPath;
  bool fileExists = false;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  /// Returns the local PDF asset
  String? _getPdfPath(String subject) {
    switch (subject.toUpperCase()) {
      case 'SCIENCE':
        return 'assets/pdf/science.pdf';
      case 'ENGLISH':
        return 'assets/pdf/english.pdf';
      case 'FILIPINO':
        return 'assets/pdf/filipino.pdf';
      case 'MATH':
        return 'assets/pdf/math.pdf';
      default:
        return null;
    }
  }

  /// Loads the PDF and checks
  Future<void> _loadPdf() async {
    final path = _getPdfPath(widget.subject);

    if (path == null) {
      setState(() {
        fileExists = false;
        pdfPath = null;
      });
      return;
    }

    try {
      await rootBundle.load(path);
      setState(() {
        fileExists = true;
        pdfPath = path;
      });
    } catch (_) {
      setState(() {
        fileExists = false;
        pdfPath = null;
      });
    }
  }

  /// Saves the current subject to SharedPreferences for My Subjects.
  Future<void> _saveSubject() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSubjects = prefs.getStringList('savedSubjects') ?? [];
    final notifications = prefs.getStringList('notifications') ?? [];

    if (!savedSubjects.contains(widget.subject)) {
      savedSubjects.add(widget.subject);
      await prefs.setStringList('savedSubjects', savedSubjects);

      // Save with date prefix
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      notifications.add('$today|${widget.subject} was saved to My Subjects');
      await prefs.setStringList('notifications', notifications);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.subject} saved to My Subjects')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.subject} is already saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0077BE),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: fileExists && pdfPath != null
          ? SfPdfViewer.asset(pdfPath!)
          : const Center(
              child: Text(
                'PDF file not found.',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveSubject,
        backgroundColor: const Color(0xFF0077BE),
        child: const Icon(Icons.bookmark_add),
      ),
    );
  }
}
