import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'Constants/Constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Amazon clone',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor),
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black))),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Hello"),
            ),
            body: Column(
              children: [
                const Center(child: Text("Flutter demo")),
                Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/auth-screen");
                      },
                      child: const Text("Press me"));
                })
              ],
            )));
  }
}
