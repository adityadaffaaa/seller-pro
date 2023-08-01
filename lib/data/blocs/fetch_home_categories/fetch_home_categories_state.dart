part of 'fetch_home_categories_cubit.dart';

abstract class FetchHomeCategoriesState extends Equatable {
  const FetchHomeCategoriesState();

  @override
  List<Object> get props => [];
}

class FetchHomeCategoriesInitial extends FetchHomeCategoriesState {}

class FetchHomeCategoriesLoading extends FetchHomeCategoriesState {}

class FetchHomeCategoriesSuccess extends FetchHomeCategoriesState {
  FetchHomeCategoriesSuccess(this.homeCategories);

  final List<HomeCategory> homeCategories;

  @override
  List<Object> get props => [homeCategories];
}

class FetchHomeCategoriesFailure extends FetchHomeCategoriesState {
  final String message;

  FetchHomeCategoriesFailure(this.message);

  @override
  List<Object> get props =>  [message];
}
