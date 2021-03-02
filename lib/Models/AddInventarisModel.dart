// To parse this JSON data, do
//
//     final addInventarisModel = addInventarisModelFromJson(jsonString);

import 'dart:convert';

AddInventarisModel addInventarisModelFromJson(String str) =>
    AddInventarisModel.fromJson(json.decode(str));

String addInventarisModelToJson(AddInventarisModel data) =>
    json.encode(data.toJson());

class AddInventarisModel {
  AddInventarisModel({
    this.success,
    this.message,
  });

  String success;
  String message;

  factory AddInventarisModel.fromJson(Map<String, dynamic> json) =>
      AddInventarisModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
