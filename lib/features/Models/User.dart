class User {
  String id;
  String password;
  String name;
  String email;
  String address;
  String token;
  String type;

  User(
      {required this.id,
      required this.password,
      required this.name,
      required this.email,
      required this.address,
      required this.token,
      required this.type});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map["id"].toString(),
        password: map["password"].toString(),
        name: map["name"].toString(),
        email: map["email"].toString(),
        address: map["address"].toString(),
        token: map["token"].toString(),
        type: map["type"].toString());
  }
}
