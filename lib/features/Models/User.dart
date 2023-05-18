import 'dart:convert';

import 'package:amazon_clone/features/Models/product.dart';
import 'package:flutter/cupertino.dart';

import 'cart.dart';

class User implements Copyable {
  String id;
  String password;
  String name;
  String email;
  String address;
  String token;
  String type;
  List<dynamic> cart;

  User(
      {required this.id,
      required this.password,
      required this.name,
      required this.email,
      required this.address,
      required this.token,
      required this.type,
      required this.cart});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["_id"].toString(),
      password: map["password"].toString(),
      name: map["name"].toString(),
      email: map["email"].toString(),
      address: map["address"].toString(),
      token: map["token"].toString(),
      type: map["type"].toString(),
      cart: List<dynamic>.from(
        map["cart"].map((e) {
          return CartProductModel(
              product: Product.fromMap(e["product"]), quantity: e["quantity"]);
        }),
      ),
    );
  }

  String encode() {
    debugPrint("Encoding user : ${jsonEncode(toMap())}");
    return jsonEncode(toMap());
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["password"] = password;
    map["name"] = name;
    map["email"] = email;
    map["address"] = address;
    map["token"] = token;
    map["type"] = type;
    map["type"] = cart;
    debugPrint("Map after encoding: $map");
    return map;
  }

  @override
  User copyWith(
      {String? id,
      String? password,
      String? name,
      String? email,
      String? address,
      String? token,
      String? type,
      List<dynamic>? cart}) {
    return User(
        id: id ?? this.id,
        password: password ?? this.password,
        name: name ?? this.name,
        email: email ?? this.email,
        address: address ?? this.address,
        token: token ?? this.token,
        type: type ?? this.type,
        cart: cart ?? this.cart);
  }
}

abstract class Copyable<T> {
  T copyWith();
}
