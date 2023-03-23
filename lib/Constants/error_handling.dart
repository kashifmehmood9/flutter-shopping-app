import 'dart:convert';

import 'package:amazon_clone/Constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response response,
  required VoidCallback callback,
  required BuildContext context,
}) {
  print("Response status code : ${response.statusCode}");
  print(response.body);
  switch (response.statusCode) {
    case 200:
      return callback();

    case 400:
      showSnackBar(context, jsonDecode(response.body)["message"]);
      break;

    case 500:
      showSnackBar(context, jsonDecode(response.body)["error"]);
      break;

    default:
      // showSnackBar(context, jsonDecode(response.body));
      break;
  }
}
