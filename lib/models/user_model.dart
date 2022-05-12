import 'dart:convert';

List<UserModel> modelUserFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String modelUserToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  String? error;

  UserModel.withError(String errorMessage) {
    error = errorMessage;
  }

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
      };
}
