import 'package:amazon_clone/features/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/product.dart';
import '../../services/product_details_services.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({Key? key, required this.index}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final productDetailsService = ProductDetailsService();

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().get().cart[widget.index];
    final product = Product.fromMap(productCart["product"]);
    final quantity = productCart["quantity"];
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitWidth,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "${product.price}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text(
                      "Eligible for FREE shipping",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    width: 235,
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
        Container(
          margin: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        productDetailsService.removeFromCart(
                            context: context, product: product);
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
                        child: Text("$quantity"),
                      ),
                    ),
                    Container(
                      height: 32,
                      width: 35,
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Icon(Icons.add),
                        onTap: () {
                          productDetailsService.addToCart(
                              context: context, product: product);
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
