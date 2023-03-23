import 'package:amazon_clone/features/admin_screens/admin_screen.dart';
import 'package:amazon_clone/features/screens/auth_screen.dart';
import 'package:amazon_clone/features/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

enum RouteNames {
  authScreen('/auth-screen'),
  loginScreen(''),
  homeScreen('/home-screen'),
  bottomBar('/actual-home'),
  adminScreen('/admin-home');

  const RouteNames(this.value);
  final String value;
}

Route<dynamic> generateRoute(RouteSettings settings) {
  print("++ Generate route called");
  print(settings.name);

  if (settings.name == RouteNames.authScreen.value) {
    return MaterialPageRoute(builder: (_) => AuthScreen());
  } else if (settings.name == RouteNames.bottomBar.value) {
    return MaterialPageRoute(builder: (_) => BottomBar());
  } else if (settings.name == RouteNames.adminScreen.value) {
    return MaterialPageRoute(builder: (_) => AdminScreen());
  } else {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(child: Text("Wrong route")),
            ));
  }
}
