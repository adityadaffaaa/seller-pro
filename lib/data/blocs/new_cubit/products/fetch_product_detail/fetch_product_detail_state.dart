part of 'fetch_product_detail_cubit.dart';

abstract class FetchProductDetailState extends Equatable {
  const FetchProductDetailState();

  @override
  List<Object> get props => [];
}

class FetchProductDetailInitial extends FetchProductDetailState {}

class FetchProductDetailLoading extends FetchProductDetailState {}

class FetchProductDetailSuccess extends FetchProductDetailState {
  FetchProductDetailSuccess(this.product);

  final Products product;

  @override
  List<Object> get props => [product];
}

class FetchProductDetailFailure extends FetchProductDetailState {
  
  final String message;

  FetchProductDetailFailure(this.message);

  @override
  List<Object> get props => [message];
}