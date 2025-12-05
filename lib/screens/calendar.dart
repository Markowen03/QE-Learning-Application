import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'reminder_service.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();

  void _addReminder(String date, String reminder) {
    ReminderService().addReminder(date, reminder);
    setState(() {});
  }

  void _deleteReminder(String date, String reminder) {
    ReminderService().deleteReminder(date, reminder);
    setState(() {});
  }

  void _showAddReminderDialog(DateTime date) {
    final controller = TextEditingController();
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Reminder for $formattedDate"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter reminder"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (controller.text.isNotEmpty) {
                _addReminder(formattedDate, controller.text);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    int firstWeekday = firstDayOfMonth.weekday;
    int daysInMonth = DateUtils.getDaysInMonth(selectedDate.year, selectedDate.month);

    List<Widget> dayWidgets = [];

    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox(width: 40, height: 40));
    }

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime thisDay = DateTime(selectedDate.year, selectedDate.month, day);
      String dateStr = DateFormat('yyyy-MM-dd').format(thisDay);
      bool hasReminder = ReminderService().reminders[dateStr]?.isNotEmpty ?? false;

      dayWidgets.add(GestureDetector(
        onTap: () => _showAddReminderDialog(thisDay),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: DateFormat('yyyy-MM-dd').format(now) == dateStr
                ? Colors.blueAccent
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue.shade200),
          ),
          width: 40,
          height: 40,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$day',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: DateFormat('yyyy-MM-dd').format(now) == dateStr
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                if (hasReminder)
                  const Icon(Icons.notifications, size: 14, color: Colors.redAccent),
              ],
            ),
          ),
        ),
      ));
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: dayWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    String selectedMonth = DateFormat('MMMM yyyy').format(selectedDate);
    Map<String, List<String>> reminders = ReminderService().reminders;

    return Scaffold(
      backgroundColor: const Color(0xFF0077BE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0077BE),
        title: const Text("Calendar", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
                    });
                  },
                ),
                Text(
                  selectedMonth,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildCalendar(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: reminders.entries
                    .map((entry) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            ...entry.value.map(
                              (reminder) => ListTile(
                                contentPadding: const EdgeInsets.only(left: 16),
                                title: Text(
                                  reminder,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.white),
                                  onPressed: () => _deleteReminder(entry.key, reminder),
                                ),
                              ),
                            ),
                            const Divider(color: Colors.white38),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
