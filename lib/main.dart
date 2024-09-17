// lib/main.dart
import 'package:flutter/material.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'screens/initial_loading_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linkmi',
      theme: AppTheme.theme,
      home: InitialLoadingScreen(),
      routes: AppRoutes.routes,
    );
  }
}