import 'package:amazon_clone/features/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/product.dart';
import '../../services/product_details_services.dart';

class CartProduct extends StatefulWidget {
  final int index;
  CartProduct({Key? key, required this.index}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final productDetailsService = ProductDetailsService();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().get();
    final cartProduct = user.cart[widget.index];
    print(cartProduct.quantity);
    print(user.cart[widget.index].quantity);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12)),
            child: Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 8)),
                Image.network(
                  cartProduct.product.images.first,
                  fit: BoxFit.fitWidth,
                  height: 135,
                  width: 135,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        cartProduct.product.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "${cartProduct.product.price}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "Eligible for FREE shipping",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "In Stock",
                        style: TextStyle(fontSize: 16, color: Colors.teal),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(left: 4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        productDetailsService.removeFromCart(
                            context: context, product: cartProduct.product);
                      },
                      child: Container(
                        height: 32,
                        width: 35,
                        alignment: Alignment.center,
                        child: Icon(Icons.remove),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.5),
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.white),
                      child: Container(
                        height: 32,
                        width: 35,
                        alignment: Alignment.center,
                        child: Text("${cartProduct.quantity}"),
                      ),
                    ),
                    Container(
                      height: 32,
                      width: 35,
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Icon(Icons.add),
                        onTap: () async {
                          await productDetailsService.addToCart(
                              context: context, product: cartProduct.product);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
