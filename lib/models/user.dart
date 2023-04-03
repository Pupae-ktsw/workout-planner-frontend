class User {
  String? id;
  String? email;
  String? name;
  String? password;

  User({this.id, this.email, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    return data;
  }
}
