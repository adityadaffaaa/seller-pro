part of 'fetch_home_slider_cubit.dart';

abstract class FetchHomeSliderState extends Equatable {
  const FetchHomeSliderState();

  @override
  List<Object> get props => [];
}

class FetchHomeSliderInitial extends FetchHomeSliderState {}

class FetchHomeSliderLoading extends FetchHomeSliderState {}

class FetchHomeSliderSuccess extends FetchHomeSliderState {
  FetchHomeSliderSuccess(this.homeSliders);

  final List<HomeSlider> homeSliders;

  @override
  List<Object> get props => [homeSliders];
}

class FetchHomeSliderFailure extends FetchHomeSliderState {
  final String message;

  FetchHomeSliderFailure(this.message);

  @override
  List<Object> get props => [message];
}
