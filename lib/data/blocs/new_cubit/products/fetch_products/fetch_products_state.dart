part of 'fetch_products_cubit.dart';

abstract class FetchProductsState extends Equatable {
  const FetchProductsState();

  @override
  List<Object> get props => [];
}

class FetchProductsInitial extends FetchProductsState {}

class FetchProductsLoading extends FetchProductsState {}

class FetchProductsSuccess extends FetchProductsState {
  FetchProductsSuccess(this.products);

  final List<Products> products;

  @override
  List<Object> get props => [products];
}

class FetchProductsFailure extends FetchProductsState {
  
  final String message;

  FetchProductsFailure(this.message);

  @override
  List<Object> get props => [message];
}
