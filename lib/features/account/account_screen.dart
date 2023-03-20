import 'package:amazon_clone/Constants/Constants.dart';
import 'package:amazon_clone/features/screens/widgets/app_bar_hello_widget.dart';
import 'package:amazon_clone/features/screens/widgets/orders.dart';
import 'package:amazon_clone/features/screens/widgets/top_buttons.dart';
import "package:flutter/material.dart";

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(42),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                "assets/images/amazon_in.png",
                width: 120,
                height: 45,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search),
                  ],
                ))
          ]),
        ),
      ),
      body: Column(
        children: const [
          AppBarHelloTextWidget(),
          SizedBox(
            height: 10,
          ),
          TopButton(),
          SizedBox(
            height: 20,
          ),
          Orders()
        ],
      ),
    );
  }
}
