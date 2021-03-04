// To parse this JSON data, do
//
//     final loginFailModel = loginFailModelFromJson(jsonString);

import 'dart:convert';

LoginFailModel loginFailModelFromJson(String str) =>
    LoginFailModel.fromJson(json.decode(str));

String loginFailModelToJson(LoginFailModel data) => json.encode(data.toJson());

class LoginFailModel {
  LoginFailModel({
    this.success,
    this.message,
  });

  bool success;
  String message;

  factory LoginFailModel.fromJson(Map<String, dynamic> json) => LoginFailModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
