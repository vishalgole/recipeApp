import 'package:dio/dio.dart';
import 'package:recipe_app/src/model/food_category_model.dart';
import 'package:recipe_app/src/service/utils/constants.dart';

class FoodCategoryApi {
  final Dio _dio = Dio();

  Future<FoodCategoriesModel> fetchFoodCategories() async {
    try {
      Response response = await _dio.get(food_cat_url);
      return FoodCategoriesModel.fromJson(response.data);
    } catch (e) {
      print("Error $e");
      return FoodCategoriesModel.withError("Data not found");
    }
  }
}
