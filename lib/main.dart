import 'package:amazon_clone/features/admin_screens/admin_screen.dart';
import 'package:amazon_clone/features/screens/auth_screen.dart';
import 'package:amazon_clone/features/widgets/bottom_bar.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'Constants/Constants.dart';
import 'package:provider/Provider.dart';
import 'features/providers/user_provider.dart';
import 'features/services/auth_service.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  final authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme:
            const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: AdminScreen(),
      // onGenerateRoute: (settings) => generateRoute(settings),
      // home: Provider.of<UserProvider>(context).get().token.isNotEmpty
      // ? Provider.of<UserProvider>(context).get().type == 'user'
      // ? const BottomBar()
      // : const AdminScreen()
      // : const AuthScreen(),
    );
  }
}
