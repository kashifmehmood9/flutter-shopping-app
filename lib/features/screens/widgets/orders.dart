import 'package:amazon_clone/Constants/Constants.dart';
import 'package:amazon_clone/features/providers/user_provider.dart';
import 'package:amazon_clone/features/screens/widgets/single_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:amazon_clone/features/Models/cart.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    List<CartProductModel> list = context.watch<UserProvider>().get().cart;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Your Orders",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "All Orders",
                style: TextStyle(
                    color: GlobalVariables.selectedNavBarColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        Container(
          height: 176,
          padding: const EdgeInsets.only(left: 10, right: 0, top: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: ((context, index) {
              print(list[index]);
              return SingleProduct(image: list[index].product.images.first);
            }),
          ),
        ),
      ],
    );
  }
}
