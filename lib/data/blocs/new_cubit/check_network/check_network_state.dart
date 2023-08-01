part of 'check_network_cubit.dart';

abstract class CheckNetworkState extends Equatable {
  const CheckNetworkState();

  @override
  List<Object> get props => [];
}

class CheckNetworkInitial extends CheckNetworkState {}

class CheckNetworkLoading extends CheckNetworkState {}

class CheckNetworkSuccess extends CheckNetworkState {}

class CheckNetworkFailure extends CheckNetworkState {}
