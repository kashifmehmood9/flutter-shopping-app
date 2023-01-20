import 'package:amazon_clone/features/screens/auth_screen.dart';
import 'package:flutter/material.dart';

enum CloneAppRouteName {
  authScreen('/auth-screen'),
  loginScreen('');

  const CloneAppRouteName(this.value);
  final String value;
}

Route<dynamic> generateRoute(RouteSettings settings) {
  print("++ Generate route called");
  print(settings.name);

  if (settings.name == CloneAppRouteName.authScreen.value) {
    return MaterialPageRoute(builder: (_) => AuthScreen());
  } else {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(child: Text("Wrong route")),
            ));
  }
}
