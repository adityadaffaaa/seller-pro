part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  SearchSuccess(this.result);

  final List<Products> result;

  @override
  List<Object> get props => [result];
}

class SearchFailure extends SearchState {
  
  final String message;

  SearchFailure(this.message);

  @override
  List<Object> get props => [message];
}
