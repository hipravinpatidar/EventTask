// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  int status;
  String message;
  int recode;
  List<Category> data;

  CategoryModel({
    required this.status,
    required this.message,
    required this.recode,
    required this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    status: json["status"],
    message: json["message"],
    recode: json["recode"],
    data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "recode": recode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Category {
  String enCategoryName;
  String hiCategoryName;
  int id;
  String image;

  Category({
    required this.enCategoryName,
    required this.hiCategoryName,
    required this.id,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    enCategoryName: json["en_category_name"],
    hiCategoryName: json["hi_category_name"],
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "en_category_name": enCategoryName,
    "hi_category_name": hiCategoryName,
    "id": id,
    "image": image,
  };
}
