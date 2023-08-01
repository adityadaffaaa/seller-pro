part of 'fetch_add_product_fee_service_cubit.dart';

abstract class FetchAddProductFeeServiceState extends Equatable {
  const FetchAddProductFeeServiceState();

  @override
  List<Object> get props => [];
}

class FetchAddProductFeeServiceInitial extends FetchAddProductFeeServiceState {}

class FetchAddProductFeeServiceLoading extends FetchAddProductFeeServiceState {}

class FetchAddProductFeeServiceSuccess extends FetchAddProductFeeServiceState {
  FetchAddProductFeeServiceSuccess({this.data});

  FeeServiceAddProduct data;

  @override
  List<Object> get props => [data];
}

class FetchAddProductFeeServiceFailure extends FetchAddProductFeeServiceState {
  
  final String message;

  FetchAddProductFeeServiceFailure(this.message);

  @override
  List<Object> get props => [message];
}
