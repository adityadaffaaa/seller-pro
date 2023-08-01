part of 'fetch_withdraw_rule_cubit.dart';

abstract class FetchWithdrawRuleState extends Equatable {
  const FetchWithdrawRuleState();

  @override
  List<Object> get props => [];
}

class FetchWithdrawRuleInitial extends FetchWithdrawRuleState {}

class FetchWithdrawRuleLoading extends FetchWithdrawRuleState {}

class FetchWithdrawRuleSuccess extends FetchWithdrawRuleState {
  FetchWithdrawRuleSuccess(this.ruleWithdraw);

  final List<WalletWithdrawRule> ruleWithdraw;

  @override
  List<Object> get props => [ruleWithdraw];
}

class FetchWithdrawRuleFailure extends FetchWithdrawRuleState {
  
  final String message;

  FetchWithdrawRuleFailure(this.message);
  
  @override
  List<Object> get props => [message];
}

