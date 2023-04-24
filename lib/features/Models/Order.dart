import 'package:amazon_clone/features/Models/product.dart';
import 'package:amazon_clone/features/cart/widgets/cart_product.dart';

class Order {
  String id;
  List<CartProduct> products;
  String address;
  String userId;
  int orderedAt;
  int status;

  Order({
    required this.id,
    required this.products,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      products: map['products'] as List<CartProduct>,
      address: map['address'] as String,
      userId: map['userId'] as String,
      orderedAt: map['orderedAt'] as int,
      status: map['status'] as int,
    );
  }
}
