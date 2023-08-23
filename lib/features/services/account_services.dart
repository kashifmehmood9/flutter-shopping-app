import 'package:flutter_shopping_app/Constants/Constants.dart';
import 'package:flutter_shopping_app/Constants/error_handling.dart';
import 'package:flutter_shopping_app/features/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/cart.dart';

class AccountServices {
  Future<List<CartProductModel>> fetchAllOrders(BuildContext context) async {
    var provider = Provider.of<UserProvider>(context, listen: false);

    var response = await http.get(
      Uri.parse(
        "${GlobalVariables.localHostURI}/api/fetchMyOrders",
      ),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': provider.get().token,
      },
    );
    var list = [];
    httpErrorHandler(
        response: response,
        callback: () {
          // list = response.body["products"];
        },
        context: context);

    return [];
  }
}
