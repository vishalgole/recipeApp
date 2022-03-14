import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/src/api/detailed_drink_api.dart';
import 'package:recipe_app/src/bloc/detailed_drink_bloc/detailed_drink_event.dart';
import 'package:recipe_app/src/bloc/detailed_drink_bloc/detailed_drink_state.dart';

class DetailedDrinkBloc extends Bloc<DetailedDrinkEvent, DetailedDrinkState> {
  DetailedDrinkBloc() : super(DetailedDrinkStateInitial()) {
    final DetailedDrinkApi _api = DetailedDrinkApi();
    on<GetDetailedDrinkData>((event, emit) async {
      try {
        emit(DetailedDrinkStateLoading());
        final dataList = await _api.fetchDetailedDrinkData(event.id);
        emit(DetailedDrinkStateLoaded(dataList));
      } catch (e) {
        emit(const DetailedDrinkStateError("Failed to fetch data"));
      }
    });
  }
}
