part of 'fetch_google_maps_url_cubit.dart';

abstract class FetchGoogleMapsUrlState extends Equatable {
  const FetchGoogleMapsUrlState();

  @override
  List<Object> get props => [];
}

class FetchGoogleMapsUrlInitial extends FetchGoogleMapsUrlState {}

class FetchGoogleMapsUrlLoading extends FetchGoogleMapsUrlState {}

class FetchGoogleMapsUrlSuccess extends FetchGoogleMapsUrlState {
  FetchGoogleMapsUrlSuccess(this.data);

  final GoogleMapsUrl data;

  @override
  List<Object> get props => [data];
}

class FetchGoogleMapsUrlFailure extends FetchGoogleMapsUrlState {
  
  final String message;

  FetchGoogleMapsUrlFailure(this.message);

  @override
  List<Object> get props => [message];
}
