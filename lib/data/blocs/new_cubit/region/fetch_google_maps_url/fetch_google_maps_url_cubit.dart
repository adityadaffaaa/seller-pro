import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/data/models/new_models/location.dart';
import 'package:marketplace/data/repositories/new_repositories/location_repository.dart';

part 'fetch_google_maps_url_state.dart';

class FetchGoogleMapsUrlCubit extends Cubit<FetchGoogleMapsUrlState> {
  FetchGoogleMapsUrlCubit() : super(FetchGoogleMapsUrlInitial());

  final LocationRepository _repo = LocationRepository();

  Future<void> fetchUrl() async {
    emit(FetchGoogleMapsUrlLoading());
    try {
      final response = await _repo.fetchGoogleMapsUrl();
      emit(FetchGoogleMapsUrlSuccess(response.data));
    } catch (error) {
      emit(FetchGoogleMapsUrlFailure(error.toString()));
    }
  }

  Future<void> fetchUrlNoAuth({
    @required String phoneNumber
  }) async {
    emit(FetchGoogleMapsUrlLoading());
    try {
      final response = await _repo.fetchGoogleMapsUrlNoAuth(phoneNumber: phoneNumber);
      emit(FetchGoogleMapsUrlSuccess(response.data));
    } catch (error) {
      emit(FetchGoogleMapsUrlFailure(error.toString()));
    }
  }

}
