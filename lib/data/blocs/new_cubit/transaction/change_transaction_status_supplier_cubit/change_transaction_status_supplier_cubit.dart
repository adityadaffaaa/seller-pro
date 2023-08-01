import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/new_repositories/transaction_repository.dart';

part 'change_transaction_status_supplier_state.dart';

class ChangeTransactionStatusSupplierCubit
    extends Cubit<ChangeTransactionStatusSupplierState> {
  ChangeTransactionStatusSupplierCubit()
      : super(ChangeTransactionStatusSupplierInitial());

  final TransactionRepository _transactionRepository = TransactionRepository();

  Future<void> changeStatus(
      {@required int orderId, @required int status, String airwayBill}) async {
    emit(ChangeTransactionStatusSupplierLoading());
    try {
      final response =
          await _transactionRepository.changeStatusSupplierTransactions(
              orderId: orderId, status: status, airwayBill: airwayBill);
      emit(ChangeTransactionStatusSupplierSuccess(response));
    } catch (error) {
      emit(ChangeTransactionStatusSupplierFailure(error.toString()));
    }
  }
}
