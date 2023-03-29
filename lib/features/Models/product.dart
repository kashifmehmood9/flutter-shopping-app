import "dart:convert";

class Product {
  final String name;
  final String description;
  final double quantity;
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
      images: map["images"],
      category: map["category"].toString(),
      price: map["price"],
      id: map["_id"].toString(),
    );
  }

  String encode() {
    return jsonEncode(toMap());
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["quantity"] = quantity;
    map["images"] = images;
    map["category"] = category;
    map["price"] = price;
    map["_id"] = id;

    print("Product Map after encoding: $map");
    return map;
  }
}
