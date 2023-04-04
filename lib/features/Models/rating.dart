import 'dart:convert';

import 'package:flutter/foundation.dart';

class Rating {
  final String userId;
  final String rating;
  Rating({required this.userId, required this.rating});

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(userId: map['userId'], rating: map['rating'].toString());
  }

  Map<String, dynamic> toMap() {
    return {"userId": this.userId, "rating": this.rating};
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
