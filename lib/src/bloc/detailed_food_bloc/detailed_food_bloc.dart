import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/src/api/detailed_food_api.dart';
import 'package:recipe_app/src/bloc/detailed_food_bloc/detailed_food_event.dart';
import 'package:recipe_app/src/bloc/detailed_food_bloc/detailed_food_state.dart';

class DetailedFoodBloc extends Bloc<DetailedFoodEvent, DetailedFoodState> {
  DetailedFoodBloc() : super(DetailedFoodStateInitial()) {
    final DetailedFoodApi _api = DetailedFoodApi();
    on<GetDetailedFoodData>((event, emit) async {
      try {
        emit(DetailedFoodStateLoading());
        final dataList = await _api.fetchDetailedFoodData(event.selectedId);
        emit(DetailedFoodStateLoaded(dataList));
      } catch (e) {
        emit(DetailedFoodStateError("Failed to fetch data"));
      }
    });
  }
}
