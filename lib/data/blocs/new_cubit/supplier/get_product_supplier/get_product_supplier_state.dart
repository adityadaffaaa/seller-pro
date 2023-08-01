part of 'get_product_supplier_cubit.dart';

abstract class GetProductSupplierState extends Equatable {
  const GetProductSupplierState();

  @override
  List<Object> get props => [];
}

class GetProductSupplierInitial extends GetProductSupplierState {}

class GetProductSupplierLoading extends GetProductSupplierState {}

class GetProductSupplierSuccess extends GetProductSupplierState {
  GetProductSupplierSuccess({this.products});

  List<SupplierDataResponseItem> products;

  @override
  List<Object> get props => [products];
}

class GetProductSupplierDeleteSuccess extends GetProductSupplierState {}

class GetProductSupplierFailure extends GetProductSupplierState {
  
  final String message;

  GetProductSupplierFailure(this.message);

  @override
  List<Object> get props => [message];
}
