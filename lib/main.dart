import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:whatsappcloneflutter/blocs/user_list_bloc/user_list_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_event.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/screens/about_screen.dart';
import 'package:whatsappcloneflutter/screens/chat_screen.dart';
import 'package:whatsappcloneflutter/screens/dashboard_screen.dart';
import 'package:whatsappcloneflutter/screens/login_screen.dart';
import 'package:whatsappcloneflutter/screens/settings_screen.dart';
import 'package:whatsappcloneflutter/screens/splash_screen.dart';
import 'package:whatsappcloneflutter/screens/user_list_screen.dart';
import 'package:whatsappcloneflutter/screens/user_profile_screen.dart';
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
        BlocProvider<UserListBloc>(
          create: (BuildContext context) => UserListBloc(),
        ),
        BlocProvider<UserProfileBloc>(
          create: (BuildContext context) => UserProfileBloc()..add(FetchUserDetails()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Constants.colorPrimaryDark,
          cursorColor: Constants.colorPrimaryDark,
          primaryIconTheme: IconThemeData(color: Constants.colorWhite),
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          WelcomeScreen.routeName: (context) => WelcomeScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          VerifyPhoneScreen.routeName: (context) => VerifyPhoneScreen(),
          DashboardScreen.routeName: (context) => DashboardScreen(),
          UserListScreen.routeName: (context) => UserListScreen(),
          SettingsScreen.routeName: (context) => SettingsScreen(),
          UserProfileScreen.routeName: (context) => UserProfileScreen(),
          AboutScreen.routeName: (context) => AboutScreen(),
          ChatScreen.routeName: (context) => ChatScreen(),
        },
      ),
    );
  }
}
