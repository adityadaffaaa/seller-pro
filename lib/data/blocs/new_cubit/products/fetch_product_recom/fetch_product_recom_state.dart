part of 'fetch_product_recom_cubit.dart';

abstract class FetchProductRecomState extends Equatable {
  const FetchProductRecomState();

  @override
  List<Object> get props => [];
}

class FetchProductRecomInitial extends FetchProductRecomState {}

class FetchProductRecomLoading extends FetchProductRecomState {}

class FetchProductRecomSuccess extends FetchProductRecomState {
  FetchProductRecomSuccess(this.products);

  final List<Products> products;

  @override
  List<Object> get props => [products];
}

class FetchProductRecomFailure extends FetchProductRecomState {
  
  final String message;

  FetchProductRecomFailure(this.message);

  @override
  List<Object> get props => [message];
}
