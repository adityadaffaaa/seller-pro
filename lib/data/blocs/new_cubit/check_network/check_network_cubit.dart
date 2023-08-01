import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'check_network_state.dart';

class CheckNetworkCubit extends Cubit<CheckNetworkState> {
  CheckNetworkCubit() : super(CheckNetworkInitial());

  void checker() async {
    emit(CheckNetworkLoading());
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      emit(CheckNetworkFailure());
    } else {
      emit(CheckNetworkSuccess());
    }
  }
}
