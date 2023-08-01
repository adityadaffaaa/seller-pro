part of 'withdraw_wallet_otp_bloc.dart';

abstract class WithdrawWalletOtpState extends Equatable {
  const WithdrawWalletOtpState();
  
  @override
  List<Object> get props => [];
}

class WithdrawWalletOtpInitial extends WithdrawWalletOtpState {}

class WithdrawWalletOtpLoading extends WithdrawWalletOtpState {}

class WithdrawWalletOtpSuccess extends WithdrawWalletOtpState {}

class WithdrawWalletOtpFailure extends WithdrawWalletOtpState {
  
  final String message;

  WithdrawWalletOtpFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WithdrawWalletResendOtpLoading extends WithdrawWalletOtpState {}

class WithdrawWalletResendOtpSuccess extends WithdrawWalletOtpState {}

class WithdrawWalletResendOtpFailure extends WithdrawWalletOtpState {
  
  final String message;

  WithdrawWalletResendOtpFailure(this.message);

  @override
  List<Object> get props => [message];
}