import 'dart:convert';

import 'package:amazon_clone/features/Models/User.dart';
import 'package:amazon_clone/features/providers/user_provider.dart';
import 'package:amazon_clone/features/widgets/bottom_bar.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import "package:provider/provider.dart";
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/Constants.dart';
import '../../Constants/error_handling.dart';
import '../../Constants/utils.dart';

enum Auth { signin, signup }

class AuthService {
  void signupUser({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      var user = User(
          id: "",
          password: password,
          name: username,
          email: email,
          address: "",
          token: "",
          type: "");
      http.Response response = await http.post(
        Uri.parse('${GlobalVariables.localHostURI}/api/signup'),
        body: user.encode(),
        headers: GlobalVariables.headers,
      );

      httpErrorHandler(
          response: response,
          callback: () {
            showSnackBar(context,
                "User added successfully. Please login using the same credentials.");
          },
          context: context);
    } catch (error) {
      print("Caught error ${error}");

      showSnackBar(context, error.toString());
    }
  }

  void signinUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      var user = User(
          id: "",
          password: password,
          name: "",
          email: email,
          address: "",
          token: "",
          type: "");

      http.Response response = await http.post(
        Uri.parse('${GlobalVariables.localHostURI}/api/signin'),
        body: user.encode(),
        headers: GlobalVariables.headers,
      );
      user = User.fromMap(jsonDecode(response.body));

      httpErrorHandler(
          response: response,
          callback: () async {
            showSnackBar(context, "User sign in successfully.");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).set(user);
            prefs.setString("x-auth-token", user.token);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.screenName, (router) => false);
          },
          context: context);
    } catch (error) {
      print("Caught error ${error}");

      showSnackBar(context, error.toString());
    }
  }

  void getUserData({required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(GlobalVariables.JWTtokenKey);

    if (token == null) {
      prefs.setString(GlobalVariables.JWTtokenKey, "");
    }

    Map<String, String> headers = GlobalVariables.headers;
    headers.addAll({GlobalVariables.JWTtokenKey: token!});
    var tokenResponse = await http.post(
      Uri.parse("${GlobalVariables.localHostURI}/api/tokenIsValid"),
      headers: headers,
    );

    if (jsonDecode(tokenResponse.body)) {
      http.Response userResponse = await http.get(
          Uri.parse("${GlobalVariables.localHostURI}/api/users"),
          headers: headers);
      var user = User.fromMap(jsonDecode(userResponse.body));
      Provider.of<UserProvider>(context, listen: false).set(user);
    }
  }
}
