import 'package:amazon_clone/features/widgets/stars.dart';
import 'package:flutter/material.dart';

import '../Models/product.dart';

class SearchedProduct extends StatelessWidget {
  SearchedProduct({Key? key, required this.searchedProduct}) : super(key: key);
  Product searchedProduct;
  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    searchedProduct.rating?.forEach((element) {
      totalRating += double.parse(element.rating);
    });

    double averageRating = totalRating / searchedProduct.rating!.length;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                searchedProduct.images[0],
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
                      searchedProduct.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Stars(rating: averageRating),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "${searchedProduct.price}",
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
        )
      ],
    );
  }
}
