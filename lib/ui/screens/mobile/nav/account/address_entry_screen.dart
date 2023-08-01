import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:beamer/beamer.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/choose_kecamatan/choose_kecamatan_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/kemacatan_search/kecamatan_search_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/recipent/add_recipent/add_recipent_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/recipent/edit_recipent/edit_recipent_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/models/new_models/location.dart';
import 'package:marketplace/data/repositories/repositories.dart';
import 'package:marketplace/ui/screens/mobile/nav/account/address_location_picker_screen.dart';
import 'package:marketplace/ui/screens/mobile/nav/account/update_address_screen.dart';
import 'package:marketplace/ui/widgets/input_label.dart';
import 'package:marketplace/ui/widgets/widgets.dart';

import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/colors.dart' as AppColor;

class AddressEntryScreen extends StatefulWidget {
  const AddressEntryScreen({
    Key key,
    this.recipent,
    this.isFromBsDeliveryAddress = false,
    this.triggerRefreshRecipent,
  }) : super(key: key);

  final Recipent recipent;
  final void Function() triggerRefreshRecipent;
  final bool isFromBsDeliveryAddress;

  @override
  _AddressEntryScreenState createState() => _AddressEntryScreenState();
}

class _AddressEntryScreenState extends State<AddressEntryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final RecipentRepository _recipentRepo = RecipentRepository();
  final _formKey = GlobalKey<FormState>();

  BeamState state = BeamState();

  final gs = GetStorage();

  RecipentLocationPicker recipentLocationPicker;

  AddRecipentCubit _addRecipentCubit;
  EditRecipentCubit _editRecipentCubit;

  TextEditingController _nameController;
  TextEditingController _phoneNumberController;
  TextEditingController _addressController;
  TextEditingController kecamatanCtrl;
  TextEditingController _emailController;
  TextEditingController _postalCodeController;
  TextEditingController _noteController;

  String selectedLocation;

  bool _isSubmitLoading;
  bool isUpdateEntry;
  bool isKecamatanValid = true;
  bool isPickerLocationValid = true;

  @override
  void initState() {
    isUpdateEntry = widget.recipent != null;
    recipentLocationPicker = isUpdateEntry
        ? RecipentLocationPicker(
            address: widget.recipent.address,
            latitude: widget.recipent.latitude,
            longitude: widget.recipent.longitude)
        : null;
    _addRecipentCubit = AddRecipentCubit();
    _editRecipentCubit = EditRecipentCubit();

    _nameController = TextEditingController(
        text: isUpdateEntry ? widget.recipent.name : null);
    _phoneNumberController = TextEditingController(
        text: isUpdateEntry
            ? AppExt.removeCodePhone(widget.recipent.phone)
            : null);
    _addressController = TextEditingController(
        text: isUpdateEntry ? widget.recipent.address : null);
    kecamatanCtrl = TextEditingController(
        text: isUpdateEntry ? widget.recipent.subdistrictId.toString() : null);
    _postalCodeController = TextEditingController(
        text: isUpdateEntry ? widget.recipent.postalCode : null);
    _emailController = TextEditingController(
        text: isUpdateEntry ? widget.recipent.email : null);
    _noteController = TextEditingController(
        text: isUpdateEntry ? widget.recipent.note : null);
    _isSubmitLoading = false;

    super.initState();
  }

  String validation(String value) {
    if (value.isEmpty) {
      return "Wajib diisi";
    }
    return null;
  }

  String validationPhone(String value) {
    if (value.isEmpty) {
      return "Wajib diisi";
    }
    /*if (value.length != 11) {
      return "Nomor telpon harus 11 digit";
    }*/
    return null;
  }

  String validationEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Email tidak valid";
    }
    return null;
  }

  void _handleSubmit() async {
    final subDistrictId =
        context.read<ChooseKecamatanCubit>().state.subDistrict;

    print("ID -> $subDistrictId");

    if (subDistrictId == null) {
      setState(() {
        isKecamatanValid = false;
        isPickerLocationValid = false;
      });
    } else {
      setState(() {
        isKecamatanValid = true;
        isPickerLocationValid = true;
      });
    }

    if (_formKey.currentState.validate()) {
      if (isKecamatanValid) {
        if (isUpdateEntry) {
          _editRecipentCubit.editRecipentAddress(
              recipentId: widget.recipent.id,
              name: _nameController.text.trim(),
              phone: int.parse('62${_phoneNumberController.text}'),
              address: recipentLocationPicker.address,
              email: _emailController.text.trim(),
              subdistrictId: subDistrictId ?? widget.recipent.subdistrictId,
              postalCode: int.parse(_postalCodeController.text.trim()),
              note: _noteController.text.trim(),
              isMainAddress: widget.recipent.isMainAddress);
        } else {
          _addRecipentCubit.addRecipent(
              name: _nameController.text.trim(),
              phone: '62${_phoneNumberController.text}',
              address: recipentLocationPicker.address,
              email: _emailController.text.trim(),
              subdistrictId: subDistrictId,
              postalCode: _postalCodeController.text.trim(),
              note: _noteController.text.trim(),
              latitude: recipentLocationPicker.latitude,
              longitude: recipentLocationPicker.longitude);
        }
        setState(() => _isSubmitLoading = false);
      }
    }
    setState(() => _isSubmitLoading = false);
  }

  @override
  void dispose() {
    _addRecipentCubit.close();
    _editRecipentCubit.close();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    kecamatanCtrl.dispose();
    _postalCodeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () {
        if (widget.isFromBsDeliveryAddress) {
          AppExt.popScreen(context, false);
        } else {
          AppExt.popScreen(context);
        }
        return;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => _addRecipentCubit),
          BlocProvider(create: (_) => _editRecipentCubit)
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener(
                bloc: _addRecipentCubit,
                listener: (context, state) {
                  if (state is AddRecipentSuccess) {
                    if (kIsWeb) {
                      BSFeedback.show(context,
                          title: "Tambah alamat sukses",
                          color: AppColor.success,
                          anotherWidget: Column(
                            children: [
                              RoundedButton.contained(
                                  label: "Tutup",
                                  onPressed: () {
                                    BlocProvider.of<BottomNavCubit>(context)
                                        .navItemTapped(3);
                                    context.beamToReplacementNamed('/');
                                    context
                                        .beamToReplacementNamed('/addressuser');
                                  })
                            ],
                          ));
                    } else {
                      if (widget.isFromBsDeliveryAddress) {
                        AppExt.popScreen(context, true);
                      } else {
                        AppExt.popScreen(context, state.data.id);
                      }
                      _recipentRepo.setRecipent(
                          id: state.data.id,
                          isMainAddress: state.data.isMainAddress,
                          name: state.data.name,
                          phone: state.data.phone,
                          email: state.data.email,
                          address: state.data.address,
                          subdistrictId: state.data.subdistrictId,
                          subdistrict: state.data.subdistrict,
                          postalCode: state.data.postalCode,
                          note: state.data.note);
                      ScaffoldMessenger.of(context)
                        ..showSnackBar(
                          SnackBar(
                            margin: EdgeInsets.zero,
                            duration: Duration(seconds: 2),
                            content: Text('Tambah alamat sukses'),
                            backgroundColor: AppColor.blue2,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                    }
                  }
                  if (state is AddRecipentFailure) {
                    /*  ScaffoldMessenger.of(context)
                      ..showSnackBar(
                        SnackBar(
                          margin: EdgeInsets.zero,
                          duration: Duration(seconds: 2),
                          content: Text('Terjadi Kesalahan'),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    debugPrint("ERROR ALAMAT :" + state.message); */
                    BSFeedback.show(context,
                        title: "Tambah alamat sukses",
                        color: AppColor.success,
                        anotherWidget: Column(
                          children: [
                            RoundedButton.contained(
                                label: "Tutup",
                                onPressed: () {
                                  AppExt.popUntilRoot(context);
                                  BlocProvider.of<BottomNavCubit>(context)
                                      .navItemTapped(3);
                                  context.beamToReplacementNamed('/');
                                  context
                                      .beamToReplacementNamed('/addressuser');
                                })
                          ],
                        ));
                  }
                }),
            BlocListener(
                bloc: _editRecipentCubit,
                listener: (context, state) {
                  if (state is EditRecipentSuccess) {
                    if (kIsWeb) {
                      BSFeedback.show(context,
                          title: "Ubah alamat berhasil",
                          color: AppColor.success,
                          anotherWidget: Column(
                            children: [
                              RoundedButton.contained(
                                  label: "Tutup",
                                  onPressed: () {
                                    // BlocProvider.of<BottomNavCubit>(context)
                                    //     .navItemTapped(3);
                                    // context.beamToReplacementNamed('/');
                                    // context
                                    //     .beamToReplacementNamed('/addressuser');
                                    AppExt.pushScreen(
                                        context, UpdateAddressScreen());
                                  })
                            ],
                          ));
                    } else {
                      AppExt.popScreen(context, true);
                      ScaffoldMessenger.of(context)
                        ..showSnackBar(
                          SnackBar(
                            margin: EdgeInsets.zero,
                            duration: Duration(seconds: 2),
                            content: Text('Ubah alamat berhasil'),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                    }
                  }
                  if (state is EditRecipentFailure) {
                    ScaffoldMessenger.of(context)
                      ..showSnackBar(
                        SnackBar(
                          margin: EdgeInsets.zero,
                          duration: Duration(seconds: 2),
                          content: Text('${state.message}'),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    debugPrint(state.message);
                  }
                })
          ],
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value:
                SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
            child: GestureDetector(
              onTap: () => AppExt.hideKeyboard(context),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: kIsWeb ? 425 : 600),
                  child: Scaffold(
                    key: _scaffoldKey,
                    backgroundColor: Colors.white,
                    body: SafeArea(
                      child: Stack(
                        children: [
                          NestedScrollView(
                            headerSliverBuilder: (BuildContext context,
                                bool innerBoxIsScrolled) {
                              return <Widget>[
                                SliverAppBar(
                                  //automaticallyImplyLeading: !kIsWeb,
                                  leading: IconButton(
                                      splashRadius: 20,
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.black,
                                      ),
                                      onPressed: kIsWeb
                                          ? () {
                                              if (!isUpdateEntry) {
                                                context.beamToReplacementNamed(
                                                    '/');
                                                BlocProvider.of<BottomNavCubit>(
                                                        context)
                                                    .navItemTapped(3);
                                                context.beamToReplacementNamed(
                                                    '/addressuser');
                                              } else
                                                AppExt.popScreen(context);
                                            }
                                          : () {
                                              AppExt.popScreen(context);
                                            }),
                                  textTheme:
                                      TextTheme(headline6: AppTypo.subtitle2),
                                  iconTheme: IconThemeData(color: Colors.black),
                                  backgroundColor: Colors.white,
                                  centerTitle: true,
                                  forceElevated: false,
                                  pinned: true,
                                  shadowColor: Colors.black54,
                                  floating: true,
                                  title: Text(
                                    isUpdateEntry
                                        ? "Ubah Alamat"
                                        : "Tambah Alamat",
                                    style: kIsWeb
                                        ? AppTypo.subtitle2
                                            .copyWith(color: Colors.black)
                                        : TextStyle(),
                                  ),
                                  brightness: Brightness.dark,
                                ),
                              ];
                            },
                            body: SingleChildScrollView(
                              physics: new BouncingScrollPhysics(),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        kIsWeb ? 15 : _screenWidth * (5 / 100),
                                    vertical:
                                        kIsWeb ? 10 : _screenWidth * (3 / 100)),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      !isUpdateEntry
                                          ? Text(
                                              "Mau dikirim kemana produk yang kamu beli?",
                                              style: AppTypo.h2.copyWith(
                                                  fontWeight: FontWeight.w500),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        height: !isUpdateEntry ? 25 : 0,
                                      ),
                                      InputLabel(
                                          title: "Nama Penerima",
                                          isRequired: true),
                                      SizedBox(height: 8),
                                      EditText(
                                        hintText: "Nama Penerima",
                                        inputType: InputType.text,
                                        controller: this._nameController,
                                        validator: validation,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      InputLabel(
                                          title: "No Telepon",
                                          isRequired: true),
                                      SizedBox(height: 8),
                                      EditText(
                                        keyboardType: TextInputType.phone,
                                        hintText: "Nomor Telepon Penerima",
                                        inputType: InputType.phone,
                                        controller: this._phoneNumberController,
                                        validator: validationPhone,
                                        inputFormatter: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r'^0')),
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r'^62+'))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      InputLabel(
                                          title: "Email", isRequired: false),
                                      SizedBox(height: 8),
                                      EditText(
                                        hintText: "Email anda",
                                        inputType: InputType.text,
                                        controller: this._emailController,
                                        validator: validationEmail,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      InputLabel(
                                          title: "Kecamatan", isRequired: true),
                                      SizedBox(height: 8),
                                      BlocBuilder<ChooseKecamatanCubit,
                                          ChooseKecamatanState>(
                                        builder: (context, state) {
                                          return EditText(
                                            hintText: "Lokasi komunitas",
                                            inputType: InputType.option,
                                            validator: validation,
                                            controller: this.kecamatanCtrl
                                              ..text = state.kecamatan,
                                            onTap: () =>
                                                showBSRegion(_screenWidth),
                                          );
                                        },
                                      ),
                                      !isKecamatanValid
                                          ? Text(
                                              "Wajib diisi",
                                              style: AppTypo.body1.copyWith(
                                                  color: AppColor.danger,
                                                  fontSize: 12),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      InputLabel(
                                          title: "Kodepos", isRequired: true),
                                      SizedBox(height: 8),
                                      EditText(
                                        hintText: "Kodepos",
                                        controller: this._postalCodeController,
                                        keyboardType: TextInputType.number,
                                        validator: validation,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      InputLabel(
                                        title: "Detail Alamat",
                                        isRequired: false,
                                      ),
                                      SizedBox(height: 8),
                                      EditText(
                                        hintText:
                                            "Pagar hitam sebelah warung mie ayam",
                                        inputType: InputType.field,
                                        controller: this._noteController,
                                      ),
                                      SizedBox(height: 8),
                                      //!kIsWeb ?
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: !isPickerLocationValid
                                                    ? AppColor.danger
                                                    : AppColor.silverFlashSale,
                                                width: !isPickerLocationValid
                                                    ? 1
                                                    : 2)),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          leading: Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.grey,
                                          ),
                                          minLeadingWidth: 0,
                                          title: Text(
                                            recipentLocationPicker != null
                                                ? recipentLocationPicker.address
                                                : "Tentukan Titik Lokasi",
                                            style: AppTypo.caption.copyWith(
                                                color: AppColor.textPrimary),
                                          ),
                                          trailing: Icon(
                                            Icons.chevron_right,
                                            color: AppColor.grey,
                                          ),
                                          onTap: () {
                                            AppExt.pushScreen(context,
                                                AddressLocationPickerScreen(
                                              onLocationPicker:
                                                  (RecipentLocationPicker
                                                      value) {
                                                setState(() {
                                                  recipentLocationPicker =
                                                      value;
                                                });
                                              },
                                            ));
                                          },
                                        ),
                                      ),
                                      //: SizedBox(),
                                      !isPickerLocationValid
                                          ? Text(
                                              "Wajib diisi",
                                              style: AppTypo.body1.copyWith(
                                                  color: AppColor.danger,
                                                  fontSize: 12),
                                            )
                                          : SizedBox(),
                                      SizedBox(height: 20),
                                      RoundedButton.contained(
                                        textColor: Colors.white,
                                        isLoading: _isSubmitLoading,
                                        isUpperCase: false,
                                        label:
                                            isUpdateEntry ? "Ubah" : "Simpan",
                                        onPressed: _handleSubmit,
                                      ),
                                      SizedBox(
                                        height: 45,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showBSRegion(double screenWidth) {
    final topPadding = MediaQuery.of(context).padding.top;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height - topPadding,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth * (15 / 100),
                    height: 7,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7.5 / 2),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Lokasi",
                  style: AppTypo.LatoBold.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: 16,
                ),
                EditText(
                  hintText: "Tulis min 3 karakter",
                  inputType: InputType.text,
                  onChanged: (String value) {
                    if (value.length >= 3) {
                      context
                          .read<KecamatanSearchCubit>()
                          .search(keyword: value);
                    }
                  },
                ),
                BlocBuilder<KecamatanSearchCubit, KecamatanSearchState>(
                  builder: (context, state) {
                    if (state is KecamatanSearchLoading) {
                      return Center(
                        child: RefreshProgressIndicator(),
                      );
                    }
                    if (state is KecamatanSearchFailure) {
                      return Text("Kecamatan tidak tersedia");
                    }
                    if (state is KecamatanSearchSuccess) {
                      final items = state.result;
                      return Expanded(
                        child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, i) {
                              return ListTile(
                                onTap: () {
                                  AppExt.popScreen(context);
                                  context
                                      .read<ChooseKecamatanCubit>()
                                      .chooseKecamatan(
                                          kecamatan:
                                              "${items[i].subdistrictName}, ${items[i].type} ${items[i].city}, ${items[i].province}",
                                          subDistrict: items[i].subdistrictId);
                                },
                                leading: Icon(
                                  Icons.location_on_outlined,
                                ),
                                title: Text(
                                  "${items[i].subdistrictName}, ${items[i].type} ${items[i].city}, ${items[i].province}",
                                  style: AppTypo.body1Lato
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                minLeadingWidth: 5,
                                contentPadding: EdgeInsets.zero,
                              );
                            }),
                      );
                    }
                    return SizedBox();
                  },
                )
              ],
            ),
          );
        });
  }
}
