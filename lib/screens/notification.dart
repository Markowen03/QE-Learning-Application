import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Map<String, List<String>> groupedNotifications = {
    'Today': [],
    'Earlier': [],
  };

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final allNotifications = prefs.getStringList('notifications') ?? [];

    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final Map<String, List<String>> groups = {
      'Today': [],
      'Earlier': [],
    };

    for (var notif in allNotifications) {
      final parts = notif.split('|');
      if (parts.length == 2) {
        final date = parts[0];
        final message = parts[1];
        if (date == today) {
          groups['Today']!.add(message);
        } else {
          groups['Earlier']!.add(message);
        }
      }
    }

    setState(() {
      groupedNotifications = groups;
    });
  }

  Future<void> _clearAllNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');

    setState(() {
      groupedNotifications = {
        'Today': [],
        'Earlier': [],
      };
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications cleared.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todayNotifs = groupedNotifications['Today']!;
    final earlierNotifs = groupedNotifications['Earlier']!;
    final hasNotifications = todayNotifs.isNotEmpty || earlierNotifs.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFF0077BE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0077BE),
        elevation: 0,
        title: const Text("Notifications", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (hasNotifications)
            IconButton(
              icon: const Icon(Icons.delete_forever, color: Colors.white),
              onPressed: _clearAllNotifications,
              tooltip: 'Clear All',
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: hasNotifications
            ? ListView(
                children: [
                  if (todayNotifs.isNotEmpty) ...[
                    const Text("Today", style: _sectionTitleStyle),
                    const SizedBox(height: 8),
                    ...todayNotifs.map((msg) => _buildNotificationItem("Subject Saved", msg)),
                    const SizedBox(height: 24),
                  ],
                  if (earlierNotifs.isNotEmpty) ...[
                    const Text("Earlier", style: _sectionTitleStyle),
                    const SizedBox(height: 8),
                    ...earlierNotifs.map((msg) => _buildNotificationItem("Subject Saved", msg)),
                  ]
                ],
              )
            : const Center(
                child: Text(
                  'No notifications yet.',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF0077BE),
          child: Icon(Icons.notifications, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  static const TextStyle _sectionTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}
