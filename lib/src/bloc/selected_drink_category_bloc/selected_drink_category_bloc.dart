import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/src/api/selected_drink_category_api.dart';
import 'package:recipe_app/src/bloc/selected_drink_category_bloc/selected_drink_category_event.dart';
import 'package:recipe_app/src/bloc/selected_drink_category_bloc/selected_drink_category_state.dart';

class SelectedDrinkCategoryBloc
    extends Bloc<SelectedDrinkCategoryEvent, SelectedDrinkCategoryState> {
  SelectedDrinkCategoryBloc() : super(SelectedDrinkCategoryInitial()) {
    final SelectedDrinkCategoryApi _api = SelectedDrinkCategoryApi();

    on<GetSelectedDrinkCategoryList>((event, emit) async {
      try {
        emit(SelectedDrinkCategoryLoading());
        final dataList =
            await _api.fetchSelectedDrinkCategoryData(event.category);
        emit(SelectedDrinkCategoryLoaded(dataList));
      } catch (e) {
        emit(const SelectedDrinkCategoryError("Failed to fetch data"));
      }
    });
  }
}
