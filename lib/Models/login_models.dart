// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.user,
    this.apiToken,
  });

  User user;
  String apiToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        apiToken: json["api_token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "api_token": apiToken,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.noHp,
    this.password,
    this.apiToken,
    this.dateCreate,
    this.dateEdit,
  });

  int id;
  String name;
  String email;
  String gender;
  String noHp;
  String password;
  String apiToken;
  DateTime dateCreate;
  DateTime dateEdit;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        gender: json["gender"],
        noHp: json["no_hp"],
        password: json["password"],
        apiToken: json["api_token"],
        dateCreate: DateTime.parse(json["date_create"]),
        dateEdit: DateTime.parse(json["date_edit"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "gender": gender,
        "no_hp": noHp,
        "password": password,
        "api_token": apiToken,
        "date_create": dateCreate.toIso8601String(),
        "date_edit": dateEdit.toIso8601String(),
      };
}
