import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../repositories/order_repository.dart';

part 'order_langganan_telkom_state.dart';

class OrderLanggananTelkomCubit extends Cubit<OrderLanggananTelkomState> {
  OrderLanggananTelkomCubit() : super(OrderLanggananTelkomInitial());

  final OrderRepository _orderRepo = OrderRepository();

  Future<void> subcription({
    @required int productId,
    @required int variantId,
    @required String name,
    @required String phonenumber1,
    @required String phonenumber2,
    @required String gender,
    @required String bornPlace,
    @required String bornDate,
    @required String occupation,
    @required String motherName,
    @required String subdistrict,
    @required String district,
    @required String addressDetails,
    @required String rtNumber,
    @required String rwNumber,
    @required String postalCode,
    @required String latLong,
    @required String identityNumber,
    @required dynamic identityPhoto,
    @required dynamic identityBytes,
    @required dynamic selfiePhoto,
    @required dynamic selfieBytes,
    @required dynamic businessPhoto,
    @required dynamic businessBytes,
    @required String businessName,
    @required String npwpNumber,
    @required String billsToPay,
    @required String billsTotal,
  }) async {
    emit(OrderLanggananTelkomLoading());
    try {
      await _orderRepo.orderIndibizNet(
        productId: productId,
        variantId: variantId,
        name: name,
        phonenumber1: phonenumber1,
        phonenumber2: phonenumber2,
        gender: gender,
        bornPlace: bornPlace,
        bornDate: bornDate,
        occupation: occupation,
        motherName: motherName,
        subdistrict: subdistrict,
        district: district,
        addressDetails: addressDetails,
        rtNumber: rtNumber,
        rwNumber: rwNumber,
        postalCode: postalCode,
        latLong: latLong,
        identityNumber: identityNumber,
        identityPhoto: identityPhoto,
        identityBytes: identityBytes,
        selfiePhoto: selfiePhoto,
        selfieBytes: selfieBytes,
        businessPhoto: businessPhoto,
        businessBytes: businessBytes,
        businessName: businessName,
        npwpNumber: npwpNumber,
        billsToPay: billsToPay,
        billsTotal: billsTotal,
      );
      emit(OrderLanggananTelkomSuccess());
    } catch (error) {
      emit(OrderLanggananTelkomFailure(error.toString()));
    }
  }

  Future<void> subcriptionNoAuth({
    @required String slug,
    @required int productId,
    @required int variantId,
    @required String name,
    @required String phonenumber1,
    @required String phonenumber2,
    @required String gender,
    @required String bornPlace,
    @required String bornDate,
    @required String occupation,
    @required String motherName,
    @required String subdistrict,
    @required String district,
    @required String addressDetails,
    @required String rtNumber,
    @required String rwNumber,
    @required String postalCode,
    @required String latLong,
    @required String identityNumber,
    @required dynamic identityBytes,
    @required dynamic selfieBytes,
    @required dynamic businessBytes,
    @required String businessName,
    @required String npwpNumber,
    @required String billsToPay,
    @required String billsTotal,
  }) async {
    emit(OrderLanggananTelkomLoading());
    try {
      await _orderRepo.orderIndibizNetNoAuth(
        slug: slug,
        productId: productId,
        variantId: variantId,
        name: name,
        phonenumber1: phonenumber1,
        phonenumber2: phonenumber2,
        gender: gender,
        bornPlace: bornPlace,
        bornDate: bornDate,
        occupation: occupation,
        motherName: motherName,
        subdistrict: subdistrict,
        district: district,
        addressDetails: addressDetails,
        rtNumber: rtNumber,
        rwNumber: rwNumber,
        postalCode: postalCode,
        latLong: latLong,
        identityNumber: identityNumber,
        identityBytes: identityBytes,
        selfieBytes: selfieBytes,
        businessBytes: businessBytes,
        businessName: businessName,
        npwpNumber: npwpNumber,
        billsToPay: billsToPay,
        billsTotal: billsTotal,
      );
      emit(OrderLanggananTelkomSuccess());
    } catch (error) {
      emit(OrderLanggananTelkomFailure(error.toString()));
    }
  }
}
