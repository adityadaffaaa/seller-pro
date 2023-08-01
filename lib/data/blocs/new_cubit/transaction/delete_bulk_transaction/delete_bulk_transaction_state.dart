part of 'delete_bulk_transaction_cubit.dart';

@immutable
abstract class DeleteBulkTransactionState {}

class DeleteBulkTransactionInitial extends DeleteBulkTransactionState {}

class DeleteBulkTransactionLoading extends DeleteBulkTransactionState {}

class DeleteBulkTransactionSuccess extends DeleteBulkTransactionState {
  final OrderMenungguPembayaran order;

  DeleteBulkTransactionSuccess({
    @required this.order,
  });
}

class DeleteBulkTransactionFailure extends DeleteBulkTransactionState {
  
  final String message;

  DeleteBulkTransactionFailure(this.message);

  @override
  List<Object> get props => [message];
}
