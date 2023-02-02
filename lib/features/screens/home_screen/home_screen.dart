import "package:flutter/material.dart";
import "package:provider/provider.dart";

import '../../Models/User.dart';
import '../../providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).get();
    return Scaffold(body: Center(child: Text("${user?.toMap()}")));
  }
}
