part of 'update_quantity_cubit.dart';

abstract class UpdateQuantityState extends Equatable {
  const UpdateQuantityState();

  @override
  List<Object> get props => [];
}

class UpdateQuantityInitial extends UpdateQuantityState {}

class UpdateQuantityLoading extends UpdateQuantityState {}

class UpdateQuantitySuccess extends UpdateQuantityState {}

class UpdateQuantityFailure extends UpdateQuantityState {
  
  final String message;

  UpdateQuantityFailure(this.message);

  @override
  List<Object> get props => [message];
}
