import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/src/api/food_category_api.dart';
import 'package:recipe_app/src/bloc/food_category_bloc/food_category_event.dart';
import 'package:recipe_app/src/bloc/food_category_bloc/food_category_state.dart';

class FoodCategoryBloc extends Bloc<FoodCategoryEvent, FoodCategoryState> {
  FoodCategoryBloc() : super(FoodCategoryStateIniitial()) {
    final FoodCategoryApi _api = FoodCategoryApi();
    on<GetFoodCategoryList>((event, emit) async {
      try {
        emit(FoodCategoryStateLoading());
        final catList = await _api.fetchFoodCategories();
        emit(FoodCategoryStateLoaded(catList));
      } catch (e) {
        emit(const FoodCategoryStateError("Failed to fetch data"));
      }
    });
  }
}
