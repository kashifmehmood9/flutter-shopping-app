import 'dart:io';

import 'package:amazon_clone/Constants/Constants.dart';
import 'package:amazon_clone/Constants/error_handling.dart';
import 'package:amazon_clone/Constants/utils.dart';
import 'package:amazon_clone/features/Models/User.dart';
import 'package:amazon_clone/features/Models/product.dart';
import 'package:amazon_clone/features/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
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
          Uri.parse(GlobalVariables.localHostURI + "/admin/add-product"),
          headers: GlobalVariables.headers,
          body: product.encode());

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
}
