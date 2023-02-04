import 'package:amazon_clone/Constants/Constants.dart';
import 'package:amazon_clone/features/providers/user_provider.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class AppBarHelloTextWidget extends StatelessWidget {
  const AppBarHelloTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).get();

    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        children: [
          RichText(
              text: TextSpan(
                  text: "Hello, ${user?.name}!",
                  style: TextStyle(color: Colors.black, fontSize: 22.0))),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
