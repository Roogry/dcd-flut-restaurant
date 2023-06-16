import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, dynamic arguments) {
    if (arguments == null) {
      navigatorKey.currentState?.pushNamed(routeName);
    } else {
      navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
    }
  }

  static intentReplaceWithData(String routeName, dynamic arguments) {
    if (arguments == null) {
      navigatorKey.currentState?.pushReplacementNamed(routeName);
    } else {
      navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
    }
  }

  static back() => navigatorKey.currentState?.pop();
}
