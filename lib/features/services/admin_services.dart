import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/Constants/Constants.dart';
import 'package:amazon_clone/Constants/error_handling.dart';
import 'package:amazon_clone/Constants/utils.dart';
import 'package:amazon_clone/features/Models/product.dart';
import 'package:amazon_clone/features/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  Future<void> sellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic("dyi1yv5vm", "n3fpo8xq");
      List<String> imageUrls = [];

      for (var element in images) {
        CloudinaryResponse response = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(element.path, folder: name));
        imageUrls.add(response.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);

      String token = provider.get().token;
      Map<String, String> headers = GlobalVariables.headers;
      headers.addAll({GlobalVariables.JWTtokenKey: token});

      http.Response response = await http.post(
          Uri.parse("${GlobalVariables.localHostURI}/admin/add-product"),
          headers: GlobalVariables.headers,
          body: product.toJson());

      httpErrorHandler(
          response: response,
          callback: () {
            showSnackBar(context, "Success!");
            Navigator.pop(context);
          },
          context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> getAllProducts(BuildContext context) async {
    final provider = Provider.of<UserProvider>(context, listen: false);

    String token = provider.get().token;

    Map<String, String> headers = GlobalVariables.headers;
    headers.addAll({GlobalVariables.JWTtokenKey: token});

    List<Product> productList = [];
    try {
      http.Response response = await http.get(
          Uri.parse("${GlobalVariables.localHostURI}/admin/get-products"),
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
      debugPrint("Got Error while getting products ${e.toString()}");
    }
    return productList;
  }

  Future<void> deleteProduct(
      BuildContext context, Product product, VoidCallback onSuccess) async {
    try {
      debugPrint("Deleting");
      final provider = Provider.of<UserProvider>(context, listen: false);

      String token = provider.get().token;

      Map<String, String> headers = GlobalVariables.headers;
      headers.addAll({GlobalVariables.JWTtokenKey: token});
      http.Response response = await http.delete(
          Uri.parse("${GlobalVariables.localHostURI}/admin/delete-product"),
          headers: headers,
          body: jsonEncode({"id": product.id}));
      debugPrint("response received: " + response.body);
      httpErrorHandler(
          response: response,
          callback: () {
            debugPrint("response received: " + response.body);
            onSuccess();
          },
          context: context);
      // return response.body;
    } catch (e) {
      debugPrint("Got Error while deleting product ${e.toString()}");
      showSnackBar(context, e.toString());
    }
  }
}
