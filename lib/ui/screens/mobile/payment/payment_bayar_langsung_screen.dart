import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beamer/beamer.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/order/add_order_no_cart/add_order_no_cart_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/order/fetch_payment_method/fetch_payment_method_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/new_repositories/recipent_repository.dart';
import 'package:marketplace/ui/screens/mobile/payment/payment_bayar_langsung_detail_screen.dart';
import 'package:marketplace/ui/screens/mobile/payment/widget/payment_method_item.dart';
import 'package:marketplace/ui/widgets/data_table.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class PaymentBayarLangsungScreen extends StatefulWidget {
  const PaymentBayarLangsungScreen({
    Key key,
    this.productSelected,
    this.variants,
  }) : super(key: key);

  final Products productSelected;
  final ProductVariant variants;

  @override
  _PaymentBayarLangsungScreenState createState() =>
      _PaymentBayarLangsungScreenState();
}

class _PaymentBayarLangsungScreenState
    extends State<PaymentBayarLangsungScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final RecipentRepository _recRepo = RecipentRepository();

  AddOrderNoCartCubit _addOrderNoCartCubit;
  FetchPaymentMethodCubit _fetchPaymentMethodCubit;

  //Variable for get passing data
  int _recipentIdUser;
  PaymentMethod _selectedPayment;

  @override
  void initState() {
    _selectedPayment = null;
    _addOrderNoCartCubit = AddOrderNoCartCubit();
    _recipentIdUser = _recRepo.getSelectedRecipent()['id'];
    _fetchPaymentMethodCubit = FetchPaymentMethodCubit()..load();
    super.initState();
  }

  void handleBayar({@required int paymentMethodId}) {
    LoadingDialog.show(context);

    _addOrderNoCartCubit.order(
        productId: widget.productSelected.id,
        paymentId: paymentMethodId,
        variantId: widget.variants == null
            ? 0
            : widget.variants.id,
        totalPayment: widget.variants == null
            ? widget.productSelected.sellingPrice
            : widget.variants.variantSellPrice);
  }

  @override
  void dispose() {
    _addOrderNoCartCubit.close();
    _fetchPaymentMethodCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => _addOrderNoCartCubit,
          ),
          BlocProvider(
            create: (_) => _fetchPaymentMethodCubit,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener(
                bloc: _addOrderNoCartCubit,
                listener: (context, state) async {
                  if (state is AddOrderNoCartSuccess) {
                    await BlocProvider.of<UserDataCubit>(context).loadUser();
                    if (kIsWeb) {
                      AppExt.popScreen(context);
                      context.beamToNamed(
                          '/paymentfastdetail?dt=${AppExt.encryptMyData(jsonEncode(state.data))}');
                    } else {
                      AppExt.popScreen(context);
                      AppExt.popUntilRoot(context);
                      BlocProvider.of<BottomNavCubit>(context).navItemTapped(0);
                      AppExt.pushScreen(
                          context,
                          PaymentBayarLangsungDetailScreen(
                            orderData: state.data,
                          ));
                    }
                  }
                  if (state is AddOrderNoCartFailure) {
                    AppExt.popScreen(context);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.grey[900],
                          duration: Duration(seconds: 1),
                          content: Text(state.message),
                        ),
                      );
                    debugPrint(state.message);
                  }
                })
          ],
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value:
                SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: kIsWeb ? 425 : 600),
                child: Scaffold(
                  body: SafeArea(
                      child: NestedScrollView(
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              SliverAppBar(
                                //automaticallyImplyLeading: !kIsWeb,
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
                                textTheme:
                                    TextTheme(headline6: AppTypo.subtitle2),
                                backgroundColor: Colors.white,
                                centerTitle: true,
                                forceElevated: false,
                                pinned: true,
                                shadowColor: Colors.black54,
                                floating: true,
                                title: Text(
                                  "Pilih Metode Pembayaran",
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
                                  horizontal: _screenWidth * (5 / 120)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ringkasan Belanja",
                                        style: AppTypo.LatoBold,
                                      ),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 6),
                                        itemCount: 1,
                                        itemBuilder: (context, index1) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 12),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "1 x",
                                                    textAlign: TextAlign.left,
                                                    style: AppTypo.LatoBold
                                                        .copyWith(
                                                            fontSize: 14,
                                                            color: AppColor
                                                                .appPrimary),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "${widget.productSelected.name ?? ""}  ${widget.variants == null ? "" : (widget.variants.variantName)} ",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: AppTypo
                                                                .body2Lato
                                                                .copyWith(
                                                                    fontSize:
                                                                        14)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "Rp. ${AppExt.toRupiah(widget.variants == null ? widget.productSelected.sellingPrice : widget.variants.variantSellPrice)},-",
                                                    style: AppTypo.caption
                                                        .copyWith(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                thickness: 1.5,
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        "Ringkasan Pembayaran",
                                        style: AppTypo.LatoBold,
                                      ),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      dataTable.detail(
                                        "Subtotal Produk",
                                         "Rp. ${AppExt.toRupiah(widget.variants == null ? widget.productSelected.sellingPrice : widget.variants.variantSellPrice)},-",
                                      ),
                                      dataTable.detail(
                                        "Biaya Layanan",
                                        "Rp. 0,-",
                                      ),
                                      dataTable.detail(
                                        "Biaya Penanganan",
                                        "Rp. 0,-",
                                      ),
                                      Divider(),
                                      dataTable.totalSummary(
                                        "TOTAL",
                                         "Rp. ${AppExt.toRupiah(widget.variants == null ? widget.productSelected.sellingPrice : widget.variants.variantSellPrice)},-",
                                      ),
                                      SizedBox(
                                        height: 32,
                                      ),
                                      Text("Pilih Metode Pembayaran",
                                          style: AppTypo.LatoBold),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      BlocBuilder<FetchPaymentMethodCubit,
                                              FetchPaymentMethodState>(
                                          builder: (context, state) => state
                                                  is FetchPaymentMethodLoading
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : state
                                                      is FetchPaymentMethodFailure
                                                  ? Center(
                                                      child:
                                                          Text(state.message))
                                                  : state is FetchPaymentMethodSuccess
                                                      ? PaymentMethodItem(
                                                          paymentMethod: state
                                                              .paymentMethods,
                                                          onSelected: (data) {
                                                            setState(() {
                                                              _selectedPayment =
                                                                  data;

                                                              debugPrint(data.id
                                                                  .toString());
                                                            });
                                                          },
                                                        )
                                                      : SizedBox.shrink()),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      RoundedButton.contained(
                                        disabled: _selectedPayment == null,
                                        textColor: Colors.white,
                                        label: "Bayar",
                                        onPressed: () => handleBayar(
                                          paymentMethodId: _selectedPayment.id,
                                        ),
                                        isUpperCase: false,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ))),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
