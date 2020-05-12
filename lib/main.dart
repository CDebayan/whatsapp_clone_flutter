import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/login/login_screen.dart';
import 'package:whatsappcloneflutter/splash/splash_screen.dart';
import 'package:whatsappcloneflutter/welcome/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName : (context) => SplashScreen(),
        WelcomeScreen.routeName : (context) => WelcomeScreen(),
        LoginScreen.routeName : (context) => LoginScreen(),
      },
    );
  }
}
