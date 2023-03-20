class User {
  String? id;
  String? email;
  String? password;
  String? name;

  User({this.id, this.email, this.password, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    return data;
  }
}
