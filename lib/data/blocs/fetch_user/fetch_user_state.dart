part of 'fetch_user_cubit.dart';

abstract class FetchUserState extends Equatable {
  const FetchUserState();

  @override
  List<Object> get props => [];
}

class FetchUserInitial extends FetchUserState {}

class FetchUserLoading extends FetchUserState {}

class FetchUserSuccess extends FetchUserState {
  FetchUserSuccess({@required this.user});

  final UserResponse user;

  @override
  List<Object> get props => [user];
}

class FetchUserFailure extends FetchUserState {
  final String message;

  FetchUserFailure(this.message);

  @override
  List<Object> get props => [message];
}
