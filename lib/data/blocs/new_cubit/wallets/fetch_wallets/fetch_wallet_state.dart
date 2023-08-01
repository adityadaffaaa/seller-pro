part of 'fetch_wallet_cubit.dart';

abstract class FetchWalletState extends Equatable {
  const FetchWalletState();

  @override
  List<Object> get props => [];
}

class FetchWalletInitial extends FetchWalletState {}

class FetchWalletLoading extends FetchWalletState {}

class FetchWalletSuccess extends FetchWalletState {
  FetchWalletSuccess(this.wallets);

  final List<WalletHistory> wallets;

  @override
  List<Object> get props => [wallets];
}

class FetchWalletFailure extends FetchWalletState {
  
  final String message;

  FetchWalletFailure(this.message);

  @override
  List<Object> get props => [message];
}
