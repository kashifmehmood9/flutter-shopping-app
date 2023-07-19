import 'package:flutter_shopping_app/features/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().get();
    double sum = 0;

    for (var e in user.cart) {
      sum += e.product.price * e.quantity;
    }
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Text(
            'Subtotal',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '\$ $sum',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
