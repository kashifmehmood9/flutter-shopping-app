import 'dart:convert';

import 'package:flutter/cupertino.dart';

class User implements Copyable {
  String id;
  String password;
  String name;
  String email;
  String address;
  String token;
  String type;
  final List<dynamic> cart;

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
      cart: List<Map<String, dynamic>>.from(
        map["cart"].map(
          (e) => Map<String, dynamic>.from(e),
        ),
      ),
    );
  }

  String encode() {
    return jsonEncode(toMap());
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["_id"] = id;
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
    // TODO: implement copyWith
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
