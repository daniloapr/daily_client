import 'package:daily_client_example/dependencies.dart';
import 'package:daily_client_example/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}
