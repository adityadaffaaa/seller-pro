part of 'order_with_saldo_panen_otp_bloc.dart';

abstract class OrderWithSaldoPanenOtpState extends Equatable {
  const OrderWithSaldoPanenOtpState();
  
  @override
  List<Object> get props => [];
}

class OrderWithSaldoPanenOtpInitial extends OrderWithSaldoPanenOtpState {}

class OrderWithSaldoPanenOtpLoading extends OrderWithSaldoPanenOtpState {}

class OrderWithSaldoPanenOtpSuccess extends OrderWithSaldoPanenOtpState {
  OrderWithSaldoPanenOtpSuccess(this.data);

  final WalletPayment data;

  @override
  List<Object> get props => [data];
}

class OrderWithSaldoPanenOtpFailure extends OrderWithSaldoPanenOtpState {
  
  final String message;

  OrderWithSaldoPanenOtpFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WithdrawWalletResendOtpLoading extends OrderWithSaldoPanenOtpState {}

class WithdrawWalletResendOtpSuccess extends OrderWithSaldoPanenOtpState {}

class WithdrawWalletResendOtpFailure extends OrderWithSaldoPanenOtpState {
  
  final String message;

  WithdrawWalletResendOtpFailure(this.message);

  @override
  List<Object> get props => [message];
}
