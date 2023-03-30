import "dart:convert";

import 'package:flutter/cupertino.dart';

class Product {
  final String name;
  final String description;
  final int quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;

  Product(
      {required this.name,
      required this.description,
      required this.quantity,
      required this.images,
      required this.category,
      required this.price,
      this.id});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map["name"].toString(),
      description: map["description"].toString(),
      quantity: map["quantity"],
      images: map["images"].cast<String>(),
      category: map["category"].toString(),
      price: double.parse(map["price"].toString()),
      id: map["_id"].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["description"] = description;
    map["quantity"] = quantity;
    map["images"] = images;
    map["category"] = category;
    map["price"] = price;
    map["_id"] = id;

    debugPrint("Product Map after encoding: $map");
    return map;
  }
}
