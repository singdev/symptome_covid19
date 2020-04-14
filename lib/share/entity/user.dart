class User {
  String username;
  String password;

  User({this.username, this.password});

  toMap() => {
    "username": this.username,
    "password": this.password
  };

  fromMap(Map<String, dynamic> map) {
    this.username = map["username"];
    this.password = map["password"];
  }
}