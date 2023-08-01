part of 'fetch_categorysub_cubit.dart';

abstract class FetchCategorysubState extends Equatable {
  const FetchCategorysubState();

  @override
  List<Object> get props => [];
}

class FetchCategorysubInitial extends FetchCategorysubState {}

class FetchCategorysubLoading extends FetchCategorysubState {}

class FetchCategorysubSuccess extends FetchCategorysubState {
  FetchCategorysubSuccess(this.categorySub);

  final CategorySub categorySub;

  @override
  List<Object> get props => [categorySub];
}

class FetchCategorysubFailure extends FetchCategorysubState {
  FetchCategorysubFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
