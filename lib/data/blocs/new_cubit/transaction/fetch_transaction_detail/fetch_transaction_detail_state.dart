part of 'fetch_transaction_detail_cubit.dart';

abstract class FetchTransactionDetailState extends Equatable {
  const FetchTransactionDetailState();

  @override
  List<Object> get props => [];
}

class FetchTransactionDetailInitial extends FetchTransactionDetailState {}

class FetchTransactionDetailLoading extends FetchTransactionDetailState {}

class FetchTransactionDetailSuccess extends FetchTransactionDetailState {
  FetchTransactionDetailSuccess(this.items,this.itemsNoAuth);

  final OrderDetailResponseData items;
  final WppOrderDetailResponseData itemsNoAuth;

  @override
  List<Object> get props => [items,itemsNoAuth];
}

class FetchTransactionDetailFailure extends FetchTransactionDetailState {
  
  final String message;

  FetchTransactionDetailFailure(this.message);

  @override
  List<Object> get props => [message];
}