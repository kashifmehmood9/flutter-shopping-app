import 'package:flutter/material.dart';

import '../Models/product.dart';

class SearchedProduct extends StatefulWidget {
  SearchedProduct({Key? key, required this.searchedProduct}) : super(key: key);
  Product searchedProduct;
  @override
  State<SearchedProduct> createState() => _SearchedProductState();
}

class _SearchedProductState extends State<SearchedProduct> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                widget.searchedProduct.images[0],
                fit: BoxFit.fitHeight,
                height: 135,
                width: 135,
              )
            ],
          ),
        )
      ],
    );
  }
}
