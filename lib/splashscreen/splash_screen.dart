import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsappcloneflutter/constants.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "SplashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: SvgPicture.asset(
              Constants.logo,
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
                child: Column(
              children: <Widget>[
                Text(
                  "from",
                  style: TextStyle(color: Constants.defaultTextColor),
                ),
                Text(
                  "FACEBOOk",
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 20,
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
