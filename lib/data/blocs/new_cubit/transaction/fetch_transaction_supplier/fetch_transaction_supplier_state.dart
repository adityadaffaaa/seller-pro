part of 'fetch_transaction_supplier_cubit.dart';

abstract class FetchTransactionSupplierState extends Equatable {
  const FetchTransactionSupplierState();

  @override
  List<Object> get props => [];
}

class FetchTransactionSupplierInitial extends FetchTransactionSupplierState {}

class FetchTransactionSupplierLoading extends FetchTransactionSupplierState {}

class FetchTransactionSupplierSuccess extends FetchTransactionSupplierState {
  FetchTransactionSupplierSuccess(this.order);

  final List<OrderResponseData> order;

  @override
  List<Object> get props => [order];
}

class FetchTransactionSupplierFailure extends FetchTransactionSupplierState {
  FetchTransactionSupplierFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
