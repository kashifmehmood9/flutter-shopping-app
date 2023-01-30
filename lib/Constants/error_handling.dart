import 'dart:convert';

import 'package:amazon_clone/Constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response response,
  required VoidCallback callback,
  required BuildContext context,
}) {
  switch (response.statusCode) {
    case 200:
      return callback();

    case 400 - 500:
      showSnackBar(context, jsonDecode(response.body)["msg"]);
  }
}
