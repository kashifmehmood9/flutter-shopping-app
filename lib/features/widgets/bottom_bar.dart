import 'package:amazon_clone/Constants/Constants.dart';
import 'package:amazon_clone/features/Models/User.dart';
import 'package:amazon_clone/features/account/account_screen.dart';
import 'package:amazon_clone/features/providers/user_provider.dart';
import 'package:amazon_clone/features/screens/home_screen/home_screen.dart';
import "package:flutter/material.dart";
import "package:badges/badges.dart";
import "package:provider/provider.dart";

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
  static const screenName = "/bottom_bar";
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List pages = [
    HomeScreen(),
    AccountScreen(),
    Center(
      child: Text("Shopping cart page"),
    )
  ];

  void updatePage(int page) {
    print("Page is $page");
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final count = context.watch<UserProvider>().get().cart.length;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        onTap: updatePage,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
              label: "Home",
              icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 0
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth)),
                  ),
                  child: Icon(Icons.home_outlined))),
          BottomNavigationBarItem(
              label: "Account",
              icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 1
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth)),
                  ),
                  child: Icon(Icons.person_outline_outlined))),
          BottomNavigationBarItem(
            label: "Cart",
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _page == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth)),
              ),
              child: Badge(
                badgeStyle: const BadgeStyle(
                    elevation: 0, badgeColor: GlobalVariables.backgroundColor),
                badgeContent: Text("$count"),
                showBadge: true,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          )
        ],
      ),
    );
  }
}
