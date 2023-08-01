part of 'fetch_best_product_by_category_cubit.dart';

abstract class FetchBestProductByCategoryState extends Equatable {
  const FetchBestProductByCategoryState();

  @override
  List<Object> get props => [];
}

class FetchBestProductByCategoryInitial extends FetchBestProductByCategoryState {}

class FetchBestProductByCategoryLoading extends FetchBestProductByCategoryState {}

class FetchBestProductByCategorySuccess extends FetchBestProductByCategoryState {
  FetchBestProductByCategorySuccess(this.products);

  final List<Products> products;

  @override
  List<Object> get props => [products];
}

class FetchBestProductByCategoryFailure extends FetchBestProductByCategoryState {
  
  final String message;

  FetchBestProductByCategoryFailure(this.message);

  @override
  List<Object> get props => [message];
}

