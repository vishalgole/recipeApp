import 'package:dio/dio.dart';
import 'package:recipe_app/src/model/selected_category_model.dart';
import 'package:recipe_app/src/service/utils/constants.dart';

class SelectedCategoryApi {
  final Dio _dio = Dio();

  Future<SelectedCategoriesModel> fetchSelectedCategoryData(
      String? category) async {
    try {
      Response response = await _dio.get(selected_cat_url + category!);
      return SelectedCategoriesModel.fromJson(response.data);
    } catch (e) {
      return SelectedCategoriesModel.withError("Data not found");
    }
  }
}
