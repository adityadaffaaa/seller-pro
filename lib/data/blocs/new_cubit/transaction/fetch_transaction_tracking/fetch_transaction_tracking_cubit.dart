import 'package:bloc/bloc.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/models/new_models/tracking.dart';
import 'package:marketplace/data/repositories/order_repository.dart';
import 'package:meta/meta.dart';

part 'fetch_transaction_tracking_state.dart';

class FetchTransactionTrackingCubit extends Cubit<FetchTransactionTrackingState> {
  FetchTransactionTrackingCubit() : super(FetchTransactionTrackingInitial());

  final OrderRepository _repo = OrderRepository();

  Future<void> getTrackingOrder({@required int orderId,@required int isSupplier}) async {
    emit(FetchTransactionTrackingLoading());
    try {
      final response =
      await _repo.fetchTrackingOrder(orderId: orderId,isSupplier: isSupplier);
      emit(FetchTransactionTrackingSuccess(response.data));
    } catch (error) {
      emit(FetchTransactionTrackingFailure(error.toString()));
    }
  }

  Future<void> getTrackingOrderNoAuth({@required int orderId}) async {
    emit(FetchTransactionTrackingLoading());
    try {
      final response =
      await _repo.fetchTrackingOrderNoAuth(orderId: orderId);
      emit(FetchTransactionTrackingSuccess(response.data));
    } catch (error) {
      emit(FetchTransactionTrackingFailure(error.toString()));
    }
  }

}
