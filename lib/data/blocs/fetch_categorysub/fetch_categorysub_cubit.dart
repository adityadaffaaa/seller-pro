import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marketplace/data/models/subcategory.dart';
import 'package:marketplace/data/repositories/category_repository.dart';

part 'fetch_categorysub_state.dart';

class FetchCategorysubCubit extends Cubit<FetchCategorysubState> {
  FetchCategorysubCubit() : super(FetchCategorysubInitial());

  final CategoryRepository _categoryRepository = CategoryRepository();

  void load({int id}) async {
    emit(FetchCategorysubLoading());
    try {
      final response = await _categoryRepository.fetchCategorySub(subcategoryId: id);
      emit(FetchCategorysubSuccess(response.data));
    } catch (error) {
      emit(FetchCategorysubFailure(error.toString()));
    }
  }
}
