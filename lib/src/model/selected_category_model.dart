// To parse this JSON data, do
//
//     final selectedCategoriesModel = selectedCategoriesModelFromJson(jsonString);

import 'dart:convert';

String? error;
SelectedCategoriesModel selectedCategoriesModelFromJson(String str) =>
    SelectedCategoriesModel.fromJson(json.decode(str));

String selectedCategoriesModelToJson(SelectedCategoriesModel data) =>
    json.encode(data.toJson());

class SelectedCategoriesModel {
  SelectedCategoriesModel({
    required this.meals,
  });

  late final List<Meal> meals;

  SelectedCategoriesModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory SelectedCategoriesModel.fromJson(Map<String, dynamic> json) =>
      SelectedCategoriesModel(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class Meal {
  Meal({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  final String strMeal;
  final String strMealThumb;
  final String idMeal;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
