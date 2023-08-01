import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/order_repository.dart';

part 'add_order_no_cart_state.dart';

class AddOrderNoCartCubit extends Cubit<AddOrderNoCartState> {
  AddOrderNoCartCubit() : super(AddOrderNoCartInitial());

  final OrderRepository _orderRepo = OrderRepository();

  Future<void> order({
    @required int productId,
    @required int paymentId,
    @required int variantId,
    @required int totalPayment,
  }) async {
    emit(AddOrderNoCartLoading());
    try {
      debugPrint(productId.toString());
      debugPrint(paymentId.toString());
      debugPrint(variantId.toString());
      debugPrint(totalPayment.toString());
      final response = await _orderRepo.orderWifiTelkom(
          productId: productId,
          paymentId: paymentId,
          variantId: variantId,
          totalPayment: totalPayment);
      emit(AddOrderNoCartSuccess(response.data));
    } catch (error) {
      // if (error is NetworkException) {
      //   emit(AddOrderNoCartFailure.network(error.toString()));
      //   return;
      // }
      emit(AddOrderNoCartFailure(error.toString()));
    }
  }

  Future<void> orderNoAuth({
    @required int productId,
    @required int paymentId,
    @required int variantId,
    @required int totalPayment,
    @required String slug,
      @required String name,
      @required String phoneNumber,
      @required String email,
      @required String address,
      @required int subdistrictId,
  }) async {
    emit(AddOrderNoCartLoading());
    try {
      debugPrint(productId.toString());
      debugPrint(paymentId.toString());
      debugPrint(variantId.toString());
      debugPrint(totalPayment.toString());
      final response = await _orderRepo.orderWifiTelkomNoAuth(productId: productId, paymentId: paymentId, variantId: variantId, totalPayment: totalPayment, slug: slug, name: name, phoneNumber: phoneNumber, email: email, address: address, subdistrictId: subdistrictId);
      emit(AddOrderNoCartSuccess(response.data));
    } catch (error) {
      // if (error is NetworkException) {
      //   emit(AddOrderNoCartFailure.network(error.toString()));
      //   return;
      // }
      emit(AddOrderNoCartFailure(error.toString()));
    }
  }

}
