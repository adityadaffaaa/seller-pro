part of 'order_with_saldo_panen_cubit.dart';

abstract class OrderWithSaldoPanenState extends Equatable {
  const OrderWithSaldoPanenState();

  @override
  List<Object> get props => [];
}

class OrderWithSaldoPanenInitial extends OrderWithSaldoPanenState {}

class OrderWithSaldoPanenLoading extends OrderWithSaldoPanenState {}

class OrderWithSaldoPanenSuccess extends OrderWithSaldoPanenState {
  OrderWithSaldoPanenSuccess(this.data);

  final WalletPayment data;

  @override
  List<Object> get props => [data];
}

class OrderWithSaldoPanenFailure extends OrderWithSaldoPanenState {
  
  final String message;

  OrderWithSaldoPanenFailure(this.message);

  @override
  List<Object> get props => [message];
}
