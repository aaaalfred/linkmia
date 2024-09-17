import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/guide_screen.dart';
import '../screens/take_photo_screen.dart';
import '../screens/general_info_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    '/splash': (context) => const SplashScreen(),
    '/welcome': (context) => const WelcomeScreen(),
    '/guide': (context) => const GuideScreen(),
    '/take_photo': (context) => const TakePhotoScreen(),
    '/general_info': (context) => GeneralInfoScreen(),
    '/login': (context) => const LoginScreen(),
    '/profile': (context) => const ProfileScreen(),
  };
}