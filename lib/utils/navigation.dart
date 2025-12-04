import 'package:flutter/material.dart';

class RouteNames {
  static const splash = '/splash';
  static const signup = '/signup';
  static const login = '/login';
  static const home = '/home';
  static const chat = '/chat';
  static const eligibility = '/eligibility';
  static const education = '/education';
  static const checklist = '/checklist';
  static const pdfPreview = '/pdf_preview';
  static const settings = '/settings';
  static const profile = '/profile';
}

class NavigationUtils {
  static Future<T?> pushNamed<T extends Object?>(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T extends Object?>(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  static void pop(BuildContext context, [Object? result]) {
    Navigator.of(context).pop(result);
  }
}
