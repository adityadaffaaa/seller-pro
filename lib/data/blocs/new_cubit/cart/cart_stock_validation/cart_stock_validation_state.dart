part of 'cart_stock_validation_cubit.dart';

abstract class CartStockValidationState extends Equatable {
  const CartStockValidationState();

  @override
  List<Object> get props => [];
}

class CartStockValidationInitial extends CartStockValidationState {}

class CartStockValidationLoading extends CartStockValidationState {}

class CartStockValidationSuccess extends CartStockValidationState {}

class CartStockValidationFailure extends CartStockValidationState {
  
  final String message;

  CartStockValidationFailure(this.message);

  @override
  List<Object> get props => [message];
}
