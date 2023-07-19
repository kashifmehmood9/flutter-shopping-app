import 'package:flutter_shopping_app/features/admin_screens/posts_screen.dart';
import 'package:flutter/material.dart';
import '../../Constants/Constants.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  static const screenName = "/admin_screen";
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List pages = [
    PostsScreen(),
    Center(
      child: Text("Analytics page"),
    ),
    Center(
      child: Text("Cart page"),
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
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                "assets/images/amazon_in.png",
                width: 120,
                height: 45,
              ),
            ),
            const Text(
              "Admin",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
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
              label: "Posts",
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
              label: "Analytics",
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
                  child: Icon(Icons.analytics_outlined))),
          BottomNavigationBarItem(
              label: "Orders",
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
                  child: Icon(Icons.all_inbox_outlined)))
        ],
      ),
    );
  }
}
