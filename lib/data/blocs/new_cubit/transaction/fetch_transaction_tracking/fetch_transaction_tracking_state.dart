part of 'fetch_transaction_tracking_cubit.dart';

@immutable
abstract class FetchTransactionTrackingState {}

class FetchTransactionTrackingInitial extends FetchTransactionTrackingState {}

class FetchTransactionTrackingLoading extends FetchTransactionTrackingState {}

class FetchTransactionTrackingSuccess extends FetchTransactionTrackingState {
  FetchTransactionTrackingSuccess(this.data);

  final TrackingOrder data;

  @override
  List<Object> get props => [data];
}

class FetchTransactionTrackingFailure extends FetchTransactionTrackingState {
  
  final String message;

  FetchTransactionTrackingFailure(this.message);

  @override
  List<Object> get props => [message];
}
