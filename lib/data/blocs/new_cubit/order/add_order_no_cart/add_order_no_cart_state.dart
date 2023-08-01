part of 'add_order_no_cart_cubit.dart';

abstract class AddOrderNoCartState extends Equatable {
  const AddOrderNoCartState();

  @override
  List<Object> get props => [];
}

class AddOrderNoCartInitial extends AddOrderNoCartState {}

class AddOrderNoCartLoading extends AddOrderNoCartState {}

class AddOrderNoCartSuccess extends AddOrderNoCartState {
  AddOrderNoCartSuccess(this.data);
  final GeneralOrderResponseData data;

  @override
  List<Object> get props => [data];
}

class AddOrderNoCartFailure extends AddOrderNoCartState {
  AddOrderNoCartFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}


