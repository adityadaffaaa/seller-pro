part of 'fetch_products_reseller_shop_cubit.dart';

abstract class FetchProductsResellerShopState extends Equatable {
  const FetchProductsResellerShopState();

  @override
  List<Object> get props => [];
}

class FetchProductsResellerShopInitial extends FetchProductsResellerShopState {}

class FetchProductsResellerShopLoading extends FetchProductsResellerShopState {}

class FetchProductsResellerShopSuccess extends FetchProductsResellerShopState {
  FetchProductsResellerShopSuccess({this.resellerProducts});

  final List<Products> resellerProducts;
  

  @override
  List<Object> get props => [resellerProducts];
}

class FetchProductsResellerShopFailure extends FetchProductsResellerShopState {

  
  final String message;

  FetchProductsResellerShopFailure(this.message);

  @override
  List<Object> get props => [message];
}


