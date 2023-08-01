part of 'fetch_products_by_seller_cubit.dart';

abstract class FetchProductsBySellerState extends Equatable {
  const FetchProductsBySellerState();

  @override
  List<Object> get props => [];
}

class FetchProductsBySellerInitial extends FetchProductsBySellerState {}

class FetchProductsBySellerLoading extends FetchProductsBySellerState {}

class FetchProductsBySellerSuccess extends FetchProductsBySellerState {
  FetchProductsBySellerSuccess(this.products);

  final List<Products> products;

  @override
  List<Object> get props => [products];
}

class FetchProductsBySellerFailure extends FetchProductsBySellerState {
  
  final String message;

  FetchProductsBySellerFailure(this.message);
  
  @override
  List<Object> get props => [message];
}
