import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/src/api/drink_category_api.dart';
import 'package:recipe_app/src/bloc/drink_category_bloc/drink_category_event.dart';
import 'package:recipe_app/src/bloc/drink_category_bloc/drink_category_state.dart';

class DrinkCategoryBloc extends Bloc<DrinkCategoryEvent, DrinkCategoryState> {
  DrinkCategoryBloc() : super(DrinkCategoryStateInitial()) {
    final DrinkCategoryApi _api = DrinkCategoryApi();

    on<GetDrinkCategoryList>((event, emit) async {
      try {
        emit(DrinkCategoryStateLoading());
        final catList = await _api.fetchDrinkCategories();
        emit(DrinkCategoryStateLLoaded(catList));
      } catch (e) {
        emit(const DrinkCategoryStateError("Failed to fetch data"));
      }
    });
  }
}
