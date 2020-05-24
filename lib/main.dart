import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_bloc.dart';
import 'package:whatsappcloneflutter/blocs/select_country_bloc/select_country_bloc.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/screens/login_screen.dart';
import 'package:whatsappcloneflutter/screens/select_country_screen.dart';
import 'package:whatsappcloneflutter/screens/splash_screen.dart';
import 'package:whatsappcloneflutter/screens/verify_phone_screen.dart';
import 'package:whatsappcloneflutter/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Constants.colorPrimaryDark);
    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectCountryBloc>(create: (BuildContext context) => SelectCountryBloc()),
        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Constants.colorPrimaryDark,
          cursorColor: Constants.colorPrimaryDark,
          primaryIconTheme:IconThemeData(color: Constants.colorBlack),
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          WelcomeScreen.routeName: (context) => WelcomeScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          SelectCountryScreen.routeName: (context) => SelectCountryScreen(),
          VerifyPhoneScreen.routeName: (context) => VerifyPhoneScreen(),
        },
      ),
    );
  }
}
