import 'package:flutter_shopping_app/features/screens/auth_screen.dart';
import 'package:flutter_shopping_app/features/screens/widgets/account_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/features/services/account_services.dart';
import 'package:flutter_shopping_app/features/services/auth_service.dart';

class TopButton extends StatelessWidget {
  TopButton({Key? key}) : super(key: key);
  final AuthService service = AuthService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Orders", onTap: () {}),
            AccountButton(text: "Turn seller", onTap: () {})
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
                text: "Logout",
                onTap: () {
                  service.signOutUser();
                  Navigator.pushNamedAndRemoveUntil(
                      context, AuthScreen.screenName, (route) => false);
                }),
            AccountButton(text: "WishList", onTap: () {})
          ],
        )
      ],
    );
  }
}
