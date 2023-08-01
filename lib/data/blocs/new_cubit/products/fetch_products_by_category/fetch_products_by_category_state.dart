part of 'fetch_products_by_category_cubit.dart';

abstract class FetchProductsByCategoryState extends Equatable {
  const FetchProductsByCategoryState();

  @override
  List<Object> get props => [];
}

class FetchProductsByCategoryInitial extends FetchProductsByCategoryState {}

class FetchProductsByCategoryLoading extends FetchProductsByCategoryState {}

class FetchProductsByCategorySuccess extends FetchProductsByCategoryState {
  FetchProductsByCategorySuccess(this.products);

  final List<Products> products;

  @override
  List<Object> get props => [products];
}

class FetchProductsByCategoryFailure extends FetchProductsByCategoryState {
  
  final String message;

  FetchProductsByCategoryFailure(this.message);

  @override
  List<Object> get props => [message];
}
