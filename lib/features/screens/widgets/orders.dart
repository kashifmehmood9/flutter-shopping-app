import 'package:flutter_shopping_app/Constants/Constants.dart';
import 'package:flutter_shopping_app/features/providers/user_provider.dart';
import 'package:flutter_shopping_app/features/screens/widgets/single_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopping_app/features/Models/cart.dart';

import '../../services/account_services.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  AccountServices accountServices = AccountServices();
  List<CartProductModel> list = [];

  @override
  void initState() {
    super.initState();
    // fetchAllOrders();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    fetchAllOrders();
    // });
    print("Initialized 1");
  }

  void fetchAllOrders() async {
    list = await accountServices.fetchAllOrders(context);
    print("Initialized 2");
    setState(() {});
    print("Initialized 3");
  }

  @override
  Widget build(BuildContext context) {
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
              return SingleProduct(image: list[index].product.images.first);
            }),
          ),
        ),
      ],
    );
  }
}
