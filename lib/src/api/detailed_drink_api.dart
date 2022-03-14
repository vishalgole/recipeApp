import 'package:dio/dio.dart';
import 'package:recipe_app/src/model/detailed_drink_model.dart';
import 'package:recipe_app/src/service/utils/constants.dart';

class DetailedDrinkApi {
  final Dio _dio = Dio();

  Future<DetailedDrinkModel> fetchDetailedDrinkData(String? id) async {
    try {
      Response response = await _dio.get(detailed_drink_url + id!);
      return DetailedDrinkModel.fromJson(response.data);
    } catch (e) {
      return DetailedDrinkModel.withError("Data not found");
    }
  }
}
