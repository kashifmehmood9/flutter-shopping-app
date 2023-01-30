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

  String encode(Map<String, dynamic> map) {
    return encode(map);
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = this.id;
    map["password"] = this.password;
    map["name"] = this.name;
    map["email"] = this.email;
    map["address"] = this.address;
    map["token"] = this.token;
    map["type"] = this.type;
    return map;
  }
}
