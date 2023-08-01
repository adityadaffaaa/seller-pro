part of 'edit_stock_product_supplier_cubit.dart';

abstract class EditStockProductSupplierState extends Equatable {
  const EditStockProductSupplierState();

  @override
  List<Object> get props => [];
}

class EditStockProductSupplierInitial extends EditStockProductSupplierState {}

class EditStockProductSupplierLoading extends EditStockProductSupplierState {}

class EditStockProductSupplierSuccess extends EditStockProductSupplierState {}

class EditStockProductSupplierFailure extends EditStockProductSupplierState {
  
  final String message;

  EditStockProductSupplierFailure(
      this.message);

  @override
  List<Object> get props => [message];
}
