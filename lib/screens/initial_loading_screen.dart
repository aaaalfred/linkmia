// lib/screens/initial_loading_screen.dart
import 'package:flutter/material.dart';
import '../services/app_state.dart';

class InitialLoadingScreen extends StatefulWidget {
  @override
  _InitialLoadingScreenState createState() => _InitialLoadingScreenState();
}

class _InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    final isLoggedIn = await AppState.isLoggedIn();
    final lastRoute = await AppState.getLastRoute();

    if (isLoggedIn && lastRoute != null) {
      Navigator.of(context).pushReplacementNamed(lastRoute);
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}