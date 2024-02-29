import 'package:chat_app/screen/dash/view/dash_screen.dart';
import 'package:chat_app/screen/home/view/home_screen.dart';
import 'package:chat_app/screen/profile/view/profile_sceen.dart';
import 'package:chat_app/screen/sign%20in/view/sign_in_screen.dart';
import 'package:chat_app/screen/sign%20up/view/sign_up_screen.dart';
import 'package:chat_app/screen/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> app_route={
  '/': (context) => const SplashScreen(),
  'signin': (context) => const SignInScreen(),
  'signup': (context) => const SignUpScreen(),
  'dash': (context) => const DashScreen(),
  'profile':(context) => const ProfileScreen(),
  'home': (context) => const HomeScreen(),
};