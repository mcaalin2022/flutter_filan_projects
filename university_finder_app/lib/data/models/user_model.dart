
class UserModel {
  String? sId;
  String? name;
  String? email;
  String? token;
  String? role;

  UserModel({this.sId, this.name, this.email, this.token, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['token'] = token;
    data['role'] = role;
    return data;
  }
}
