part of 'fetch_regions_cubit.dart';

abstract class FetchRegionsState extends Equatable {
  const FetchRegionsState();

  @override
  List<Object> get props => [];
}

class FetchRegionsInitial extends FetchRegionsState {}

class FetchRegionsLoading extends FetchRegionsState {}

class FetchRegionsSuccess extends FetchRegionsState {
  FetchRegionsSuccess(this.regions);

  final List<Region> regions;

  @override
  List<Object> get props => [regions];
}

class FetchRegionsFailure extends FetchRegionsState {
  
  final String message;

  FetchRegionsFailure(this.message);

  @override
  List<Object> get props => [message];
}

