import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/models/new_models/location.dart';
import 'package:marketplace/data/repositories/new_repositories/location_repository.dart';

part 'fetch_regions_state.dart';

class FetchRegionsCubit extends Cubit<FetchRegionsState> {
  FetchRegionsCubit() : super(FetchRegionsInitial());

  final LocationRepository regionRepo = LocationRepository();

  Future<void> fetchProvince() async {
    emit(FetchRegionsLoading());
    try {
      final response = await regionRepo.fetchProvinces();
      emit(FetchRegionsSuccess(response.data));
    } catch (error) {
      emit(FetchRegionsFailure(error.toString()));
    }
  }

  Future<void> fetchCities({@required int provinceId}) async {
    emit(FetchRegionsLoading());
    try {
      final response = await regionRepo.fetchCities(provinceId: provinceId);
      emit(FetchRegionsSuccess(response.data));
    } catch (error) {
      emit(FetchRegionsFailure(error.toString()));
    }
  }
}
