import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/src/api/selected_category_api.dart';
import 'package:recipe_app/src/bloc/selected_category_bloc/selected_category_event.dart';
import 'package:recipe_app/src/bloc/selected_category_bloc/selected_category_state.dart';

class SelectedCategoryBloc
    extends Bloc<SelectedCategoryEvent, SelectedCategoryState> {
  SelectedCategoryBloc() : super(SelectedCategoryStateInitial()) {
    final SelectedCategoryApi _api = SelectedCategoryApi();
    on<GetSelectedCategoryList>((event, emit) async {
      try {
        emit(SelectedCategoryStateLoading());
        final dataList = await _api.fetchSelectedCategoryData(event.category);
        emit(SelectedCategoryStateLoaded(dataList));
      } catch (e) {
        emit(const SelectedCategoryStateError("Failed to fetch data"));
      }
    });
  }
}
