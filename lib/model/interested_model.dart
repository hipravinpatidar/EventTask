// To parse this JSON data, do
//
//     final interestedModel = interestedModelFromJson(jsonString);

import 'dart:convert';

InterestedModel interestedModelFromJson(String str) => InterestedModel.fromJson(json.decode(str));

String interestedModelToJson(InterestedModel data) => json.encode(data.toJson());

class InterestedModel {
  int status;
  String message;
  int recode;
  List<dynamic> data;

  InterestedModel({
    required this.status,
    required this.message,
    required this.recode,
    required this.data,
  });

  factory InterestedModel.fromJson(Map<String, dynamic> json) => InterestedModel(
    status: json["status"],
    message: json["message"],
    recode: json["recode"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "recode": recode,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
