import 'package:dio/dio.dart';
import 'package:recipe_app/src/model/selected_drink_category_model.dart';
import 'package:recipe_app/src/service/utils/constants.dart';

class SelectedDrinkCategoryApi {
  final Dio _dio = Dio();

  Future<SelectedDrinkCategoriesModel> fetchSelectedDrinkCategoryData(
      String? category) async {
    try {
      Response response = await _dio.get(selected_drink_cat_url + category!);
      return SelectedDrinkCategoriesModel.fromJson(response.data);
    } catch (e) {
      return SelectedDrinkCategoriesModel.withError("Data not found");
    }
  }
}
