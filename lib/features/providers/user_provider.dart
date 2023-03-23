import 'package:amazon_clone/features/Models/User.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      token: '');

  User get() => _user;

  void set(User user) {
    _user = user;
    notifyListeners();
  }
}
