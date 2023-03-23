class User {
  String? id;
  String? email;
  String? name;

  User({this.id, this.email, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['email'] = email;
    data['name'] = name;
    return data;
  }
}
