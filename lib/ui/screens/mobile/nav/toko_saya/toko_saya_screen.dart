import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:marketplace/data/blocs/fetch_user/fetch_user_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/check_network/check_network_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/toko_saya/fetch_product_toko_saya/fetch_product_toko_saya_bloc.dart';
import 'package:marketplace/data/blocs/new_cubit/toko_saya/remove_product_toko_saya/remove_product_toko_saya_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/models/new_models/toko_saya.dart';
import 'package:marketplace/ui/screens/mobile/join_user/join_user_profile_entry_screen.dart';
import 'package:marketplace/ui/screens/mobile/nav/toko_saya/toko_saya_customer_screen.dart';
import 'package:marketplace/ui/screens/mobile/nav/toko_saya/widget/myshop_not_available.dart';
import 'package:marketplace/ui/screens/mobile/nav/toko_saya/widget/myshop_product_empty.dart';
import 'package:marketplace/ui/screens/mobile/nav/toko_saya/widget/myshop_select_option.dart';
import 'package:marketplace/ui/screens/mobile/no_connection/no_connection_screen.dart';
import 'package:marketplace/ui/widgets/app_bar_config.dart';
import 'package:marketplace/ui/widgets/bs_confirmation.dart';
import 'package:marketplace/ui/widgets/bs_filter_product.dart';
import 'package:marketplace/ui/widgets/bs_kategori.dart';
import 'package:marketplace/ui/widgets/grid_two_product_list_item.dart';
import 'package:marketplace/ui/widgets/loading_dialog.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/constants.dart' as AppConst;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/transitions.dart' as AppTrans;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:share_plus/share_plus.dart';

class TokoSayaScreen extends StatefulWidget {
  const TokoSayaScreen({Key key}) : super(key: key);

  @override
  _TokoSayaScreenState createState() => _TokoSayaScreenState();
}

class _TokoSayaScreenState extends State<TokoSayaScreen> {
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();

  bool isCustomer = false;
  bool hasShop = false;
  bool initialLoading = true;

  FetchUserCubit _fetchUserCubit;
  RemoveProductTokoSayaCubit _removeProductTokoSayaCubit;

  FetchProductTokoSayaBloc _fetchProductTokoSayaBloc;

  List<TokoSayaProducts> tokoSayaProduct = [];
  int currentPage = 0;
  int lastPage = 100;
  bool _isLoadMore = true;

  @override
  void initState() {
    context.read<CheckNetworkCubit>().checker();
    _fetchProductTokoSayaBloc = FetchProductTokoSayaBloc()
      ..add(FetchedNextProductTokoSaya(
          tokoSayaProduct: tokoSayaProduct,
          currentPage: currentPage,
          lastPage: lastPage));
    _fetchUserCubit = FetchUserCubit()..load();
    _removeProductTokoSayaCubit = RemoveProductTokoSayaCubit();
    // updateState();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  // updateState(Reseller reseller,Supplier supplier){
  //   isCustomer = reseller == null && supplier == null;
  //   hasShop =  reseller != null;
  // }

  void shareShop(String nameShop, String slug) {
    Share.share(
        "Yuk belanja di *${nameShop ?? 'user'}* Banyak produk baru dan promo lho! Klik disini \n https://store.ekomad.id/wpp/dashboard/$slug");
  }

  Future refreshData(bool useNetworkChecker) async {
    if (useNetworkChecker) {
      context.read<CheckNetworkCubit>().checker();
    }
    _fetchUserCubit.load();
    _fetchProductTokoSayaBloc.add(FetchedProductTokoSaya());
  }

  void _onScroll() async {
    if (_isBottom() && _isLoadMore == true) {
      try {
        await _fetchProductTokoSayaBloc.add(FetchedNextProductTokoSaya(
            tokoSayaProduct: tokoSayaProduct,
            currentPage: currentPage,
            lastPage: lastPage));
      } catch (e) {
        debugPrint("ERRORNYA: ${e}");
      }
    }
  }

  bool _isBottom() {
    return _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent;
    // if (!_scrollController.hasClients) return false;
    // final maxScroll = _scrollController.position.maxScrollExtent;
    // final currentScroll = _scrollController.offset;
    // return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _fetchUserCubit.close();
    _fetchProductTokoSayaBloc.close();
    _removeProductTokoSayaCubit.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => _fetchProductTokoSayaBloc),
          BlocProvider(create: (_) => _removeProductTokoSayaCubit),
          BlocProvider(create: (_) => _fetchUserCubit),
        ],
        child: MultiBlocListener(
            listeners: [
              BlocListener<CheckNetworkCubit, CheckNetworkState>(
                  listener: (context, state) async {
                if (state is CheckNetworkFailure) {
                  bool refresh =
                      await AppExt.pushScreen(context, NoConnectionScreen());
                  if (refresh) {
                    refreshData(false);
                  }
                }
              }),
              BlocListener(
                  bloc: _removeProductTokoSayaCubit,
                  listener: (context, state) {
                    if (state is RemoveProductTokoSayaLoading) {
                      LoadingDialog.show(context);
                    }
                    if (state is RemoveProductTokoSayaFailure) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            margin: EdgeInsets.zero,
                            duration: Duration(seconds: 2),
                            content: Text('${state.message}'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                    }
                    if (state is RemoveProductTokoSayaSuccess) {
                      AppExt.popScreen(context);
                      _fetchProductTokoSayaBloc.add(FetchedProductTokoSaya());
                    }
                  }),
              BlocListener(
                  bloc: _fetchUserCubit,
                  listener: (context, state) {
                    if (state is FetchUserSuccess) {
                      setState(() {
                        isCustomer = state.user.data.reseller == null &&
                            state.user.data.supplier == null;
                        hasShop = state.user.data.reseller != null;
                        initialLoading = false;
                      });
                    }
                  }),
              BlocListener<FetchProductTokoSayaBloc, FetchProductTokoSayaState>(
                  listener: (context, state) {
                if (state is FetchProductTokoSayaSuccess) {
                  setState(() {
                    tokoSayaProduct = state.tokoSayaProduct;
                    currentPage = state.currentPage;
                    lastPage = state.lastPage;
                    if (currentPage == lastPage) {
                      _isLoadMore = false;
                    }
                    debugPrint(
                        "UPDATED currentPage = ${currentPage} & lastPage = ${lastPage}");
                  });
                }
              })
            ],
            child: BlocBuilder<FetchProductTokoSayaBloc,
                FetchProductTokoSayaState>(
              builder: (context, fetchProductTokoSayaState) => BlocBuilder(
                  bloc: _fetchUserCubit,
                  builder: (context, fetchUserState) =>
                      //======================= ERROR HANDLING ================
                      // fetchUserState is FetchUserFailure ||
                      //         fetchProductTokoSayaState
                      //             is FetchProductTokoSayaFailure
                      //     ? Center(
                      //         child: fetchUserState.type == ErrorType.network ||
                      //                 fetchUserState.type == ErrorType.network
                      //             ? NoConnection(onButtonPressed: refreshData)
                      //             : ErrorFetchForUser(
                      //                 onButtonPressed: refreshData))
                      //     :
                      //=======================================================
                      initialLoading == true
                          ? Center(child: CircularProgressIndicator())
                          : hasShop == false
                              ? MyShopNotAvailable()
                              : AnnotatedRegion<SystemUiOverlayStyle>(
                                  value: SystemUiOverlayStyle.dark,
                                  child: Center(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: kIsWeb ? 500 : 450),
                                      child: Scaffold(
                                          appBar: AppBarConfig(
                                            bgColor: Colors.white,
                                            iconColor: AppColor.textPrimary,
                                            logoColor: AppColor.primary,
                                          ),
                                          body: ListView(
                                              shrinkWrap: true,
                                              padding:
                                                  EdgeInsets.only(bottom: 16),
                                              controller: _scrollController,
                                              children: [
                                                Column(children: [
                                                  //Header
                                                  fetchUserState
                                                          is FetchUserLoading
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : fetchUserState
                                                              is FetchUserSuccess
                                                          ? Container(
                                                              color:
                                                                  Colors.white,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      horizontal: kIsWeb
                                                                          ? 24
                                                                          : _screenWidth *
                                                                              (5 / 100),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        CircleAvatar(
                                                                          backgroundColor:
                                                                              AppColor.navScaffoldBg,
                                                                          radius: kIsWeb
                                                                              ? 35
                                                                              : _screenWidth * (6 / 100),
                                                                          backgroundImage: fetchUserState.user.data.reseller.logo != null
                                                                              ? NetworkImage(fetchUserState.user.data.reseller.logo.toString())
                                                                              : NetworkImage("${AppConst.BASE_URL}/images/blank.png"),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 20),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  fetchUserState.user.data.reseller.name,
                                                                                  style: AppTypo.body2Lato.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                  maxLines: 2,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 3,
                                                                                ),
                                                                                Text(
                                                                                  "Kota ${fetchUserState.user.data.reseller.city}",
                                                                                  style: AppTypo.body2Lato.copyWith(
                                                                                    fontSize: 12,
                                                                                    color: AppColor.textSecondary2,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 3,
                                                                                ),
                                                                                Text("Bergabung: ${fetchUserState.user.data.reseller.joinDate}", style: AppTypo.body2Lato.copyWith(fontSize: 12, color: AppColor.textSecondary2))
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            kIsWeb
                                                                                ? AppExt.toWebUrl(context, "https://api.whatsapp.com/send?text=Yuk belanja di *${fetchUserState.user.data.reseller.name ?? 'user'}* Banyak produk baru dan promo lho! Klik disini \n https://store.ekomad.id/wpp/dashboard/${fetchUserState.user.data.reseller.slug}")
                                                                                : shareShop(fetchUserState.user.data.reseller.name ?? 'user', fetchUserState.user.data.reseller.slug);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.share_outlined,
                                                                                  color: AppColor.textPrimaryInverted,
                                                                                  size: 15,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 4,
                                                                                ),
                                                                                Text(
                                                                                  "Bagikan Toko",
                                                                                  style: AppTypo.body2Lato.copyWith(color: AppColor.textPrimaryInverted),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(color: AppColor.primary, borderRadius: BorderRadius.circular(5)),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: kIsWeb
                                                                            ? 24
                                                                            : _screenWidth *
                                                                                (5 / 100)),
                                                                    child: InkWell(
                                                                        onTap: () async {
                                                                          bool isRefresh = await AppExt.pushScreen(
                                                                              context,
                                                                              JoinUserProfileEntryScreen(userData: fetchUserState.user.data, userType: UserType.reseller));
                                                                          if (isRefresh ==
                                                                              true) {
                                                                            refreshData(true);
                                                                          }
                                                                        },
                                                                        child: Text("Edit Toko", style: AppTypo.LatoBold.copyWith(fontSize: 14, color: AppColor.primary))),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 24,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: kIsWeb
                                                                            ? 24
                                                                            : _screenWidth *
                                                                                (5 / 100)),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Column(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Icon(EvaIcons.star, color: AppColor.bottomNavIconActive, size: 18),
                                                                                SizedBox(width: 5),
                                                                                Text(
                                                                                  fetchUserState.user.data.reseller.rating.toString(),
                                                                                  style: AppTypo.body1Lato,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 6,
                                                                            ),
                                                                            Text(
                                                                              "Rating & ulasan",
                                                                              style: AppTypo.body2Lato.copyWith(color: AppColor.textSecondary2, fontSize: 12),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            Text(fetchUserState.user.data.reseller.sold.toString(),
                                                                                style: AppTypo.body1Lato),
                                                                            SizedBox(
                                                                              height: 6,
                                                                            ),
                                                                            Text("Produk Terjual",
                                                                                style: AppTypo.body2Lato.copyWith(color: AppColor.textSecondary2, fontSize: 12))
                                                                          ],
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            AppExt.pushScreen(context,
                                                                                MyShopCustomerScreen());
                                                                          },
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text(fetchUserState.user.data.reseller.customer.toString(), style: AppTypo.body1Lato),
                                                                              SizedBox(
                                                                                height: 6,
                                                                              ),
                                                                              Text("Total Pelanggan", style: AppTypo.body2Lato.copyWith(color: AppColor.textSecondary2, fontSize: 12))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 12,
                                                                  ),
                                                                  IntrinsicHeight(
                                                                      child:
                                                                          Divider(
                                                                    height: 1,
                                                                    color: AppColor
                                                                        .silverFlashSale,
                                                                  )),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: kIsWeb
                                                                            ? 24
                                                                            : _screenWidth *
                                                                                (5 /
                                                                                    100),
                                                                        vertical:
                                                                            14),
                                                                    child: Row(
                                                                      children: [
                                                                        MyShopSelectOption(
                                                                          title:
                                                                              "Filter",
                                                                          onTap:
                                                                              () {
                                                                            BSFilterProduct.show(context);
                                                                          },
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              13,
                                                                        ),
                                                                        MyShopSelectOption(
                                                                          title:
                                                                              "Kategori",
                                                                          onTap:
                                                                              () {
                                                                            BsKategori().showBsStatus(context);
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          : SizedBox.shrink(),
                                                  isCustomer
                                                      ? MyShopNotAvailable()
                                                      : hasShop == true
                                                          ? Container(
                                                              child:
                                                                  //Body
                                                                  fetchProductTokoSayaState
                                                                          is FetchProductTokoSayaLoading
                                                                      ? Center(
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        )
                                                                      : fetchProductTokoSayaState
                                                                              is FetchProductTokoSayaFailure
                                                                          ? Center(
                                                                              child: Text(fetchProductTokoSayaState.message),
                                                                            )
                                                                          : fetchProductTokoSayaState is FetchProductTokoSayaSuccess
                                                                              ? fetchProductTokoSayaState.tokoSayaProduct.length > 0
                                                                                  ? RefreshIndicator(
                                                                                      onRefresh: () => refreshData(true),
                                                                                      child: Column(
                                                                                        children: [
                                                                                          AlignedGridView.count(
                                                                                            controller: _scrollController2,
                                                                                            shrinkWrap: true,
                                                                                            padding: EdgeInsets.only(
                                                                                              top: kIsWeb ? 0 : 20,
                                                                                              left: kIsWeb ? 24 : _screenWidth * (5 / 100),
                                                                                              right: kIsWeb ? 24 : _screenWidth * (5 / 100),
                                                                                            ),
                                                                                            crossAxisCount: 2,
                                                                                            crossAxisSpacing: 10,
                                                                                            mainAxisSpacing: 10,
                                                                                            itemCount: fetchProductTokoSayaState.tokoSayaProduct.length,
                                                                                            itemBuilder: (BuildContext context, int index) {
                                                                                              TokoSayaProducts _item = fetchProductTokoSayaState.tokoSayaProduct[index];
                                                                                              return
                                                                                                  // Text("PRODUCT LENGTH: ${fetchProductTokoSayaState
                                                                                                  //   .tokoSayaProduct
                                                                                                  //   .length}");
                                                                                                  GridTwoProductListItem(
                                                                                                // productShop: _item,
                                                                                                product: null,
                                                                                                isDiscount: _item.disc != null && _item.disc > 0,
                                                                                                isKomisi: true,
                                                                                                isUpgrader: true,
                                                                                                isShop: true,
                                                                                                onDelete: (id) {
                                                                                                  BsConfirmation().show(
                                                                                                      context: context,
                                                                                                      onYes: () {
                                                                                                        AppExt.popScreen(context);
                                                                                                        _removeProductTokoSayaCubit.deleteProduct(productId: id);
                                                                                                      },
                                                                                                      title: "Apakah anda yakin ingin menghapus produk dari katalog?");
                                                                                                },
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                          _isLoadMore
                                                                                              ? Center(
                                                                                                  child: CircularProgressIndicator(),
                                                                                                )
                                                                                              : SizedBox.shrink(),
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                  : MyShopProductEmpty()
                                                                              : SizedBox.shrink(),
                                                            )
                                                          : SizedBox.shrink(),
                                                ]),
                                              ])),
                                    ),
                                  ))),
            )));
  }
}
