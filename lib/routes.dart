import 'package:evi_app/screens/application_screen.dart';
import 'package:evi_app/screens/forgot_password.dart';
import 'package:evi_app/screens/home_screen.dart';
import 'package:evi_app/screens/login_page.dart';
import 'package:evi_app/screens/register_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/application_screen':
      return MaterialPageRoute(builder: (context) => const ApplicationScreen());
    case '/forgot_password':
      return MaterialPageRoute(builder: (context) => const ForgotPassword());
    case '/home_screen':
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case '/login_page':
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case '/register_page':
      return MaterialPageRoute(builder: (context) => const RegisterPage());
    default:
      return MaterialPageRoute(builder: (context) => const LoginPage());
  }
}
