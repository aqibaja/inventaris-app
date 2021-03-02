// To parse this JSON data, do
//
//     final failAddInventarisModel = failAddInventarisModelFromJson(jsonString);

import 'dart:convert';

FailAddInventarisModel failAddInventarisModelFromJson(String str) =>
    FailAddInventarisModel.fromJson(json.decode(str));

String failAddInventarisModelToJson(FailAddInventarisModel data) =>
    json.encode(data.toJson());

class FailAddInventarisModel {
  FailAddInventarisModel({
    this.status,
    this.error,
  });

  String status;
  String error;

  factory FailAddInventarisModel.fromJson(Map<String, dynamic> json) =>
      FailAddInventarisModel(
        status: json["status"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
      };
}
