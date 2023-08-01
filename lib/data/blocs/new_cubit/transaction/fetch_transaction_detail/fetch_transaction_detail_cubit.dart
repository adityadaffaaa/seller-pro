import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/models/new_models/order.dart';
import 'package:marketplace/data/repositories/new_repositories/transaction_repository.dart';
import 'package:meta/meta.dart';

part 'fetch_transaction_detail_state.dart';

class FetchTransactionDetailCubit extends Cubit<FetchTransactionDetailState> {
  FetchTransactionDetailCubit() : super(FetchTransactionDetailInitial());

  final TransactionRepository _repository = TransactionRepository();

  Future<void> load({@required int orderId}) async {
    emit(FetchTransactionDetailLoading());
    try {
      debugPrint("orderId: $orderId");
      final response =
      await _repository.fetchOrderDetail(orderId: orderId);
      emit(FetchTransactionDetailSuccess(response.data,null));
    } catch (error) {
      emit(FetchTransactionDetailFailure(error.toString()));
    }
  }

  Future<void> fetchDetailWpp({@required int paymentId}) async {
    emit(FetchTransactionDetailLoading());
    try {
      debugPrint("id $paymentId");
      final response =
      await _repository.fetchOrderDetailNoAuth(paymentId: paymentId);
      emit(FetchTransactionDetailSuccess(null, response.dataNoAuth));
    } catch (error) {
      emit(FetchTransactionDetailFailure(error.toString()));
    }
  }
}
