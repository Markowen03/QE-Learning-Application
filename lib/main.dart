import 'package:flutter/material.dart';
import 'screens/start_up.dart';
import 'screens/dashboard.dart';


void main() {
  runApp(const QualityEducationApp());
}

class QualityEducationApp extends StatelessWidget {
  const QualityEducationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quality Education',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      initialRoute: '/', 
      routes: {
        '/': (context) => const StartUp(), 
        '/dashboard': (context) => const Dashboard(),
      },
    );
  }
}
