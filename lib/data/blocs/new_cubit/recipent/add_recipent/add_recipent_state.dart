part of 'add_recipent_cubit.dart';

abstract class AddRecipentState extends Equatable {
  const AddRecipentState();

  @override
  List<Object> get props => [];
}

class AddRecipentInitial extends AddRecipentState {}

class AddRecipentLoading extends AddRecipentState {}

class AddRecipentSuccess extends AddRecipentState {
  final Recipent data;

  AddRecipentSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class AddRecipentFailure extends AddRecipentState {
  
  final String message;

  AddRecipentFailure(this.message);

  @override
  List<Object> get props => [message];
}


