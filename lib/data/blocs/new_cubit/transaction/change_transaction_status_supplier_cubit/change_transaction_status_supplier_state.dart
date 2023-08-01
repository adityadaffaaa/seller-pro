part of 'change_transaction_status_supplier_cubit.dart';

abstract class ChangeTransactionStatusSupplierState extends Equatable {
  const ChangeTransactionStatusSupplierState();

  @override
  List<Object> get props => [];
}

class ChangeTransactionStatusSupplierInitial extends ChangeTransactionStatusSupplierState {}

class ChangeTransactionStatusSupplierLoading extends ChangeTransactionStatusSupplierState {}

class ChangeTransactionStatusSupplierSuccess extends ChangeTransactionStatusSupplierState {
  ChangeTransactionStatusSupplierSuccess(this.status);

  final String status;

  @override
  List<Object> get props => [status];
}

class ChangeTransactionStatusSupplierFailure extends ChangeTransactionStatusSupplierState {
  
  final String message;

  ChangeTransactionStatusSupplierFailure(this.message);

  @override
  List<Object> get props => [message];
}