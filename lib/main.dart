import 'package:flutter_shopping_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Constants/Constants.dart';
import 'features/Models/User.dart';
import 'features/admin_screens/admin_screen.dart';
import 'features/providers/user_provider.dart';
import 'features/screens/auth_screen.dart';
import 'features/services/auth_service.dart';
import 'features/widgets/bottom_bar.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amazon Clone',
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: home());
  }

  Widget? home() {
    User user = Provider.of<UserProvider>(context).get();
    if (user.token.isNotEmpty && user.type == 'admin') {
      return const AdminScreen();
    } else if (user.token.isNotEmpty && user.type == 'user') {
      return const BottomBar();
    } else {
      return AuthScreen();
    }
  }
}
