part of 'kecamatan_search_cubit.dart';

abstract class KecamatanSearchState extends Equatable {
  const KecamatanSearchState();

  @override
  List<Object> get props => [];
}

class KecamatanSearchInitial extends KecamatanSearchState {}

class KecamatanSearchLoading extends KecamatanSearchState {}

class KecamatanSearchSuccess extends KecamatanSearchState {
  KecamatanSearchSuccess(this.result);

  final List<SearchKecamatanData> result;

  @override
  List<Object> get props => [result];
}

class KecamatanSearchFailure extends KecamatanSearchState {
  
  final String message;

  KecamatanSearchFailure(this.message);

  @override
  List<Object> get props => [message];
}
