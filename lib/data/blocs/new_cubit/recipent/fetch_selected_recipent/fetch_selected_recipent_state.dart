part of 'fetch_selected_recipent_cubit.dart';

abstract class FetchSelectedRecipentState extends Equatable {
  const FetchSelectedRecipentState();

  @override
  List<Object> get props => [];
}

class FetchSelectedRecipentInitial extends FetchSelectedRecipentState {}

class FetchSelectedRecipentLoading extends FetchSelectedRecipentState {}

class FetchSelectedRecipentSuccess extends FetchSelectedRecipentState {
  final Recipent recipent;

  FetchSelectedRecipentSuccess(this.recipent);

  List<Object> get props => [recipent];
}

class FetchSelectedRecipentFailure extends FetchSelectedRecipentState {
  
  final String message;

  FetchSelectedRecipentFailure(this.message);

  @override
  List<Object> get props => [message];
}

