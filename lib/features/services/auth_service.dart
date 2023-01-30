import 'package:amazon_clone/features/Models/User.dart';
import 'package:http/http.dart' as http;

import '../../Constants/Constants.dart';

class AuthService {
  void signupUser({
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
          Uri.parse('${localHostURI} /api/signup'),
          body: user.encode(user.toMap()),
          headers: {"Content-Type": "application/json; charset=UTF-8"});

      print(response);
    } catch (error) {
      print(error);
    }
  }
}
