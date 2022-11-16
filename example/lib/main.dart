import 'package:flutter/material.dart';

import 'package:daily_client/daily_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _dailyClient = DailyClient();

  @override
  void initState() {
    super.initState();
    _join();
  }

  void _join() async {
    await _dailyClient.join('my_url');
    await _dailyClient.leave();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Daily client app'),
        ),
        body: const Center(
          child: Text('Home'),
        ),
      ),
    );
  }
}
