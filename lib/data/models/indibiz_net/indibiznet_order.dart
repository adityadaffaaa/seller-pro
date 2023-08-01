import 'package:flutter/foundation.dart';

class BiodataTemp {
  BiodataTemp({
    this.name,
    this.phonenumber1,
    this.phonenumber2,
    this.gender,
    this.bornPlace,
    this.bornDate,
    this.occupation,
    this.motherName,
    this.subdistrict,
    this.district,
    this.addressDetails,
    this.rtNumber,
    this.rwNumber,
    this.postalCode,
    this.latLong,
    this.identityNumber,
    this.identityPhoto,
    this.identityBytes,
    this.selfiePhoto,
    this.selfieBytes,
    this.businessPhoto,
    this.businessBytes,
    this.businessName,
    this.npwpNumber,
    this.billsToPay,
    this.billsTotal,
  });

  final String name;
  final String phonenumber1;
  final String phonenumber2;
  final String gender;
  final String bornPlace;
  final String bornDate;
  final String occupation;
  final String motherName;
  final String subdistrict;
  final String district;
  final String addressDetails;
  final String rtNumber;
  final String rwNumber;
  final String postalCode;
  final String latLong;
  final String identityNumber;
  final dynamic identityPhoto;
  final dynamic identityBytes;//
  final dynamic selfiePhoto;
  final dynamic selfieBytes;//
  final dynamic businessPhoto;
  final dynamic businessBytes;//
  final String businessName;
  final String npwpNumber;
  final String billsToPay;
  final String billsTotal;

  factory BiodataTemp.fromJson(Map<String, dynamic> json) => BiodataTemp(
        name: json["nama_pelanggan"],
        phonenumber1: json["no_telp"],
        phonenumber2: json["no_telp_2"],
        gender: json["jenis_kelamin"],
        bornPlace: json["tempat_lahir"],
        bornDate: json["tanggal_lahir"],
        occupation: json["pekerjaan"],
        motherName: json["nama_ibu_kandung"],
        subdistrict: json["kecamatan"],
        district: json["desa_kelurahan"],
        addressDetails: json["detail_alamat"],
        rtNumber: json["no_rt"],
        rwNumber: json["no_rw"],
        postalCode: json["kode_pos"],
        latLong: json["lat_long"],
        identityNumber: json["no_identitas"],
        identityPhoto: json["foto_identitas"],
        identityBytes: json["foto_identitas"],
        selfiePhoto: json["foto_selfie"],
        selfieBytes: json["foto_selfie"],
        businessPhoto: json["foto_usaha"],
        businessBytes: json["foto_usaha"],
        businessName: json["nama_usaha"],
        npwpNumber: json["npwp"],
        billsToPay: json["tagihan"],
        billsTotal: json["total_tagihan"],
      );

  Map<String, dynamic> toJson() => {
        "nama_pelanggan": name,
        "no_telp": phonenumber1,
        "no_telp_2": phonenumber2,
        "jenis_kelamin": gender,
        "tempat_lahir": bornPlace,
        "tanggal_lahir": bornDate,
        "pekerjaan": occupation,
        "nama_ibu_kandung": motherName,
        "kecamatan": subdistrict,
        "desa_kelurahan": district,
        "detail_alamat": addressDetails,
        "no_rt": rtNumber,
        "no_rw": rwNumber,
        "kode_pos": postalCode,
        "lat_long": latLong,
        "no_identitas": identityNumber,
        "foto_identitas": kIsWeb ? identityBytes : identityPhoto,
        "foto_selfie": kIsWeb ? selfieBytes : selfiePhoto,
        "foto_usaha": kIsWeb ? businessBytes : businessPhoto,
        "nama_usaha": businessName,
        "npwp": npwpNumber,
        "tagihan": billsToPay,
        "total_tagihan": billsTotal,
      };
}
