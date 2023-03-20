import 'package:amazon_clone/features/screens/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {
  const TopButton({Key? key}) : super(key: key);

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
            AccountButton(text: "Logout", onTap: () {}),
            AccountButton(text: "WishList", onTap: () {})
          ],
        )
      ],
    );
  }
}
