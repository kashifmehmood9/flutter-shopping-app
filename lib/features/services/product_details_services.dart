import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Models/User.dart';
import '../Models/product.dart';
import '../providers/user_provider.dart';
import '../../Constants/Constants.dart';
import '../../Constants/error_handling.dart';
import '../../Constants/utils.dart';

class ProductDetailsService {
  addToCart({required BuildContext context, required Product product}) async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    try {
      String token = provider.get().token;
      Map<String, String> headers = GlobalVariables.headers;
      headers.addAll({GlobalVariables.JWTtokenKey: token});

      http.Response response = await http.post(
          Uri.parse("${GlobalVariables.localHostURI}/api/add-to-cart"),
          headers: GlobalVariables.headers,
          body: jsonEncode({"id": product.id}));

      httpErrorHandler(
          response: response,
          callback: () {
            User user = provider
                .get()
                .copyWith(cart: User.fromMap(jsonDecode(response.body)).cart);

            provider.set(user);
            debugPrint("Add to cart ${user.cart.first.quantity}");
          },
          context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void removeFromCart(
      {required BuildContext context, required Product product}) async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    try {
      String token = provider.get().token;
      Map<String, String> headers = GlobalVariables.headers;
      headers.addAll({GlobalVariables.JWTtokenKey: token});

      http.Response response = await http.delete(
          Uri.parse(
              "${GlobalVariables.localHostURI}/api/remove-from-cart/${product.id}"),
          headers: GlobalVariables.headers);

      httpErrorHandler(
          response: response,
          callback: () {
            User user = provider
                .get()
                .copyWith(cart: User.fromMap(jsonDecode(response.body)).cart);

            provider.set(user);
          },
          context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    try {
      String token = provider.get().token;
      Map<String, String> headers = GlobalVariables.headers;
      headers.addAll({GlobalVariables.JWTtokenKey: token});

      http.Response response = await http.post(
          Uri.parse("${GlobalVariables.localHostURI}/api/rate-product"),
          headers: GlobalVariables.headers,
          body: jsonEncode({"id": product.id, "rating": rating}));

      httpErrorHandler(response: response, callback: () {}, context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
