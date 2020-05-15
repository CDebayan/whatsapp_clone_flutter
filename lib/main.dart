import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/screens/login_screen.dart';
import 'package:whatsappcloneflutter/screens/select_country_screen.dart';
import 'package:whatsappcloneflutter/screens/splash_screen.dart';
import 'package:whatsappcloneflutter/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Constants.colorPrimaryDark,
        cursorColor: Constants.colorPrimaryDark,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SelectCountryScreen.routeName: (context) => SelectCountryScreen(),
      },
    );
  }
}
