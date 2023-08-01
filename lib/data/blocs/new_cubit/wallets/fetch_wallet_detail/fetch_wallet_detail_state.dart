part of 'fetch_wallet_detail_cubit.dart';

abstract class FetchWalletDetailState extends Equatable {
  const FetchWalletDetailState();

  @override
  List<Object> get props => [];
}

class FetchWalletDetailInitial extends FetchWalletDetailState {}

class FetchWalletDetailLoading extends FetchWalletDetailState {}

class FetchWalletDetailSuccess extends FetchWalletDetailState {
  FetchWalletDetailSuccess({this.walletNonWithdrawal, this.walletWithdrawal});

  final WalletHistoryDetailNonWithdrawal walletNonWithdrawal;
  final WalletHistoryDetailWithdrawal walletWithdrawal;

  @override
  List<Object> get props => [walletNonWithdrawal,walletWithdrawal];
}

class FetchWalletDetailFailure extends FetchWalletDetailState {
  
  final String message;

  FetchWalletDetailFailure(this.message);

  @override
  List<Object> get props => [message];
}
