
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/screens/welcome_screen.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "SplashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: SvgPicture.asset(
              Constants.logo,
              width: 100.0,
              height: 100.0,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Footer(),
          ),
        ],
      ),
    );
  }
}
