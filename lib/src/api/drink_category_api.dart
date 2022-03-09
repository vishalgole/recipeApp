import 'package:dio/dio.dart';
import 'package:recipe_app/src/model/drink_category_model.dart';
import 'package:recipe_app/src/service/utils/constants.dart';

class DrinkCategoryApi {
  final Dio _dio = Dio();

  Future<DrinkCategoriesModel> fetchDrinkCategories() async {
    try {
      Response response = await _dio.get(drink_cat_url);
      return DrinkCategoriesModel.fromJson(response.data);
    } catch (e) {
      return DrinkCategoriesModel.withError("Data not found");
    }
  }
}
