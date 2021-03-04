// To parse this JSON data, do
//
//     final failAddInventarisModel = failAddInventarisModelFromJson(jsonString);

import 'dart:convert';

FailInventarisModel failAddInventarisModelFromJson(String str) =>
    FailInventarisModel.fromJson(json.decode(str));

String failAddInventarisModelToJson(FailInventarisModel data) =>
    json.encode(data.toJson());

class FailInventarisModel {
  FailInventarisModel({
    this.status,
    this.error,
  });

  String status;
  String error;

  factory FailInventarisModel.fromJson(Map<String, dynamic> json) =>
      FailInventarisModel(
        status: json["status"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
      };
}
