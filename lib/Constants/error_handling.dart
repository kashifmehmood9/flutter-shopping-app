import 'dart:convert';

import 'package:flutter_shopping_app/Constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void prettyPrintJson(String input) {
  const JsonDecoder decoder = JsonDecoder();
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final dynamic object = decoder.convert(input);
  final dynamic prettyString = encoder.convert(object);
  prettyString.split('\n').forEach((dynamic element) => debugPrint(element));
}

void httpErrorHandler({
  required http.Response response,
  required VoidCallback callback,
  required BuildContext context,
}) {
  debugPrint(response.request?.url.toString());
  debugPrint(response.request?.headers.toString());
  prettyPrintJson(response.body);
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
