import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/data/models/new_models/products.dart';
import 'package:marketplace/data/repositories/new_repositories/products_repository.dart';

part 'fetch_products_by_subcategory_state.dart';

class FetchProductsBySubcategoryCubit
    extends Cubit<FetchProductsBySubcategoryState> {
  FetchProductsBySubcategoryCubit()
      : super(FetchProductsBySubcategoryInitial());

  final ProductsRepository _productsRepository = ProductsRepository();

  Future<void> fetchProductsBySubcategory({@required int subCategoryId}) async {
    emit(FetchProductsBySubcategoryLoading());
    final response = await _productsRepository.fetchProductsBySubcategory(
        subCategoryId: subCategoryId);
    try {
      emit(FetchProductsBySubcategorySuccess(response.data));
    } catch (error) {
      emit(FetchProductsBySubcategoryFailure(error.toString()));
    }
  }
}
