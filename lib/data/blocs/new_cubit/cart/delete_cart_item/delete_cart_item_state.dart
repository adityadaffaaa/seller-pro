part of 'delete_cart_item_cubit.dart';

abstract class DeleteCartItemState extends Equatable {
  const DeleteCartItemState();

  @override
  List<Object> get props => [];
}

class DeleteCartItemInitial extends DeleteCartItemState {}

class DeleteCartItemLoading extends DeleteCartItemState {}

class DeleteCartItemSuccess extends DeleteCartItemState {}

class DeleteCartItemFailure extends DeleteCartItemState {
  
  final String message;

  DeleteCartItemFailure(this.message);

  @override
  List<Object> get props => [message];
}
