class User {
  String username;
  String password;
  String id;

  User({this.username, this.password, this.id});

  toMap() => {
    "username": this.username,
    "password": this.password,
    "_id": this.id
  };

  fromMap(Map<String, dynamic> map) {
    this.username = map["username"];
    this.password = map["password"];
    this.id = map["_id"];
  }
}