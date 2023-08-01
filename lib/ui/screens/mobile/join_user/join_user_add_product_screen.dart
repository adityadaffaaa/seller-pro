import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/fetch_categories/fetch_categories_cubit.dart';
import 'package:marketplace/data/blocs/fetch_subcategories/fetch_subcategories_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/add_product_supplier/add_product_supplier_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/supplier/fetch_add_product_fee_service/fetch_add_product_fee_service_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/supplier/post_product/post_add_product_supplier_cubit.dart';
import 'package:marketplace/data/models/models.dart' as modelCategory;
import 'package:marketplace/data/models/new_models/supplier.dart';
import 'package:marketplace/ui/screens/mobile/join_user/widgets/add_subkategori_product.dart';
import 'package:marketplace/ui/screens/mobile/producer_dashboard/producer_dashboard_screen.dart';
import 'package:marketplace/ui/widgets/bs_feedback.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/ui/widgets/input_label.dart';
import 'package:marketplace/ui/widgets/rounded_button.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:pattern_formatter/pattern_formatter.dart';

import 'widgets/add_kategori_product.dart';
import 'widgets/add_photo_product.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;

class JoinUserAddProductScreen extends StatefulWidget {
  const JoinUserAddProductScreen({Key key, this.item}) : super(key: key);

  final SupplierDataResponseItem item;

  @override
  _JoinUserAddProductScreenState createState() =>
      _JoinUserAddProductScreenState();
}

class _JoinUserAddProductScreenState extends State<JoinUserAddProductScreen> {
  FetchCategoriesCubit _fetchCategoriesCubit;
  FetchSubcategoriesCubit _fetchSubcategoriesCubit;
  FetchAddProductFeeServiceCubit _fetchAddProductFeeServiceCubit;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _namaController,
      _linkController,
      _beratController,
      _hargaController,
      _stockController,
      _komisiController,
      _satuanController,
      _deskripsiController,
      _categoryController,
      _subCategoryController,
      _mainPhotoProductController;

  bool isMainPhotoFilled;
  bool showFinalPriceInfo;
  bool isPriceSupplierEnable;
  bool isCommissionEnable;
  int finalPrice = 0;
  int serviceFee = 0;

  @override
  void initState() {
    showFinalPriceInfo = true;
    isPriceSupplierEnable = true;
    isCommissionEnable = false;
    isMainPhotoFilled = true;
    _fetchCategoriesCubit = FetchCategoriesCubit()..load();
    _fetchSubcategoriesCubit = FetchSubcategoriesCubit();
    _fetchAddProductFeeServiceCubit = FetchAddProductFeeServiceCubit();
    if (widget.item == null) {
      debugPrint("reset");
      context.read<AddProductSupplierCubit>().reset();
    }
    //controller
    _namaController = TextEditingController(
        text: widget.item != null ? widget.item.productName : "");
    _linkController = TextEditingController(text: "");
    _beratController = TextEditingController(
        text: widget.item != null ? widget.item.productWeight.toString() : "");
    _hargaController = TextEditingController(
        text: widget.item != null ? widget.item.productPrice.toString() : "");
    _stockController = TextEditingController(
        text: widget.item != null ? widget.item.productStock.toString() : "");
    _komisiController = TextEditingController(
        text: widget.item != null ? widget.item.commission.toString() : "");
    _satuanController = TextEditingController(
        text: widget.item != null ? widget.item.productUnit.toString() : "");
    _deskripsiController = TextEditingController(
        text: widget.item != null ? widget.item.productDescription : "");
    _mainPhotoProductController = TextEditingController(
        text: widget.item != null ? widget.item.coverPhoto.toString() : "");
    _categoryController = TextEditingController(
        text: widget.item != null ? widget.item.category.toString() : "");
    _subCategoryController = TextEditingController(
        text: widget.item != null ? widget.item.subCategoryId.toString() : "");
    _komisiController = TextEditingController(
        text: widget.item != null
            ? widget.item.commissionPrice.toString()
            : ""); // BUG

    if (widget.item != null) {
      _fetchAddProductFeeServiceCubit.fetchFee(
          price: widget.item.productPrice + widget.item.commissionPrice);
    }

    _hargaController.addListener(checkFinalSellingPrice);
    _komisiController.addListener(checkFinalSellingPrice);

    super.initState();
  }

  @override
  void dispose() {
    _fetchCategoriesCubit.close();
    _fetchSubcategoriesCubit.close();
    _fetchAddProductFeeServiceCubit.close();
    _namaController.dispose();
    _linkController.dispose();
    _beratController.dispose();
    _hargaController.dispose();
    _satuanController.dispose();
    _stockController.dispose();
    _komisiController.dispose();
    _deskripsiController.dispose();
    _categoryController.dispose();
    _subCategoryController.dispose();
    super.dispose();
  }

  //==============VALIDATION==============

  String validation(String value) {
    if (value.isEmpty) {
      return "Wajib Isi";
    }
    return null;
  }

  // String validationSupplierPrice(String value) {
  //   if (value.isEmpty) {
  //     isCommissionEnable = false;
  //     return "Wajib Isi";
  //   }else{
  //     isCommissionEnable = true;
  //   }
  //   return null;
  // }

  String validationWeight(String value) {
    if (value.isEmpty) {
      return "Wajib Isi";
    }
    if (value.contains(",") || value.contains(".")) {
      return "Masukkan angka tanpa titik atau koma";
    }
    return null;
  }

  String commisionValidation(String value) {
    if (value.isEmpty) {
      return "Wajib Isi";
    }
    if (_hargaController.text.isEmpty) {
      return "Isi harga produk terlebih dahulu";
    }
    if (int.parse(AppExt.deleteAllComma(value)) >
        int.parse(AppExt.deleteAllComma(_hargaController.text))) {
      showFinalPriceInfo = false;
      return "komisi Reseller tidak boleh melebihi harga produk";
    }
    return null;
  }

  void checkIsMainPhotoFilled() {
    if (_mainPhotoProductController.text.isNotEmpty) {
      setState(() {
        isMainPhotoFilled = true;
      });
    } else {
      setState(() {
        isMainPhotoFilled = false;
      });
    }
  }

  void checkFinalSellingPrice() {
    if (_hargaController.text.trim().isEmpty ||
        _komisiController.text.trim().isEmpty) {
      setState(() {
        showFinalPriceInfo = false;
      });
    } else {
      showFinalPriceInfo = true;
      _fetchAddProductFeeServiceCubit.fetchFee(
          price: int.parse(AppExt.deleteAllComma(_hargaController.text)) +
              int.parse(AppExt.deleteAllComma(_komisiController.text)));
    }
  }

  Widget finalPriceInfo() {
    return showFinalPriceInfo
        ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 13, 13, 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColor.primary, width: 1),
                color: AppColor.bgBadgeBlue,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info, color: AppColor.primary),
                  SizedBox(width: 3),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: RichText(
                              text: TextSpan(
                                text: "Harga jual final",
                                style: AppTypo.body1Lato,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: " Rp.${AppExt.toRupiah(finalPrice)} ",
                                    style: AppTypo.body1Lato.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primary),
                                  ),
                                  TextSpan(
                                    text:
                                        "(termasuk biaya layanan sebesar Rp. ${AppExt.toRupiah(serviceFee)})",
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    final item = context.read<AddProductSupplierCubit>().state;

    return MultiBlocListener(
      listeners: [
        BlocListener<AddProductSupplierCubit, AddProductSupplierState>(
          listenWhen: (prev, curr) => prev.categoryId != curr.categoryId,
          listener: (context, state) {
            _fetchSubcategoriesCubit.fetchSubcategories(state.categoryId);
          },
        ),
        BlocListener<PostAddProductSupplierCubit, PostAddProductSupplierState>(
          listener: (context, state) {
            debugPrint("listener state $state");
            if (state is PostAddProductSupplierFailure) {
              // BSFeedback.show(context, title: state.result);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.result)));
            }
            if (state is PostAddProductSupplierSuccess) {
              if (!kIsWeb) {
                AppExt.popUntilRoot(context);
                BlocProvider.of<BottomNavCubit>(context).navItemTapped(3);
                AppExt.pushScreen(
                    context,
                    ProducerDashboardScreen(
                      isSupplier: true,
                    ));
              } else {
                AppExt.popScreen(context);
              }

              // ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text(state.message),));
              BSFeedback.show(context,
                  title: widget.item != null
                      ? "Produk berhasil diubah"
                      : "Produk berhasil ditambahkan dan akan ditinjau oleh admin");
            }
          },
        ),
        BlocListener(
            bloc: _fetchAddProductFeeServiceCubit,
            listener: (context, state) {
              if (state is FetchAddProductFeeServiceSuccess) {
                setState(() {
                  showFinalPriceInfo = true;
                  serviceFee = state.data.cost;
                  finalPrice = int.parse(
                          AppExt.deleteAllComma(_hargaController.text)) +
                      int.parse(AppExt.deleteAllComma(_komisiController.text)) +
                      serviceFee;
                });
              }
            })
      ],
      child: WillPopScope(
        onWillPop: () {
          AppExt.popUntilRoot(context);
          BlocProvider.of<BottomNavCubit>(context).navItemTapped(3);
          AppExt.pushScreen(
              context,
              ProducerDashboardScreen(
                isSupplier: true,
              ));
          return;
        },
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  splashRadius: 20,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    AppExt.popScreen(context);
                  },
                ),
                iconTheme: IconThemeData(color: AppColor.black),
                backgroundColor: Colors.white,
                title: Text(
                  widget.item != null ? "Ubah Produk" : "Tambah Produk",
                  style: AppTypo.subtitle2,
                ),
                centerTitle: true,
                elevation: 0,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputLabel(title: "Upload Foto Produk"),
                        SizedBox(
                          height: 8,
                        ),
                        AddPhotoProduct(
                          isUpdateForm: widget.item != null,
                          checkMainPhoto: (value) {
                            _mainPhotoProductController..text = value;
                            debugPrint("MADRID" + value);
                          },
                        ),
                        !isMainPhotoFilled
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "Foto utama wajib diupload !",
                                  style: AppTypo.body1Lato
                                      .copyWith(color: AppColor.danger),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 16,
                        ),
                        InputLabel(
                            title: "Link Video Produk (tidak wajib diisi)",
                            isRequired: false),
                        SizedBox(
                          height: 8,
                        ),
                        EditText(
                          controller: _linkController,
                          hintText: "",
                          keyboardType: TextInputType.url,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InputLabel(title: "Nama Produk"),
                        SizedBox(
                          height: 8,
                        ),
                        EditText(
                          controller: _namaController,
                          hintText: "",
                          validator: validation,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InputLabel(title: "Kategori Produk"),
                        SizedBox(
                          height: 8,
                        ),
                        BlocBuilder(
                          bloc: _fetchCategoriesCubit,
                          builder: (context, state) {
                            if (state is FetchCategoriesLoading) {
                              return Center(
                                child: RefreshProgressIndicator(),
                              );
                            }
                            if (state is FetchCategoriesSuccess) {
                              return BlocBuilder<AddProductSupplierCubit,
                                  AddProductSupplierState>(
                                builder: (context, product) {
                                  return EditText(
                                    controller: _categoryController,
                                    hintText: "",
                                    inputType: InputType.option,
                                    validator: validation,
                                    onTap: () {
                                      if (state.categories.length != 0) {
                                        _showCategoryDialog(
                                            context: context,
                                            items: state.categories,
                                            onSelected: (String value) {
                                              _categoryController..text = value;
                                            });
                                      }
                                      //   _showSatuanDialog(
                                      //       context: context, satuan: ["gr", "kg"]);
                                    },
                                  );

                                  //  AddKategoriProduct(
                                  //   name: product.categoryName != null
                                  //       ? product.categoryName
                                  //       : widget.item != null
                                  //           ? widget.item.category
                                  //           : '',
                                  //   categories: state.categories,
                                  //   checkCategory: (value) {
                                  //     _categoryController..text = value;
                                  //   },
                                  // );
                                },
                              );
                            }
                            return AddKategoriProduct(
                              name: "Error",
                            );
                          },
                        ),
                        BlocBuilder(
                          bloc: _fetchSubcategoriesCubit,
                          builder: (context, state) {
                            if (state is FetchSubcategoriesLoading) {
                              return Center(
                                child: RefreshProgressIndicator(),
                              );
                            }
                            if (state is FetchSubcategoriesSuccess) {
                              return BlocBuilder<AddProductSupplierCubit,
                                  AddProductSupplierState>(
                                builder: (context, product) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      InputLabel(title: "Sub Kategori"),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      AddSubkategoriProduct(
                                        name: product.subCategoryName,
                                        categories: state.subcategories,
                                        checkSubCategory: (value) {
                                          _subCategoryController..text = value;
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            if (state is FetchSubcategoriesFailure) {
                              return AddKategoriProduct(
                                name: "Error",
                              );
                            }
                            return SizedBox();
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputLabel(title: "Berat"),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  EditText(
                                      controller: _beratController,
                                      hintText: 'Masukkan berat',
                                      keyboardType: TextInputType.number,
                                      validator: validationWeight,
                                      padding: EdgeInsets.only(left: 10)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputLabel(title: "Satuan"),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  BlocBuilder<AddProductSupplierCubit,
                                          AddProductSupplierState>(
                                      builder: (context, state) {
                                    return EditText(
                                      controller: _satuanController
                                        ..text = state.satuan,
                                      hintText: state.satuan ?? "",
                                      inputType: InputType.option,
                                      validator: validation,
                                      onTap: () {
                                        _showSatuanDialog(
                                            context: context,
                                            satuan: ["gr", "kg"]);
                                      },
                                    );
                                  })
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputLabel(title: "Harga Produk"),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  EditText(
                                    controller: _hargaController,
                                    hintText: '',
                                    enabled: isPriceSupplierEnable,
                                    inputType: InputType.price,
                                    keyboardType: TextInputType.number,
                                    validator: validation,
                                    inputFormatter: [ThousandsFormatter()],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputLabel(title: "Stok"),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  EditText(
                                    controller: _stockController,
                                    hintText: '',
                                    keyboardType: TextInputType.number,
                                    validator: validation,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InputLabel(title: "Komisi Reseller (Rp)"),
                        SizedBox(
                          height: 8,
                        ),
                        EditText(
                          controller: _komisiController,
                          hintText: '',
                          inputType: InputType.price,
                          keyboardType: TextInputType.number,
                          validator: commisionValidation,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          // enabled: isCommissionEnable,
                          inputFormatter: [ThousandsFormatter()],
                        ),
                        BlocBuilder(
                          bloc: _fetchAddProductFeeServiceCubit,
                          builder: (context, state) {
                            return state is FetchAddProductFeeServiceLoading
                                ? Center(
                                    child: RefreshProgressIndicator(),
                                  )
                                : state is FetchAddProductFeeServiceFailure
                                    ? SizedBox.shrink()
                                    : state is FetchAddProductFeeServiceSuccess
                                        ? finalPriceInfo()
                                        : SizedBox.shrink();
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        // Text(
                        //   "Grosir",
                        //   style: AppTypo.caption,
                        // ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        // AddGrosirList(),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        // Text(
                        //   "Varian",
                        //   style: AppTypo.caption,
                        // ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        // AddVarianList(),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        InputLabel(title: "Deskripsi"),
                        SizedBox(
                          height: 8,
                        ),
                        EditText(
                          controller: _deskripsiController,
                          hintText: "",
                          inputType: InputType.field,
                          validator: validation,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: BlocBuilder<PostAddProductSupplierCubit,
                              PostAddProductSupplierState>(
                            builder: (context, state) {
                              if (state is PostAddProductSupplierLoading) {
                                return Center(
                                  child: RefreshProgressIndicator(),
                                );
                              }
                              return RoundedButton.contained(
                                // disabled: inputNotValid,
                                isUpperCase: false,
                                textColor: Colors.white,
                                onPressed: () {
                                  // debugPrint("jumlah harga : " +
                                  //     AppExt.deleteAllComma(_hargaController.text));

                                  // debugPrint(" KOMISI PERSEN: " +
                                  //     AppExt.commisionConvert(
                                  //             int.parse(AppExt.deleteAllComma(
                                  //                 _hargaController.text)),
                                  //             int.parse(AppExt.deleteAllComma(
                                  //                 _komisiController.text)))
                                  //         .toString());

                                  if (_formKey.currentState.validate()) {
                                    checkIsMainPhotoFilled();
                                    final product = context
                                        .read<AddProductSupplierCubit>()
                                        .state;
                                    List<String> listPhoto = [];
                                    List<Uint8List> listPhotoByte = [];
                                    if (product.foto1.contains('https')) {
                                      listPhoto = [];
                                    } else {
                                      if (product.foto1 != null) {
                                        listPhoto.add(product.foto1);
                                        listPhotoByte.add(product.fotoByte1);
                                      }
                                      if (product.foto2 != null) {
                                        listPhoto.add(product.foto2);
                                        listPhotoByte.add(product.fotoByte2);
                                      }
                                      if (product.foto3 != null) {
                                        listPhoto.add(product.foto3);
                                        listPhotoByte.add(product.fotoByte3);
                                      }
                                      if (product.foto4 != null) {
                                        listPhoto.add(product.foto4);
                                        listPhotoByte.add(product.fotoByte4);
                                      }
                                    }

                                    // final data = json.encode({
                                    //   "name": _namaController.text,
                                    //   "categoryId": product.subCategoryId,
                                    //   "weight": int.parse(_beratController.text),
                                    //   "unit": product.satuan,
                                    //   "price": 1000,
                                    //   "stock": int.parse(_stockController.text),
                                    //   "description": _deskripsiController.text,
                                    //   "commision": AppExt.commisionConvert(
                                    //       int.parse(AppExt.deleteAllComma(
                                    //           _hargaController.text)),
                                    //       int.parse(AppExt.deleteAllComma(
                                    //           _komisiController.text))),
                                    //   "link": _linkController.text,
                                    //   "productPhoto": listPhoto,
                                    //   // "productPhotoByte": listPhotoByte,
                                    //   "hargaGrosir": product.grosirHarga,
                                    //   "minimumOrder": product.grosirMinimumBeli,
                                    //   "varianType": product.varianId1,
                                    //   "varianName": product.varianName1,
                                    //   "varianPrice": product.varianHarga,
                                    //   "varianStock": product.varianStok
                                    // });
                                    // debugPrint("mydata $data");
                                    if (_mainPhotoProductController
                                        .text.isNotEmpty) {
                                      if (widget.item != null) {
                                        context
                                            .read<PostAddProductSupplierCubit>()
                                            .editProduct(
                                              productId: widget.item.id,
                                              name: _namaController.text,
                                              categoryId: int.parse(
                                                  _subCategoryController.text),
                                              weight: int.parse(
                                                  _beratController.text),
                                              unit: _satuanController.text,
                                              price: int.parse(
                                                  AppExt.deleteAllComma(
                                                      _hargaController.text)),
                                              stock: int.parse(
                                                  _stockController.text),
                                              description:
                                                  _deskripsiController.text,
                                              commision: int.parse(
                                                  AppExt.deleteAllComma(
                                                      _komisiController.text)),
                                              // AppExt.commisionConvert(
                                              //     int.parse(AppExt.deleteAllComma(
                                              //         _hargaController.text)),
                                              //     int.parse(AppExt.deleteAllComma(
                                              //         _komisiController.text))),
                                              link: _linkController.text,
                                              productPhoto: listPhoto,
                                              productPhotoByte: listPhotoByte,
                                              hargaGrosir: product.grosirHarga,
                                              minimumOrder:
                                                  product.grosirMinimumBeli,
                                              varianType: product.varianId1,
                                              varianName: product.varianName1,
                                              varianPrice: product.varianHarga,
                                              varianStock: product.varianStok,
                                            );
                                      } else {
                                        context
                                            .read<PostAddProductSupplierCubit>()
                                            .addProduct(
                                              name: _namaController.text,
                                              categoryId: product.subCategoryId,
                                              weight: int.parse(
                                                  _beratController.text),
                                              unit: product.satuan,
                                              price: int.parse(
                                                  AppExt.deleteAllComma(
                                                      _hargaController.text)),
                                              stock: int.parse(
                                                  _stockController.text),
                                              description:
                                                  _deskripsiController.text,
                                              commision: int.parse(
                                                  AppExt.deleteAllComma(
                                                      _komisiController.text)),
                                              // AppExt.commisionConvert(
                                              //     int.parse(AppExt.deleteAllComma(
                                              //         _hargaController.text)),
                                              //     int.parse(AppExt.deleteAllComma(
                                              //         _komisiController.text))),
                                              link: _linkController.text,
                                              productPhoto:
                                                  listPhoto.length == 0
                                                      ? null
                                                      : listPhoto,
                                              productPhotoByte: listPhotoByte,
                                              hargaGrosir: product.grosirHarga,
                                              minimumOrder:
                                                  product.grosirMinimumBeli,
                                              varianType: product.varianId1,
                                              varianName: product.varianName1,
                                              varianPrice: product.varianHarga,
                                              varianStock: product.varianStok,
                                            );
                                      }
                                    }
                                  } else {
                                    checkIsMainPhotoFilled();
                                  }
                                },
                                label: widget.item != null
                                    ? "Ubah Produk"
                                    : "Tambah Produk",
                              );
                            },
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
    );
  }

  void _showCategoryDialog({
    @required BuildContext context,
    @required List<modelCategory.Category> items,
    @required void Function(String value) onSelected,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)), //this right here
              child: Container(
                child: ListView.separated(
                  // padding: EdgeInsets.symmetric(vertical: 5),
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 0.5,
                    thickness: 0.5,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      visualDensity: VisualDensity.compact,
                      trailing: Icon(FlutterIcons.chevron_right_mco),
                      title: Text(items[index].name),
                      onTap: () {
                        context
                            .read<AddProductSupplierCubit>()
                            .addKategori(items[index].name, items[index].id);
                        onSelected(items[index].name);
                        // checkCategory(items[index].name);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSatuanDialog({
    @required BuildContext context,
    @required List<String> satuan,
    // @required void Function(int id) onSelected,
  }) {
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
                child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.0)), //this right here
                  child: Container(
                    child: ListView.separated(
                      // padding: EdgeInsets.symmetric(vertical: 5),
                      shrinkWrap: true,
                      itemCount: satuan.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 0.5,
                        thickness: 0.5,
                      ),
                      itemBuilder: (context, index) {
                        return ListTile(
                          visualDensity: VisualDensity.compact,
                          trailing: Icon(FlutterIcons.chevron_right_mco),
                          title: Text(satuan[index]),
                          onTap: () {
                            context
                                .read<AddProductSupplierCubit>()
                                .addSatuan(satuan[index]);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
