part of 'fetch_invoice_by_order_cubit.dart';

abstract class FetchInvoiceByOrderState extends Equatable {
  const FetchInvoiceByOrderState();

  @override
  List<Object> get props => [];
}

class FetchInvoiceByOrderInitial extends FetchInvoiceByOrderState {}

class FetchInvoiceByOrderLoading extends FetchInvoiceByOrderState {}

class FetchInvoiceByOrderSuccess extends FetchInvoiceByOrderState {
  FetchInvoiceByOrderSuccess(this.data);

  final InvoiceByOrder data;

  @override
  List<Object> get props => [data];
}

class FetchInvoiceByOrderFailure extends FetchInvoiceByOrderState {
  
  final String message;

  FetchInvoiceByOrderFailure(this.message);

  @override
  List<Object> get props => [message];
}
