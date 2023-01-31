import 'package:amazon_clone/features/Models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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
      // print("Got user name" + password + email + username);
      // print(Uri.parse('${localHostURI} /api/signup'));

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
}
