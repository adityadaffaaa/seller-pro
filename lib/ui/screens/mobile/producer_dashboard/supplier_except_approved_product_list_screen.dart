import 'dart:async';

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/data/blocs/new_cubit/supplier/get_product_supplier/get_product_supplier_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/responsive_layout.dart';
import 'package:marketplace/utils/transitions.dart' as AppTrans;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:shimmer/shimmer.dart';

class SupplierExceptApprovedProductListScreen extends StatefulWidget {
  @override
  _SupplierExceptApprovedProductListScreenState createState() =>
      _SupplierExceptApprovedProductListScreenState();
}

class _SupplierExceptApprovedProductListScreenState
    extends State<SupplierExceptApprovedProductListScreen> {
  ScrollController _scrollController;
  TextEditingController _stockController;
  TextEditingController _searchController;
  String _searchHintText;
  Timer _debounce;
  FocusNode _focusNode;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    context.read<GetProductSupplierCubit>().fetchProduct();
    _scrollController = ScrollController();
    _stockController = TextEditingController(text: "");
    _searchController = TextEditingController(text: "");
    _refreshCompleter = Completer<void>();
    _focusNode = FocusNode();
    // _products = [];
    // _newProducts = [];
    super.initState();
  }

  String toRupiah(int number) {
    final currencyFormatter = NumberFormat('#,##0', 'ID');
    return currencyFormatter.format(number);
  }

  _onSearchChanged(String keyword) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      AppExt.hideKeyboard(context);
      if (keyword.isNotEmpty) {
        context.read<GetProductSupplierCubit>().fetchProduct(keyword: keyword);
      }
    });
  }

  Future<void> _refresh() {
    return context.read<GetProductSupplierCubit>().fetchProduct();
  }

  @override
  void dispose() {
    // _productsBloc.close();
    _scrollController.dispose();
    _stockController.dispose();
    _searchController.dispose();
    if (_debounce?.isActive ?? false) _debounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        AppExt.popScreen(context, true);
        return true;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        child: GestureDetector(
          onTap: () => AppExt.hideKeyboard(context),
          child: ResponsiveLayout(
            child: Scaffold(
              extendBody: true,
              backgroundColor: AppColor.white,
              body: BlocListener<GetProductSupplierCubit,
                  GetProductSupplierState>(
                listener: (context, state) {
                  if (state is GetProductSupplierDeleteSuccess) {
                    BSFeedback.show(context,
                        title: "Berhasil dihapus!", description: "");
                  }
                },
                child: SafeArea(
                  child: NestedScrollView(
                    floatHeaderSlivers: true,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) => [
                      SliverAppBar(
                        iconTheme: IconThemeData(color: AppColor.black),
                        textTheme: TextTheme(headline6: AppTypo.subtitle2),
                        backgroundColor: AppColor.white,
                        centerTitle: true,
                        pinned: true,
                        shadowColor: Colors.black54,
                        title: Text(
                          "Daftar Produk",
                          style: kIsWeb
                              ? AppTypo.subtitle1
                                  .copyWith(fontWeight: FontWeight.w600)
                              : TextStyle(),
                        ),
                        brightness: Brightness.dark,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(kToolbarHeight),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: !kIsWeb
                                    ? _screenWidth * (5 / 100)
                                    : _screenWidth * (2 / 100)),
                            child: Column(
                              children: [
                                Container(
                                  child: Center(
                                    child: EditText(
                                      controller: _searchController,
                                      hintText: "Cari produk ...",
                                      inputType: InputType.search,
                                      focusNode: _focusNode,
                                      onChanged: this._onSearchChanged,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    body: RefreshIndicator(
                      displacement: 10,
                      color: AppColor.primary,
                      backgroundColor: AppColor.white,
                      strokeWidth: 3,
                      onRefresh: () {
                        return _refresh();
                      },
                      child: BlocBuilder<GetProductSupplierCubit,
                          GetProductSupplierState>(
                        builder: (context, state) =>
                            AppTrans.SharedAxisTransitionSwitcher(
                          transitionType: SharedAxisTransitionType.vertical,
                          fillColor: Colors.transparent,
                          child: state is GetProductSupplierSuccess
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: state.products.length > 0
                                      ? CustomScrollView(
                                          slivers: [
                                            SliverToBoxAdapter(
                                              child: SizedBox(
                                                height: 10,
                                              ),
                                            ),
                                            SliverList(
                                              delegate:
                                                  SliverChildBuilderDelegate(
                                                (context, index) {
                                                  final _item =
                                                      state.products[index];
                                                  return GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () {},
                                                    child: _buildProductItem(
                                                        context, _item),
                                                  );
                                                },
                                                childCount:
                                                    state.products.length,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            SizedBox(height: 200),
                                            EmptyData(
                                              title: "Produk tidak ditemukan",
                                              subtitle:
                                                  "Silakan gunakan kata kunci lainnya",
                                            ),
                                          ],
                                        ),
                                )
                              : state is GetProductSupplierLoading
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          bottom: kToolbarHeight),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(AppColor.primary)),
                                      ),
                                    )
                                  : state is GetProductSupplierFailure
                                      ? Center(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                bottom: kToolbarHeight),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // Icon(
                                                Icon(
                                                  FlutterIcons
                                                      .error_outline_mdi,
                                                  size: 45,
                                                  color: AppColor.primaryDark,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: 250,
                                                  child: Text(
                                                    state.message,
                                                    style:
                                                        AppTypo.overlineAccent,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                OutlineButton(
                                                  child: Text("Coba lagi"),
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            GetProductSupplierCubit>()
                                                        .fetchProduct();
                                                  },
                                                  textColor:
                                                      AppColor.primaryDark,
                                                  color: AppColor.danger,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                        ),
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

  void _showDeleteConfirmationDialog(
      {@required String productName, @required void Function() onDelete}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)), //this right here
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppTypo.body2,
                        children: [
                          TextSpan(
                            text: 'Apakah kamu yakin menghapus produk ',
                          ),
                          TextSpan(
                            text: '$productName?',
                            style: AppTypo.body2
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RoundedButton.outlined(
                            isUpperCase: false,
                            isCompact: true,
                            label: "Ya",
                            onPressed: () {
                              Navigator.pop(context);
                              onDelete();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: RoundedButton.contained(
                            isUpperCase: false,
                            isCompact: true,
                            label: "Tidak",
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildProductItem(
      BuildContext context, SupplierDataResponseItem _item) {
    final double _screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          _screenWidth * (5 / 100), 10, _screenWidth * (5 / 100), 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: AppColor.bgBadgeGold.withOpacity(0.75)),
            child: Text(
              _item.productStatus,
              style: AppTypo.overline.copyWith(
                fontWeight: FontWeight.w700,
                color: _item.productStatus == "Diterima"
                    ? AppColor.bgTextGreen
                    : Color(0xFFCE6C24),
              ),
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: _ImageWidget(
                  product: _item,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _item.productName,
                      style: AppTypo.subtitle2
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Rp ${this.toRupiah(_item.productPrice)}',
                      style: AppTypo.caption.copyWith(
                          fontWeight: FontWeight.w700, color: AppColor.primary),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                        "Komisi Rp ${AppExt.toRupiah(_item.commissionPrice) ?? 0}",
                        style: AppTypo.overline.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColor.red,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Stok : ${_item.productStock}",
                      style: AppTypo.caption,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            children: [
              SizedBox(
                width: 90,
                child: OutlineButton(
                  borderSide: BorderSide(
                    color: AppColor.danger,
                  ),
                  highlightColor: AppColor.danger.withOpacity(0.3),
                  splashColor: AppColor.danger.withOpacity(0.3),
                  highlightedBorderColor: AppColor.danger,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () => _showDeleteConfirmationDialog(
                    productName: _item.productName,
                    onDelete: () {
                      context
                          .read<GetProductSupplierCubit>()
                          .deleteProduct(_item.id);
                    },
                  ),
                  child: Text(
                    "Hapus",
                    style: AppTypo.caption.copyWith(color: AppColor.danger),
                  ),
                ),
              ),
              // SizedBox(
              //   width: 10,
              // ),
              // Visibility(
              //   visible: _item.productStatus != "Ditolak",
              //   child: SizedBox(
              //     width: 120,
              //     child: OutlineButton(
              //       borderSide: BorderSide(
              //         color: _item.productStatus != "Ditolak"
              //             ? AppColor.textPrimary
              //             : AppColor.grey,
              //       ),
              //       textColor: AppColor.primary,
              //       disabledTextColor: AppColor.textSecondary,
              //       padding: EdgeInsets.all(0),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(50)),
              //       // onPressed: null,
              //       onPressed: () {
              //         if (_item.productStatus != "Ditolak") {
              //           context.read<AddProductSupplierCubit>().addItem(_item);
              //           AppExt.pushScreen(
              //               context,
              //               JoinUserAddProductScreen(
              //                 item: _item,
              //               ));
              //         }
              //       },
              //       child: Text(
              //         "Ubah Produk",
              //         style: AppTypo.caption.copyWith(
              //             color: _item.productStatus != "Ditolak"
              //                 ? AppColor.textPrimary
              //                 : AppColor.grey),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: 10,
              // ),
              // _item.productStatus == "Diterima"
              //     ? SizedBox(
              //         width: 110,
              //         child: OutlineButton(
              //           borderSide: BorderSide(
              //             color: AppColor.textPrimary,
              //           ),
              //           padding: EdgeInsets.all(0),
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(50)),
              //           // onPressed: null,
              //           onPressed: () {
              //             BsChangeStock().showChangeStockSheet(context,
              //                 onSubmit: (value) {}, stock: _item.productStock);
              //             /*_stockController.text = _item.stock.toString();
              //             _showChangeStockSheet(
              //               context,
              //               onSubmit: (id) {
              //                 Navigator.pop(context);
              //                 _productsBloc.add(
              //                   ChangeStockButtonPressed(
              //                     productId: id,
              //                     stock: int.parse(_stockController.text),
              //                   ),
              //                 );
              //               },
              //               product: _item,
              //             );*/
              //           },
              //           child: Text(
              //             "Ubah Stok",
              //             style: AppTypo.caption,
              //           ),
              //         ),
              //       )
              //     : SizedBox.shrink(),
            ],
          ),
          Divider(
            color: AppColor.line,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({Key key, this.product}) : super(key: key);

  final SupplierDataResponseItem product;

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Image.network(
            product.productAssets.isNotEmpty
                ? product.productAssets[0].image
                : "https://end.ekomad.id/images/blank.png",
            // "",
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              } else {
                return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: frame != null
                        ? child
                        : Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                          ));
              }
            },
            errorBuilder: (context, url, error) => Image.asset(
              AppImg.img_error,
              width: 60,
              height: 60,
            ),
          )
        : CachedNetworkImage(
            imageUrl: product.productAssets.last.image ??
                "https://venus.bisnisomall.com/images/blank.png",
            memCacheHeight:
                Get.height > 350 ? (Get.height * 0.25).toInt() : Get.height,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[200],
              period: Duration(milliseconds: 1000),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              AppImg.img_error,
              width: 60,
              height: 60,
            ),
          );
  }
}
