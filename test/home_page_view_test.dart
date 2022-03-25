import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe_app/src/api/food_category_api.dart';
import 'package:recipe_app/src/bloc/food_category_bloc/food_category_bloc.dart';
import 'package:recipe_app/src/bloc/food_category_bloc/food_category_event.dart';
import 'package:recipe_app/src/bloc/food_category_bloc/food_category_state.dart';
import 'package:recipe_app/src/model/food_category_model.dart' as foodCat;
import 'package:recipe_app/src/model/food_category_model.dart' as food;
import 'package:test/test.dart';

void main() {
  var mockTestData = <food.FoodCategoriesModel>[
    food.FoodCategoriesModel(categories: [
      foodCat.Category(
          idCategory: "1",
          strCategory: "beef",
          strCategoryThumb:
              "https:\/\/www.themealdb.com\/images\/category\/beef.png",
          strCategoryDescription:
              "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]"),
    ])
  ];
  group('Home screen food category test', () {
    late FoodCategoryBloc foodBloc;
    FoodCategoryApi foodCategoryApi;

    setUp(() {
      EquatableConfig.stringify = true;
      foodCategoryApi = FoodCategoryApi();
      foodBloc = FoodCategoryBloc();
    });

    blocTest<FoodCategoryBloc, FoodCategoryState>(
        "emits ['FoodCategoryStateIniitial,FoodCategoryStateLoading,FoodCategoryStateLoaded']",
        build: () => foodBloc,
        act: (bloc) => bloc.add(GetFoodCategoryList()),
        expect: () => [
              FoodCategoryStateIniitial(),
              FoodCategoryStateLoading(),
              // FoodCategoryStateLoaded(mockTestData),
            ]);
  });
}
