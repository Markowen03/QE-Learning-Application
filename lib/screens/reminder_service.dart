class ReminderService {
  static final ReminderService _instance = ReminderService._internal();
  factory ReminderService() => _instance;
  ReminderService._internal();

  // Store reminders with date keys (yyyy-MM-dd) and list of strings
  final Map<String, List<String>> _reminders = {};

  Map<String, List<String>> get reminders => _reminders;

  void addReminder(String date, String reminder) {
    _reminders.putIfAbsent(date, () => []);
    _reminders[date]!.add(reminder);
  }

  void deleteReminder(String date, String reminder) {
    if (_reminders.containsKey(date)) {
      _reminders[date]!.remove(reminder);
      if (_reminders[date]!.isEmpty) {
        _reminders.remove(date);
      }
    }
  }

  // Get reminders for today
  List<String> getTodayReminders() {
    final today = DateTime.now();
    final key = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    return _reminders[key] ?? [];
  }

  // 3 reminder
  List<Map<String, dynamic>> getUpcomingReminders() {
    final now = DateTime.now();

    // list of maps with date and text
    List<Map<String, dynamic>> allReminders = [];
    _reminders.forEach((dateStr, remindersList) {
      DateTime date = DateTime.parse(dateStr);
      if (!date.isBefore(DateTime(now.year, now.month, now.day))) {
        for (var reminder in remindersList) {
          allReminders.add({'date': date, 'text': reminder});
        }
      }
    });

    // Sort by date ascending
    allReminders.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));

    // Limit to 3 reminders max
    return allReminders.take(3).toList();
  }
}
