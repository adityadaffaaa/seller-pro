part of 'fetch_filter_location_cubit.dart';

abstract class FetchFilterLocationState extends Equatable {
  const FetchFilterLocationState();

  @override
  List<Object> get props => [];
}

class FetchFilterLocationInitial extends FetchFilterLocationState {}

class FetchFilterLocationLoading extends FetchFilterLocationState {}

class FetchFilterLocationSuccess extends FetchFilterLocationState {
  FetchFilterLocationSuccess(this.location);

  final LocationFilter location;

  @override
  List<Object> get props => [location];
}

class FetchFilterLocationFailure extends FetchFilterLocationState {
  
  final String message;

  FetchFilterLocationFailure(this.message);

  @override
  List<Object> get props => [message];
}

