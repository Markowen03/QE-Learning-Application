import 'package:flutter/material.dart';
import 'teachers.dart';
import 'subjects.dart';
import 'my_subjects.dart';
import 'notification.dart';
import 'study_tips.dart';
import 'community_support.dart';
import 'privacy_policy.dart';
import 'contact_feedback.dart';
import 'about_app.dart';
import 'test.dart';
import 'calendar.dart';
import 'reminder_service.dart';
import 'subject_detail.dart';
import 'progress.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _subjects = [
    {'title': 'SCIENCE', 'image': 'assets/images/science_book.png'},
    {'title': 'ENGLISH', 'image': 'assets/images/english_book.png'},
    {'title': 'FILIPINO', 'image': 'assets/images/filipino_book.png'},
    {'title': 'MATH', 'image': 'assets/images/math_book.png'},
  ];

  final List<Map<String, String>> _teachers = [
    {'name': 'Ana Gomez', 'subject': 'English Teacher'},
    {'name': 'Ronald Cruz', 'subject': 'Mathematics Teacher'},
    {'name': 'William Castro', 'subject': 'Science Teacher'},
    {'name': 'Trish Sandro', 'subject': 'Filipino Teacher'},
  ];

  // ignore: unused_field
  final List<Widget> _pages = [
    SizedBox(),
    SizedBox(),
    CalendarPage(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CalendarPage()),
      ).then((_) => setState(() {}));
    } else if (index == 1) {
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProgressPage(completedTests: 8)),
      );
    }
  }

  List<Map<String, String>> get _filteredSubjects {
    return _subjects
        .where((s) => s['title']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  List<Map<String, String>> get _filteredTeachers {
    return _teachers
        .where((t) => t['name']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final upcomingReminders = ReminderService().getUpcomingReminders();
    final isSearching = _searchQuery.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFF0077BE),
      drawer: _buildDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              if (isSearching) ...[
                const SizedBox(height: 16),
                Expanded(child: _buildSearchResults())
              ] else ...[
                const SizedBox(height: 16),
                _buildReminders(upcomingReminders),
                const SizedBox(height: 16),
                Expanded(child: _buildGrid())
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: (value) => setState(() => _searchQuery = value),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Search now...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
            setState(() => _searchQuery = '');
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    final results = [
      ..._filteredSubjects.map((s) => ListTile(
            leading: Image.asset(s['image']!, width: 40, height: 40),
            title: Text(s['title']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubjectDetailPage(subject: s['title']!),
                ),
              );
            },
          )),
      ..._filteredTeachers.map((t) => ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: Text(t['name']!),
            subtitle: Text(t['subject']!),
          )),
    ];

    return results.isEmpty
        ? const Center(
            child: Text("No results found.", style: TextStyle(color: Colors.white)),
          )
        : ListView(children: results);
  }

  Widget _buildReminders(List<Map<String, dynamic>> upcomingReminders) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Reminders", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Expanded(
            child: upcomingReminders.isNotEmpty
                ? ListView.builder(
                    itemCount: upcomingReminders.length,
                    itemBuilder: (context, index) {
                      final reminder = upcomingReminders[index];
                      final text = reminder['text'] as String;
                      final date = reminder['date'] as DateTime;
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);
                      final tomorrow = today.add(const Duration(days: 1));
                      String label = (date.isAtSameMomentAs(today))
                          ? "Today"
                          : (date.isAtSameMomentAs(tomorrow))
                              ? "Tomorrow"
                              : "${date.month}/${date.day}";

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
                            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("No reminders for today or upcoming.",
                        style: TextStyle(color: Colors.black54)),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Hi there!",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Find your lessons today!", style: TextStyle(color: Colors.white70)),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NotificationPage()));
          },
        ),
      ],
    );
  }

  Widget _buildGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildCard("Teachers", "assets/images/teacher.png"),
        _buildCard("Subjects", "assets/images/courses.png"),
        _buildCard("Practice Test", "assets/images/assignment.png"),
        _buildCard("My Subjects", "assets/images/my_courses.png"),
      ],
    );
  }

  Widget _buildCard(String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        if (title == "Teachers") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const TeachersPage()));
        } else if (title == "Subjects") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CoursesPage()));
        } else if (title == "Practice Test") {
          _showSubjectPicker();
        } else if (title == "My Subjects") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCoursePage()));
        }
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset(imagePath)),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void _showSubjectPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Choose a Subject",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ..._subjects.map((subject) {
                return ListTile(
                  leading: Image.asset(subject['image']!, width: 40, height: 40),
                  title: Text(subject['title']!),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestPage(subject: subject['title']!),
                      ),
                    );
                  },
                );
              // ignore: unnecessary_to_list_in_spreads
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Container(
        color: const Color(0xFF0077BE),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(Icons.lightbulb, "Study Tips"),
                  _buildDrawerItem(Icons.group, "Community & Support"),
                  _buildDrawerItem(Icons.lock, "Privacy Policy"),
                  _buildDrawerItem(Icons.info, "About App"),
                  _buildDrawerItem(Icons.contact_support, "Contact & Feedback"),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text('"Small progress is still progress."',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic)),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text("App v1.0.0", style: TextStyle(color: Colors.white54, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(title, style: const TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.pop(context);
            if (title == "Study Tips") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const StudyTipsPage()));
            } else if (title == "Community & Support") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CommunitySupportPage()));
            } else if (title == "Privacy Policy") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()));
            } else if (title == "About App") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutAppPage()));
            } else if (title == "Contact & Feedback") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactFeedbackPage()));
            }
          },
        ),
        const Divider(thickness: 1, height: 1, indent: 16, endIndent: 16, color: Colors.white24),
      ],
    );
  }

  BottomNavigationBar _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onNavTapped,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      backgroundColor: const Color(0xFF0077BE),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Progress"),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Calendar"),
      ],
    );
  }
}
