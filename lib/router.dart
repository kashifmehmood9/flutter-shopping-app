import 'package:amazon_clone/features/screens/auth_screen.dart';
import 'package:amazon_clone/features/screens/home_screen/home_screen.dart';
import 'package:amazon_clone/features/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

enum RouteNames {
  authScreen('/auth-screen'),
  loginScreen(''),
  homeScreen('/home-screen'),
  bottomBar('/actual-home');

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
  } else {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(child: Text("Wrong route")),
            ));
  }
}
