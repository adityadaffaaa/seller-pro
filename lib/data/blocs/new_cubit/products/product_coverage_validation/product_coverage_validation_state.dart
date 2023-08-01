part of 'product_coverage_validation_cubit.dart';

abstract class ProductCoverageValidationState extends Equatable {
  const ProductCoverageValidationState();

  @override
  List<Object> get props => [];
}

class ProductCoverageValidationInitial extends ProductCoverageValidationState {}

class ProductCoverageValidationLoading extends ProductCoverageValidationState {}

class ProductCoverageValidationSuccess extends ProductCoverageValidationState {
  ProductCoverageValidationSuccess(this.status);

  final bool status;

  @override
  List<Object> get props => [status];
}

class ProductCoverageValidationFailure extends ProductCoverageValidationState {
  
  final String message;

  ProductCoverageValidationFailure(this.message);

  @override
  List<Object> get props => [message];
}