part of 'fetch_products_by_subcategory_cubit.dart';

abstract class FetchProductsBySubcategoryState extends Equatable {
  const FetchProductsBySubcategoryState();

  @override
  List<Object> get props => [];
}

class FetchProductsBySubcategoryInitial
    extends FetchProductsBySubcategoryState {}

class FetchProductsBySubcategoryLoading
    extends FetchProductsBySubcategoryState {}

class FetchProductsBySubcategorySuccess
    extends FetchProductsBySubcategoryState {
  FetchProductsBySubcategorySuccess(this.products);

  final List<Products> products;

  @override
  List<Object> get props => [products];
}

class FetchProductsBySubcategoryFailure
    extends FetchProductsBySubcategoryState {
  FetchProductsBySubcategoryFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
