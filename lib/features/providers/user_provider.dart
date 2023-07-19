import 'package:flutter_shopping_app/features/Models/User.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      token: '',
      cart: []);

  User get() => _user;

  void set(User user) {
    _user = user;
    notifyListeners();
  }
}
