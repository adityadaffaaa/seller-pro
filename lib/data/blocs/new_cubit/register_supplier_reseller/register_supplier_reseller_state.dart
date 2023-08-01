part of 'register_supplier_reseller_cubit.dart';

@immutable
abstract class RegisterSupplierResellerState extends Equatable {
  const RegisterSupplierResellerState();

  @override
  List<Object> get props => [];
}

class RegisterSupplierResellerInitial extends RegisterSupplierResellerState {}

class RegisterSupplierResellerLoading extends RegisterSupplierResellerState {}

class RegisterSupplierResellerSuccess extends RegisterSupplierResellerState {}

class RegisterSupplierResellerFailure extends RegisterSupplierResellerState {
  final String message;

  RegisterSupplierResellerFailure(this.message);

  @override
  List<Object> get props => [message];
}
