import "dart:convert";

import 'package:amazon_clone/features/Models/rating.dart';
import 'package:flutter/cupertino.dart';

class Product {
  final String name;
  final String description;
  final int quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  final List<Rating>? rating;

  Product(
      {required this.name,
      required this.description,
      required this.quantity,
      required this.images,
      required this.category,
      required this.price,
      this.id,
      this.rating});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map["name"].toString(),
      description: map["description"].toString(),
      quantity: map["quantity"],
      images: map["images"].cast<String>(),
      category: map["category"].toString(),
      price: double.parse(map["price"].toString()),
      id: map["_id"].toString(),
      rating: map["ratings"]
          .map(
            (x) {
              return Rating.fromMap(x);
            },
          )
          .toList()
          .cast<Rating>(),
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
    return map;
  }
}
