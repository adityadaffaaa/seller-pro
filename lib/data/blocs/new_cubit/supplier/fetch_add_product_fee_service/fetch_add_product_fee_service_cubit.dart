import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/data/models/new_models/supplier.dart';
import 'package:marketplace/data/repositories/repositories.dart';

part 'fetch_add_product_fee_service_state.dart';

class FetchAddProductFeeServiceCubit
    extends Cubit<FetchAddProductFeeServiceState> {
  FetchAddProductFeeServiceCubit() : super(FetchAddProductFeeServiceInitial());

  final JoinUserRepository _repo = JoinUserRepository();

  Future<void> fetchFee({@required int price}) async {
    emit(FetchAddProductFeeServiceLoading());
    try {
      final response = await _repo.getFeeServiceAddProduct(price: price);
      emit(FetchAddProductFeeServiceSuccess(data: response.data));
    } catch (error) {
      emit(FetchAddProductFeeServiceFailure(error.toString()));
    }
  }
}
