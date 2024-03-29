// To parse this JSON data, do
//
//     final foodCategoriesModel = foodCategoriesModelFromJson(jsonString);

import 'dart:convert';

String? error;
FoodCategoriesModel foodCategoriesModelFromJson(String str) =>
    FoodCategoriesModel.fromJson(json.decode(str));

//  factory FoodCategoriesModel.withError(String errorMessage) {
//     error = errorMessage;
//   }

String foodCategoriesModelToJson(FoodCategoriesModel data) =>
    json.encode(data.toJson());

class FoodCategoriesModel {
  FoodCategoriesModel({
    required this.categories,
  });

  List<Category>? categories;

  FoodCategoriesModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory FoodCategoriesModel.fromJson(Map<String, dynamic> json) =>
      FoodCategoriesModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        idCategory: json["idCategory"],
        strCategory: json["strCategory"],
        strCategoryThumb: json["strCategoryThumb"],
        strCategoryDescription: json["strCategoryDescription"],
      );

  Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription": strCategoryDescription,
      };
}
