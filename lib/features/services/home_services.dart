import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../Constants/Constants.dart';
import '../../Constants/error_handling.dart';
import '../../Constants/utils.dart';
import '../Models/product.dart';
import '../providers/user_provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts(
      BuildContext context, String category) async {
    final provider = Provider.of<UserProvider>(context, listen: false);

    String token = provider.get().token;

    Map<String, String> headers = GlobalVariables.headers;
    headers.addAll({GlobalVariables.JWTtokenKey: token});

    List<Product> productList = [];
    try {
      http.Response response = await http.get(
          Uri.parse(
              "${GlobalVariables.localHostURI}/api/products?category=$category"),
          headers: headers);
      debugPrint("Got Product response $response");
      httpErrorHandler(
          response: response,
          callback: () {
            productList = jsonDecode(response.body)
                .map((element) {
                  return Product.fromMap(element);
                })
                .toList()
                .cast<Product>();
          },
          context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
      debugPrint(
          "Got Error while getting products by categories ${e.toString()}");
    }
    return productList;
  }

  Future<Product> fetchDealsOfTheDay(BuildContext context) async {
    final provider = Provider.of<UserProvider>(context, listen: false);

    String token = provider.get().token;

    Map<String, String> headers = GlobalVariables.headers;
    headers.addAll({GlobalVariables.JWTtokenKey: token});
    Product product = Product(
        name: "",
        description: "",
        quantity: 1,
        images: [],
        category: "",
        price: 0.0);
    try {
      http.Response response = await http.get(
          Uri.parse(
            "${GlobalVariables.localHostURI}/api/deal-of-day",
          ),
          headers: headers);

      httpErrorHandler(
          response: response,
          callback: () {
            product = Product.fromMap(jsonDecode(response.body)["product"]);
          },
          context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
      debugPrint("Got Error while getting deals of the day ${e.toString()}");
    }
    return product;
  }
}
