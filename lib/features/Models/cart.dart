import 'dart:convert';

import 'package:amazon_clone/features/Models/product.dart';

class CartProductModel {
  Product product;
  int quantity;

  CartProductModel({required this.product, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'product': this.product,
      'quantity': this.quantity,
    };
  }

  String toJson() => json.encode(toMap());

  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      product: map['product'] as Product,
      quantity: map['quantity'] as int,
    );
  }
}
