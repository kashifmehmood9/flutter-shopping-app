import 'package:amazon_clone/features/admin_screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin_screens/admin_screen.dart';
import 'package:amazon_clone/features/screens/auth_screen.dart';
import 'package:amazon_clone/features/screens/home_screen/categroy_deals_screen.dart';
import 'package:amazon_clone/features/search/search_screen.dart';
import 'package:amazon_clone/features/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print("++ Generate route called");
  print(settings.name);

  switch (settings.name) {
    case AuthScreen.screenName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => AuthScreen(),
      );
    case BottomBar.screenName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => BottomBar(),
      );
    case AdminScreen.screenName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => AdminScreen(),
      );
    case AddProductScreen.screenName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => AddProductScreen(),
      );
    case CategoryDealsScreen.screenName:
      var category = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => CategoryDealsScreen(category: category),
      );
    case SearchScreen.screenName:
      var searchString = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => SearchScreen(searchQuery: searchString),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Wrong route"),
          ),
        ),
      );
  }
}
