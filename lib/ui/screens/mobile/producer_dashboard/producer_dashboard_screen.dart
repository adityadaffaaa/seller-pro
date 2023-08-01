import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/fetch_user/fetch_user_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/transaksi_filter_supplier_status/transaksi_filter_supplier_status_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/repositories.dart';
import 'package:marketplace/ui/screens/mobile/main_screen.dart';
import 'package:marketplace/ui/screens/mobile/nav/toko_saya/toko_saya_customer_screen.dart';
import 'package:marketplace/ui/screens/mobile/producer_dashboard/supplier_approved_product_list_screen.dart';
import 'package:marketplace/ui/screens/mobile/transaksi_supplier/transaksi_supplier_screen.dart';
import 'package:marketplace/ui/screens/mobile/join_user/join_user_add_product_screen.dart';
import 'package:marketplace/ui/screens/mobile/join_user/join_user_profile_entry_screen.dart';
import 'package:marketplace/ui/screens/mobile/product_by_category/product_by_category_screen.dart';
import 'package:marketplace/ui/widgets/alert_dialog.dart';
import 'package:marketplace/ui/widgets/bs_confirmation.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:beamer/beamer.dart';

import '../../../widgets/custom_app_bar.dart';

class ProducerDashboardScreen extends StatefulWidget {
  const ProducerDashboardScreen(
      {Key key, this.isReseller = false, this.isSupplier = false})
      : super(key: key);

  final bool isReseller;
  final bool isSupplier;

  @override
  _ProducerDashboardScreenState createState() =>
      _ProducerDashboardScreenState();
}

class _ProducerDashboardScreenState extends State<ProducerDashboardScreen> {
  final AuthenticationRepository _authRepo = AuthenticationRepository();
  FetchUserCubit _fetchUserCubit;

  @override
  void initState() {
    _fetchUserCubit = FetchUserCubit()..load();
    super.initState();
  }

  @override
  void dispose() {
    _fetchUserCubit.close();
    super.dispose();
  }

  void _checkUser() async {
    if (await _authRepo.hasToken()) {
      await BlocProvider.of<UserDataCubit>(context).loadUser();
      // namaPenerima = _recipentRepo.getRecipentNameReceiver();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final bool isReseller = userDataCubit.reseller != null && userDataCubit.supplier == null ;
    // final bool isSupplier = userDataCubit.supplier != null && userDataCubit.reseller != null;
    final _screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () {
        AppExt.popScreen(context);
        _checkUser();
        return;
      },
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => _fetchUserCubit)],
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
              child: Scaffold(
                backgroundColor: Colors.white,
                extendBody: true,
                body: BlocBuilder(
                    bloc: _fetchUserCubit,
                    builder: (context, stateUserData) => stateUserData
                            is FetchUserLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : stateUserData is FetchUserLoading
                            ? Center(child: Text("terjadi kesalahan"))
                            : stateUserData is FetchUserSuccess
                                ? SafeArea(
                                    child: NestedScrollView(
                                      headerSliverBuilder:
                                          (BuildContext context,
                                              bool innerBoxIsScrolled) {
                                        return <Widget>[
                                          SliverAppBar(
                                            automaticallyImplyLeading: !kIsWeb,
                                            leading: IconButton(
                                                splashRadius: 20,
                                                icon: Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.black,
                                                ),
                                                onPressed: kIsWeb
                                                    ? () {
                                                        context
                                                            .beamToNamed('/');
                                                        BlocProvider.of<
                                                                    BottomNavCubit>(
                                                                context)
                                                            .navItemTapped(3);
                                                      }
                                                    : () {
                                                        AppExt.popScreen(
                                                            context);
                                                      }),
                                            textTheme: TextTheme(
                                                headline6: AppTypo.subtitle2),
                                            backgroundColor: Colors.white,
                                            iconTheme: IconThemeData(
                                              color: Colors.black,
                                            ),
                                            centerTitle: true,
                                            forceElevated: false,
                                            pinned: true,
                                            shadowColor: Colors.black54,
                                            floating: true,
                                            title: Text(
                                                "Profil ${widget.isReseller ? 'Reseller' : 'Supplier'}",
                                                style: AppTypo.subtitle2),
                                            brightness: Brightness.dark,
                                          ),
                                        ];
                                      },
                                      body: SingleChildScrollView(
                                        physics: new BouncingScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                20,
                                                16,
                                                20,
                                                0,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 35,
                                                    backgroundImage: NetworkImage(widget
                                                            .isReseller
                                                        ? stateUserData
                                                                .user
                                                                .data
                                                                .reseller
                                                                .logo ??
                                                            "https://venus.bisnisomall.com/images/blank.png"
                                                        : stateUserData
                                                                .user
                                                                .data
                                                                .supplier
                                                                .logo ??
                                                            "https://venus.bisnisomall.com/images/blank.png"),
                                                  ),
                                                  SizedBox(
                                                    width: 17,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          widget.isReseller
                                                              ? stateUserData
                                                                      .user
                                                                      .data
                                                                      .reseller
                                                                      .name ??
                                                                  '-'
                                                              : stateUserData
                                                                      .user
                                                                      .data
                                                                      .supplier
                                                                      .name ??
                                                                  '-',
                                                          style: AppTypo
                                                              .subtitle2v2
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          widget.isReseller
                                                              ? stateUserData
                                                                      .user
                                                                      .data
                                                                      .reseller
                                                                      .address ??
                                                                  '-'
                                                              : stateUserData
                                                                      .user
                                                                      .data
                                                                      .supplier
                                                                      .address ??
                                                                  '-',
                                                          style:
                                                              AppTypo.caption,
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          widget.isReseller
                                                              ? stateUserData
                                                                      .user
                                                                      .data
                                                                      .reseller
                                                                      .subdistrict ??
                                                                  '-' +
                                                                      ', ' +
                                                                      stateUserData
                                                                          .user
                                                                          .data
                                                                          .reseller
                                                                          .city ??
                                                                  '-' +
                                                                      ', ' +
                                                                      stateUserData
                                                                          .user
                                                                          .data
                                                                          .reseller
                                                                          .province ??
                                                                  '-'
                                                              : stateUserData
                                                                      .user
                                                                      .data
                                                                      .supplier
                                                                      .subdistrict ??
                                                                  '-' +
                                                                      ', ' +
                                                                      stateUserData
                                                                          .user
                                                                          .data
                                                                          .supplier
                                                                          .city ??
                                                                  '-' +
                                                                      ', ' +
                                                                      stateUserData
                                                                          .user
                                                                          .data
                                                                          .supplier
                                                                          .province ??
                                                                  '-',
                                                          style:
                                                              AppTypo.caption,
                                                        ),
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        Text(
                                                          widget.isReseller
                                                              ? "Bergabung: " +
                                                                      stateUserData
                                                                          .user
                                                                          .data
                                                                          .reseller
                                                                          .joinDate ??
                                                                  '-'
                                                              : "Bergabung: " +
                                                                      stateUserData
                                                                          .user
                                                                          .data
                                                                          .supplier
                                                                          .joinDate ??
                                                                  '-',
                                                          style: AppTypo.caption
                                                              .copyWith(
                                                                  color: AppColor
                                                                      .inactiveTrackSwitch),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (!widget.isReseller) {
                                                  if (kIsWeb) {
                                                    context
                                                        .read<
                                                            TransaksiFilterSupplierStatusCubit>()
                                                        .resetStatus();
                                                    AppExt.pushScreen(context,
                                                        TransaksiSupplierScreen());
                                                  } else {
                                                    context
                                                        .read<
                                                            TransaksiFilterSupplierStatusCubit>()
                                                        .resetStatus();
                                                    AppExt.pushScreen(context,
                                                        TransaksiSupplierScreen());
                                                  }
                                                }
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 15,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Penjualan',
                                                      style: AppTypo.subtitle2
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    Spacer(),
                                                    !widget.isReseller
                                                        ? Text(
                                                            "Lihat Riwayat",
                                                            style: AppTypo.overline.copyWith(
                                                                color: AppColor
                                                                    .primary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                          )
                                                        : SizedBox()
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: kIsWeb
                                                      ? _screenWidth *
                                                          (1.5 / 100)
                                                      : _screenWidth *
                                                          (5 / 100)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      onTap: () {
                                                        if (widget.isReseller) {
                                                          AppExt.pushScreen(
                                                              context,
                                                              ProductByCategoryScreen(
                                                                  categoryId:
                                                                      1));
                                                        } else {
                                                          context
                                                              .read<
                                                                  TransaksiFilterSupplierStatusCubit>()
                                                              .chooseStatus(
                                                                  "Menunggu Konfirmasi",
                                                                  1);

                                                          AppExt.pushScreen(
                                                              context,
                                                              TransaksiSupplierScreen(
                                                                statusOrder: 2,
                                                              ));
                                                        }
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColor
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.25),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          13),
                                                            ),
                                                            child: !widget
                                                                    .isReseller
                                                                ? Icon(
                                                                    Boxicons
                                                                        .bxs_food_menu,
                                                                    color: AppColor
                                                                        .primary,
                                                                    size: 25,
                                                                  )
                                                                : Icon(
                                                                    Boxicons
                                                                        .bxs_box,
                                                                    color: AppColor
                                                                        .primary,
                                                                    size: 25,
                                                                  ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Flexible(
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                !widget.isReseller
                                                                    ? "Pesanan\nBaru"
                                                                    : "Tambah\nProduk",
                                                                style: AppTypo.h3.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      onTap: () {
                                                        if (widget.isReseller) {
                                                          AppExt.pushScreen(
                                                              context,
                                                              MyShopCustomerScreen());
                                                        } else {
                                                          context
                                                              .read<
                                                                  TransaksiFilterSupplierStatusCubit>()
                                                              .chooseStatus(
                                                                  "Sedang diproses",
                                                                  2);

                                                          AppExt.pushScreen(
                                                              context,
                                                              TransaksiSupplierScreen(
                                                                statusOrder: 3,
                                                              ));
                                                        }
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColor
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.25),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          13),
                                                            ),
                                                            child: Icon(
                                                              !widget.isReseller
                                                                  ? FlutterIcons
                                                                      .chevron_double_right_mco
                                                                  : Boxicons
                                                                      .bxs_food_menu,
                                                              color: AppColor
                                                                  .primary,
                                                              size: 25,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Flexible(
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                !widget.isReseller
                                                                    ? "Siap\nDikirim"
                                                                    : "Daftar\nPelanggan",
                                                                style: AppTypo.h3.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: kIsWeb
                                                      ? _screenWidth *
                                                          (1.5 / 100)
                                                      : _screenWidth *
                                                          (5 / 100),
                                                  vertical: 10),
                                              child: Divider(
                                                thickness: 1,
                                                color: AppColor.silverFlashSale,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (!widget.isReseller) {
                                                  // if (kIsWeb) {
                                                  //   BsConfirmation().warning(
                                                  //       context: context,
                                                  //       title:
                                                  //           "Nantikan update terbaru dari kami.");
                                                  // } else {
                                                  AppExt.pushScreen(context,
                                                      JoinUserAddProductScreen());
                                                  //}
                                                }
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Produk',
                                                      style: AppTypo.subtitle2
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    Spacer(),
                                                    !widget.isReseller
                                                        ? Text(
                                                            "Tambah Produk",
                                                            style: AppTypo.overline.copyWith(
                                                                color: AppColor
                                                                    .primary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                          )
                                                        : SizedBox()
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              trailing: Icon(
                                                  Icons.chevron_right_outlined),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              onTap: () async {
                                                if (widget.isReseller) {
                                                  if (kIsWeb) {
                                                    context.beamToNamed('/');
                                                    BlocProvider.of<
                                                                BottomNavCubit>(
                                                            context)
                                                        .navItemTapped(1);
                                                  } else {
                                                    AppExt.popUntilRoot(
                                                        context);
                                                    BlocProvider.of<
                                                                BottomNavCubit>(
                                                            context)
                                                        .navItemTapped(1);
                                                  }
                                                } else {
                                                  // if (kIsWeb) {
                                                  //   WarningAlertDialog(
                                                  //     context,
                                                  //     "Coming Soon",
                                                  //     "Nantikan update terbaru dari kami.",
                                                  //     "Oke",
                                                  //     () {
                                                  //       AppExt.popScreen(
                                                  //           context);
                                                  //     },
                                                  //   );
                                                  // } else {
                                                  bool isRefresh =
                                                      await AppExt.pushScreen(
                                                          context,
                                                          SupplierApprovedProductListScreen());
                                                  if (isRefresh ?? true) {
                                                    _fetchUserCubit.load();
                                                  }
                                                  //}
                                                }
                                              },
                                              dense: true,
                                              title: Text(
                                                widget.isReseller
                                                    ? "Kelola katalog produk"
                                                    : "Daftar produk anda",
                                                style: AppTypo.overline,
                                              ),
                                              subtitle: Text(
                                                widget.isReseller
                                                    ? "${stateUserData.user.data.reseller.totalProduct.toString()} Produk"
                                                    : "${stateUserData.user.data.supplier.productCount.toString()} Produk",
                                                style: AppTypo.overlineAccent,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: kIsWeb
                                                      ? _screenWidth *
                                                          (1.5 / 100)
                                                      : _screenWidth *
                                                          (5 / 100),
                                                  vertical: 5),
                                              child: Divider(
                                                thickness: 1,
                                                color: AppColor.silverFlashSale,
                                              ),
                                            ),
                                            // InkWell(
                                            //   onTap: () => BsConfirmation().warning(
                                            //       context: context,
                                            //       title:
                                            //           "Nantikan update terbaru dari kami."),
                                            //   child: Padding(
                                            //     padding: EdgeInsets.symmetric(
                                            //       horizontal: 20,
                                            //     ),
                                            //     child: Row(
                                            //       children: [
                                            //         Text(
                                            //           !widget.isReseller
                                            //               ? 'Potensi Komoditas'
                                            //               : 'Toko',
                                            //           style: AppTypo.subtitle2
                                            //               .copyWith(
                                            //                   fontWeight:
                                            //                       FontWeight
                                            //                           .w700),
                                            //         ),
                                            //         Spacer(),
                                            //         !widget.isReseller
                                            //             ? Text(
                                            //                 "Tambah Anggota",
                                            //                 style: AppTypo.overline.copyWith(
                                            //                     color: AppColor
                                            //                         .primary,
                                            //                     fontWeight:
                                            //                         FontWeight
                                            //                             .w700,
                                            //                     decoration:
                                            //                         TextDecoration
                                            //                             .underline),
                                            //               )
                                            //             : SizedBox()
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                            // ListTile(
                                            //     trailing: Icon(Icons
                                            //         .chevron_right_outlined),
                                            //     contentPadding:
                                            //         EdgeInsets.symmetric(
                                            //             horizontal: 20),
                                            //     onTap: () {
                                            //       widget.isReseller
                                            //           ? () async {
                                            //               if (kIsWeb) {
                                            //                 context.beamToNamed(
                                            //                     '/resellerprofile?dt=${AppExt.encryptMyData(jsonEncode(stateUserData.user.data))}');
                                            //               } else {
                                            //                 bool isRefresh =
                                            //                     await AppExt
                                            //                         .pushScreen(
                                            //                             context,
                                            //                             JoinUserProfileEntryScreen(
                                            //                               userData: stateUserData
                                            //                                   .user
                                            //                                   .data,
                                            //                               userType:
                                            //                                   UserType.reseller,
                                            //                             ));
                                            //                 if (isRefresh ==
                                            //                     true) {
                                            //                   _fetchUserCubit
                                            //                       .load();
                                            //                 }
                                            //               }
                                            //             }()
                                            //           : BsConfirmation().warning(
                                            //               context: context,
                                            //               title:
                                            //                   "Nantikan update terbaru dari kami.");
                                            //     },
                                            //     dense: true,
                                            //     title: Text(
                                            //       widget.isReseller
                                            //           ? "Kelola profil toko"
                                            //           : "Anggota Terhubung",
                                            //       style: AppTypo.overline,
                                            //     ),
                                            //     subtitle: !widget.isReseller
                                            //         ? Text(
                                            //             "${stateUserData.user.data.supplier.memberCount.toString()} Anggota",
                                            //             style: AppTypo
                                            //                 .overlineAccent,
                                            //           )
                                            //         : null),
                                            // widget.isSupplier
                                            //     ? Padding(
                                            //         padding:
                                            //             EdgeInsets.symmetric(
                                            //                 horizontal:
                                            //                     _screenWidth *
                                            //                         (5 / 100),
                                            //                 vertical: 10),
                                            //         child: Divider(
                                            //           thickness: 1,
                                            //           color: AppColor
                                            //               .silverFlashSale,
                                            //         ),
                                            //       )
                                            //     : SizedBox.shrink(),
                                            widget.isSupplier
                                                ? Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Supplier',
                                                          style: AppTypo
                                                              .subtitle2
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                            widget.isSupplier
                                                ? ListTile(
                                                    trailing: Icon(Icons
                                                        .chevron_right_outlined),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    onTap: () async {
                                                      if (kIsWeb) {
                                                        context.beamToNamed(
                                                            '/supplierprofile?dt=${AppExt.encryptMyData(jsonEncode(stateUserData.user.data))}');
                                                      } else {
                                                        bool isRefresh =
                                                            await AppExt.pushScreen(
                                                                context,
                                                                JoinUserProfileEntryScreen(
                                                                  userData:
                                                                      stateUserData
                                                                          .user
                                                                          .data,
                                                                  userType: UserType
                                                                      .supplier,
                                                                ));
                                                        if (isRefresh == true) {
                                                          _fetchUserCubit
                                                              .load();
                                                        }
                                                      }
                                                    },
                                                    dense: true,
                                                    title: Text(
                                                      "Kelola profil supplier",
                                                      style: AppTypo.overline,
                                                    ),
                                                  )
                                                : SizedBox.shrink()
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
