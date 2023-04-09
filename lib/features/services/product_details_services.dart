import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Models/product.dart';
import '../providers/user_provider.dart';
import '../../Constants/Constants.dart';
import '../../Constants/error_handling.dart';
import '../../Constants/utils.dart';

class ProductDetailsService {
  Future<void> rateProduct(
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
