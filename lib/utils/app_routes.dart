import 'package:chat_app/screen/home/view/home_screen.dart';
import 'package:chat_app/screen/sign%20in/view/sign_in_screen.dart';
import 'package:chat_app/screen/sign%20up/view/sign_up_screen.dart';
import 'package:chat_app/screen/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> app_route={
  '/': (context) => const SplashScreen(),
  'signin': (context) => const SignInScreen(),
  'signup': (context) => const SignUpScreen(),
  'home': (context) => const HomeScreen(),
};