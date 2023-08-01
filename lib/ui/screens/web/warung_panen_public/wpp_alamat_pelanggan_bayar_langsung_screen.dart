import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/data/blocs/new_cubit/choose_kecamatan/choose_kecamatan_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/models/new_models/alamat_pelanggan.dart';
import 'package:marketplace/data/repositories/new_repositories/recipent_repository.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/ui/widgets/rounded_button.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/responsive_layout.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;

class WppAlamatPelangganScreenBayarLangsung extends StatefulWidget {
  const WppAlamatPelangganScreenBayarLangsung(
      {Key key, @required this.productSelected, this.productVariantSelected})
      : super(key: key);

  final Products productSelected;
  final ProductVariant productVariantSelected;

  @override
  _WppAlamatPelangganScreenBayarLangsungState createState() =>
      _WppAlamatPelangganScreenBayarLangsungState();
}

class _WppAlamatPelangganScreenBayarLangsungState
    extends State<WppAlamatPelangganScreenBayarLangsung> {
  final _formKey = GlobalKey<FormState>();
  final RecipentRepository recipentRepo = RecipentRepository();
  // UserDataCubit _userDataCubit;

  /// untuk boolean checkbox seller

  final nameController = TextEditingController();
  final alamatController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final kecamatanController = TextEditingController();

  String selectedLocation;
  int selectedSubdistrictId;

  @override
  void initState() {
    // _userDataCubit = BlocProvider.of<UserDataCubit>(context);
    kecamatanController.text =
        "${recipentRepo.getSelectedRecipentNoAuth()['subdistrict']}, ${recipentRepo.getSelectedRecipentNoAuth()['city']}, ${recipentRepo.getSelectedRecipentNoAuth()['province']}";
    context.read<ChooseKecamatanCubit>().reset();
    // selectedLocation =
    //     "${recipentRepo.getSelectedRecipentNoAuth()['subdistrict']}, ${recipentRepo.getSelectedRecipentNoAuth()['city']}, ${recipentRepo.getSelectedRecipentNoAuth()['province']}";
    // selectedSubdistrictId =
    //     recipentRepo.getSelectedRecipentNoAuth()['subdistrict_id'];
    // debugPrint("roleid ${_userDataCubit.state.user}");
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    alamatController.dispose();
    emailController.dispose();
    kecamatanController.dispose();
    super.dispose();
  }

  // handleRegisteration(UserType userType) {
  //   final subDistrictId =
  //       context.read<ChooseKecamatanCubit>().state.subDistrict;
  // }

  String validation(String value) {
    if (value.isEmpty) {
      return "Wajib diisi";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      child: ResponsiveLayout(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  textTheme: TextTheme(headline6: AppTypo.subtitle2),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  forceElevated: false,
                  pinned: true,
                  shadowColor: Colors.black54,
                  floating: true,
                  iconTheme: IconThemeData(color: Colors.black),
                  title: Text(
                    "Alamat Pelanggan",
                    style: AppTypo.subtitle2,
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              physics: new BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama"),
                      SizedBox(height: 8),
                      EditText(
                        controller: nameController,
                        hintText: "Nama",
                        validator: validation,
                      ),
                      SizedBox(height: 16),
                      Text("No Telepon"),
                      SizedBox(height: 8),
                      EditText(
                        controller: phoneController,
                        hintText: "No Telepon (Whatsapp)",
                        inputType: InputType.phone,
                        keyboardType: TextInputType.number,
                        validator: validation,
                      ),
                      SizedBox(height: 16),
                      Text("Email"),
                      SizedBox(height: 8),
                      EditText(
                        controller: emailController,
                        hintText: "Email Anda",
                      ),
                      SizedBox(height: 16),
                      Text("Kecamatan"),
                      SizedBox(height: 8),
                      EditText(
                          enabled: false,
                          controller: kecamatanController,
                          hintText: "Pilih kecamatan"),
                      // ListTile(
                      //   contentPadding: EdgeInsets.zero,
                      //   onTap: () => showBSRegion(_screenWidth, onTap:
                      //       (kecamatan, kota, provinsi, valueIdKecamatan) {
                      //     setState(() {
                      //       selectedLocation = "$kecamatan,$kota,$provinsi";
                      //       selectedSubdistrictId = valueIdKecamatan;
                      //     });
                      //   }),
                      //   title: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       Icon(
                      //         Icons.location_on_outlined,
                      //         color: Colors.grey,
                      //       ),
                      //       SizedBox(
                      //         width: 8,
                      //       ),
                      //       Text(
                      //         selectedLocation ??
                      //             "Pilih kota atau kecamatan",
                      //         style: AppTypo.caption
                      //             .copyWith(color: Colors.grey),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 10),
                      Text("Detail Alamat"),
                      SizedBox(height: 8),
                      EditText(
                        controller: alamatController,
                        hintText: "Detail Alamat",
                        inputType: InputType.field,
                        validator: validation,
                      ),
                      SizedBox(height: 36),
                      RoundedButton.contained(
                          label: "Selanjutnya",
                          textColor: Colors.white,
                          isUpperCase: false,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              final AlamatPelanggan alamatPelanggan =
                                  AlamatPelanggan(
                                nama: nameController.text,
                                alamat: alamatController.text,
                                email: emailController.text,
                                telepon: phoneController.text,
                                kecamatan: kecamatanController.text,
                                idKecamatan:
                                    recipentRepo.getSelectedRecipentNoAuth()[
                                        'subdistrict_id'],
                              );

                              recipentRepo.setRecipentUserNoAuth(
                                  subdistrictId:
                                      recipentRepo.getSelectedRecipentNoAuth()[
                                          'subdistrict_id'],
                                  subdistrict:
                                      recipentRepo.getSelectedRecipentNoAuth()[
                                          'subdistrict'],
                                  city: recipentRepo
                                      .getSelectedRecipentNoAuth()['city'],
                                  province: recipentRepo
                                      .getSelectedRecipentNoAuth()['province'],
                                  name: nameController.text,
                                  address: alamatController.text,
                                  phone: phoneController.text);

                              context.beamToNamed(
                                  '/wpp/paymentlangsung?dt=${AppExt.encryptMyData(jsonEncode(widget.productSelected))}&dv=${AppExt.encryptMyData(jsonEncode(widget.productVariantSelected))}&ap=${AppExt.encryptMyData(jsonEncode(alamatPelanggan))}');
                            }

                            // AppExt.pushScreen(context, CheckoutScreen(cart: widget.cart,));
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
