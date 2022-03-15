import 'package:dio/dio.dart';
import 'package:recipe_app/src/model/detailed_food_model.dart';
import 'package:recipe_app/src/service/utils/constants.dart';

class DetailedFoodApi {
  final Dio _dio = Dio();

  Future<DetailedFoodModel> fetchDetailedFoodData(String? selectedId) async {
    try {
      print("selected drink id $selectedId");
      Response response = await _dio.get(detailed_food_url + selectedId!);
      return DetailedFoodModel.fromJson(response.data);
    } catch (e) {
      return DetailedFoodModel.withError("Data not found");
    }
  }
}
