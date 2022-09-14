import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';
import 'pages/intro_screen.dart';
import 'pages/login_page.dart';
import 'pages/user_detailPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool? isIntroVisited = prefs.getBool('isIntroVisited') ?? false;
  bool? isRemember = prefs.getBool("isRemember") ?? false;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: (isIntroVisited == false)
          ? 'IntroScreen'
          : (isLoggedIn == false)
              ? 'UserDetailPage'
              : (isRemember == false)
                  ? 'LoginPage'
                  : 'HomePage',
      // initialRoute: (isLoggedIn == false) ? 'LoginPage' : 'HomePage',
      routes: {
        'HomePage': (context) => const HomePage(),
        'LoginPage': (context) => const LoginPage(),
        'IntroScreen': (context) => const IntroScreen(),
        'UserDetailPage': (context) => const UserDetailPage(),
      },
    ),
  );
}
