import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/repositories.dart';

part 'order_with_saldo_panen_state.dart';

class OrderWithSaldoPanenCubit extends Cubit<OrderWithSaldoPanenState> {
  OrderWithSaldoPanenCubit() : super(OrderWithSaldoPanenInitial());

  final WalletRepository _walletRepository = WalletRepository();

  Future<void> order({
    @required int amount,
  }) async {
    emit(OrderWithSaldoPanenLoading());
    try {
      final response = await _walletRepository.orderWithSaldoPanen(amount: amount);
      emit(OrderWithSaldoPanenSuccess(response.data));
    } catch (error) {
      emit(OrderWithSaldoPanenFailure(error.toString()));
    }
  }

}
