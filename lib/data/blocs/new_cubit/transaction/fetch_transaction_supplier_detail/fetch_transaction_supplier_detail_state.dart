part of 'fetch_transaction_supplier_detail_cubit.dart';

abstract class FetchTransactionSupplierDetailState extends Equatable {
  const FetchTransactionSupplierDetailState();

  @override
  List<Object> get props => [];
}

class FetchTransactionSupplierDetailInitial extends FetchTransactionSupplierDetailState {}

class FetchTransactionSupplierDetailLoading extends FetchTransactionSupplierDetailState {}

class FetchTransactionSupplierDetailSuccess extends FetchTransactionSupplierDetailState {
  FetchTransactionSupplierDetailSuccess(this.items);

  final OrderDetailSupplierResponseData items;

  @override
  List<Object> get props => [items];
}

class FetchTransactionSupplierDetailFailure extends FetchTransactionSupplierDetailState {
  
  final String message;

  FetchTransactionSupplierDetailFailure(this.message);

  @override
  List<Object> get props => [message];
}
