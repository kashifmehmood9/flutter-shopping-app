import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../Constants/Constants.dart';
import '../../Constants/error_handling.dart';
import '../../Constants/utils.dart';
import '../Models/User.dart';
import '../Models/product.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class AddressService {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('${GlobalVariables.localHostURI}/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.get().token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      httpErrorHandler(
        response: res,
        context: context,
        callback: () {
          User user = userProvider.get().copyWith(
                address: jsonDecode(res.body)['address'],
              );

          userProvider.set(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder(
      {required BuildContext context,
      required double totalSum,
      required String address}) async {
    final provider = Provider.of<UserProvider>(context, listen: false);

    String token = provider.get().token;

    Map<String, String> headers = GlobalVariables.headers;
    headers.addAll({GlobalVariables.JWTtokenKey: token});

    try {
      debugPrint("provider.get().cart ${provider.get().cart.length}");
      http.Response response = await http.post(
          Uri.parse("${GlobalVariables.localHostURI}/api/order"),
          headers: headers,
          body: localJSONEncode(provider, totalSum, address));
      // debugPrint("Got Product response $response");
      httpErrorHandler(
          response: response,
          callback: () {
            showSnackBar(context, "Order has been created");
            User user = provider.get().copyWith(cart: []);
            provider.set(user);
            Navigator.pop(context);
          },
          context: context);
    } catch (e) {
      showSnackBar(context, e.toString());
      debugPrint("Got Error while getting products ${e.toString()}");
    }
  }

  String localJSONEncode(
      UserProvider provider, double totalSum, String address) {
    debugPrint("Encoding cart ${jsonEncode(provider.get().cart)}");
    return jsonEncode({
      'cart': provider.get().cart,
      'totalPrice': totalSum,
      'address': address
    });
  }
}
