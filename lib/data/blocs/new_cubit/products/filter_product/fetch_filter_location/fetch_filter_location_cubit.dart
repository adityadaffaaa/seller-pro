import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/data/models/new_models/location.dart';
import 'package:marketplace/data/repositories/new_repositories/location_repository.dart';

part 'fetch_filter_location_state.dart';

class FetchFilterLocationCubit extends Cubit<FetchFilterLocationState> {
  FetchFilterLocationCubit() : super(FetchFilterLocationInitial());

  TextEditingController locationFilterController = TextEditingController();

  final LocationRepository _regionRepo = LocationRepository();

  Future<void> fetchLocation({@required String keyword}) async {
    emit(FetchFilterLocationLoading());
    try {
      if (keyword != null) {
        final response =
            await _regionRepo.fetchLocationFilter(keyword: keyword);
        emit(FetchFilterLocationSuccess(response.data));
      }
    } catch (error) {
      emit(FetchFilterLocationFailure(error.toString()));
    }
  }
}
