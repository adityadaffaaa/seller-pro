part of 'fetch_transaction_menunggu_pembayaran_detail_cubit.dart';

@immutable
abstract class FetchTransactionMenungguPembayaranDetailState extends Equatable {
  const FetchTransactionMenungguPembayaranDetailState();

  @override
  List<Object> get props => [];
}

class FetchTransactionMenungguPembayaranDetailInitial extends FetchTransactionMenungguPembayaranDetailState {}

class FetchTransactionMenungguPembayaranDetailLoading extends FetchTransactionMenungguPembayaranDetailState {}

class FetchTransactionMenungguPembayaranDetailSuccess extends FetchTransactionMenungguPembayaranDetailState {
  FetchTransactionMenungguPembayaranDetailSuccess(this.items);

  final PaymentDetail items;

  @override
  List<Object> get props => [items];
}

class FetchTransactionMenungguPembayaranDetailFailure extends FetchTransactionMenungguPembayaranDetailState {
  
  final String message;

  FetchTransactionMenungguPembayaranDetailFailure(this.message);

  @override
  List<Object> get props => [message];
}
