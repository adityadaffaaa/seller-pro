part of 'order_langganan_telkom_cubit.dart';

abstract class OrderLanggananTelkomState extends Equatable {
  const OrderLanggananTelkomState();

  @override
  List<Object> get props => [];
}

class OrderLanggananTelkomInitial extends OrderLanggananTelkomState {}

class OrderLanggananTelkomLoading extends OrderLanggananTelkomState {}

class OrderLanggananTelkomSuccess extends OrderLanggananTelkomState {}

class OrderLanggananTelkomFailure extends OrderLanggananTelkomState {
  OrderLanggananTelkomFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
