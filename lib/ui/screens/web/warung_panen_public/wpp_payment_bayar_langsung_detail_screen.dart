import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:beamer/beamer.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/order/cancel_order/cancel_order_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/order/change_payment_method/change_payment_method_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/order/fetch_payment_method/fetch_payment_method_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/models/new_models/ticker.dart';
import 'package:marketplace/data/repositories/repositories.dart';
import 'package:marketplace/ui/screens/mobile/invoice/new_invoice/invoice_payment_screen.dart';
import 'package:marketplace/ui/widgets/a_app_config.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/transitions.dart' as AppTrans;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/constants.dart' as AppConst;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:shimmer/shimmer.dart';

class WppPaymentBayarLangsungDetailScreen extends StatefulWidget {
  final GeneralOrderResponseData orderData;

  WppPaymentBayarLangsungDetailScreen({
    Key key,
    @required this.orderData,
  }) : super(key: key);

  @override
  _WppPaymentBayarLangsungDetailScreenState createState() =>
      _WppPaymentBayarLangsungDetailScreenState();
}

class _WppPaymentBayarLangsungDetailScreenState
    extends State<WppPaymentBayarLangsungDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FetchPaymentMethodCubit _fetchPaymentMethodCubit;
  ChangePaymentMethodCubit _changePaymentMethodCubit;

  // CancelOrderCubit _cancelOrderCubit;

  int _selectedPaymentIndex;

  @override
  void initState() {
    _selectedPaymentIndex = null;
    // _cancelOrderCubit = CancelOrderCubit();
    _fetchPaymentMethodCubit = FetchPaymentMethodCubit()..load();
    _changePaymentMethodCubit = ChangePaymentMethodCubit();
    super.initState();
  }

  int _duration(DateTime orderDate) {
    final expired = orderDate.add(const Duration(hours: 8));
    final now = DateTime.now();
    final diff = expired.difference(now);
    return diff.inSeconds;
  }

  // void _handleConfirmPayment({@required int paymentId}) async {
  //   LoadingDialog.show(context);
  //   await Future.delayed(Duration(seconds: 1));
  //   await _changePaymentStatusCubit.confirmPayment(paymentId: paymentId);
  // }

  // void _handleCancelOrder({@required int paymentId}) async {
  //   LoadingDialog.show(context);
  //   await Future.delayed(Duration(seconds: 1));
  //   await _cancelOrderCubit.cancelOrder(paymentId: paymentId);
  //   AppExt.popScreen(context);
  // }

  @override
  void dispose() {
    // _cancelOrderCubit.close();
    _fetchPaymentMethodCubit.close();
    _changePaymentMethodCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final config = AAppConfig.of(context);
    final JoinUserRepository _reshopRepo = JoinUserRepository();

    return new WillPopScope(
      onWillPop: () async {
        if (kIsWeb) {
          context.beamToNamed('/');
        } else {
           AppExt.popUntilRoot(context);
          BlocProvider.of<BottomNavCubit>(context).navItemTapped(0);
        }
        return;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => _fetchPaymentMethodCubit),
          BlocProvider(create: (_) => _changePaymentMethodCubit),
          // BlocProvider(create: (_) => _cancelOrderCubit),
        ],
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
          child: GestureDetector(
            onTap: () => AppExt.hideKeyboard(context),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: !context.isPhone ? 450 : 1000,
                ),
                child: Scaffold(
                  key: _scaffoldKey,
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            //automaticallyImplyLeading: !kIsWeb,
                            textTheme: TextTheme(headline6: AppTypo.subtitle2),
                            iconTheme: IconThemeData(color: Colors.black54),
                            backgroundColor: Colors.white,
                            centerTitle: true,
                            forceElevated: false,
                            pinned: true,
                            shadowColor: Colors.black54,
                            floating: true,
                            leading: IconButton(
                                splashRadius: 20,
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  context.beamToNamed('/wpp/dashboard/${_reshopRepo.getSlugReseller()}');
                                }),
                            title: Text(
                              "Pembayaran",
                              style: kIsWeb
                                  ? AppTypo.subtitle2
                                      .copyWith(color: Colors.black)
                                  : TextStyle(),
                            ),
                            brightness: Brightness.dark,
                          ),
                        ];
                      },
                      body: MultiBlocListener(
                        listeners: [
                          BlocListener(
                            bloc: _fetchPaymentMethodCubit,
                            listener: (_, state) async {
                              if (state is FetchPaymentMethodSuccess) {
                                final int index = state.paymentMethods
                                    .indexWhere((element) =>
                                        element.id ==
                                        widget.orderData.payment.paymentMethod
                                            .id);
                                setState(() {
                                  _selectedPaymentIndex =
                                      index >= 0 ? index : null;
                                });
                              }
                              if (state is FetchPaymentMethodFailure) {
                                _scaffoldKey.currentState
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    new SnackBar(
                                      backgroundColor: Colors.grey[900],
                                      content: new Text(
                                        "Terjadi kesalahan",
                                      ),
                                    ),
                                  );
                                return;
                              }
                            },
                          ),
                          BlocListener(
                            bloc: _changePaymentMethodCubit,
                            listener: (_, state) async {
                              if (state is ChangePaymentMethodSuccess) {
                                AppExt.popScreen(context);
                                AppExt.popUntilRoot(context);
                                AppExt.pushScreen(
                                    context,
                                    WppPaymentBayarLangsungDetailScreen(
                                      orderData: state.data,
                                    ));
                              }
                              if (state is ChangePaymentMethodFailure) {
                                AppExt.popScreen(context);
                                _scaffoldKey.currentState
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    new SnackBar(
                                      backgroundColor: Colors.red,
                                      content: new Text(
                                        "${state.message}",
                                      ),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                return;
                              }
                            },
                          ),
                        ],
                        child: AppTrans.SharedAxisTransitionSwitcher(
                            transitionType: SharedAxisTransitionType.vertical,
                            fillColor: Colors.transparent,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kIsWeb
                                            ? 35
                                            : _screenWidth * (8 / 100)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Batas waktu pembayaran ",
                                              style: AppTypo.body2Lato
                                                  .copyWith(fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            StreamBuilder<int>(
                                                stream: Ticker().tick(
                                                    ticks: _duration(
                                                        DateTime.now())),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    final duration =
                                                        snapshot.data;
                                                    final hoursStr =
                                                        ((duration / 3600) % 60)
                                                            .floor()
                                                            .toString()
                                                            .padLeft(2, '0');
                                                    final minutesStr =
                                                        ((duration / 60) % 60)
                                                            .floor()
                                                            .toString()
                                                            .padLeft(2, '0');
                                                    final secondsStr =
                                                        (duration % 60)
                                                            .floor()
                                                            .toString()
                                                            .padLeft(2, '0');
                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          " $hoursStr : $minutesStr : $secondsStr",
                                                          style: AppTypo
                                                              .body2Lato
                                                              .copyWith(
                                                                  color: Color(
                                                                      0xFFE7366B),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                  return SizedBox();
                                                })
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Mohon transfer sebelum waktu pembayaran berakhir agar transaksi tidak dibatalkan oleh Sistem",
                                          style: AppTypo.body1
                                              .copyWith(fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Transfer ke rekening",
                                                style: AppTypo.body1Lato),
                                            BlocBuilder(
                                              bloc: _fetchPaymentMethodCubit,
                                              builder: (context,
                                                      statePaymentMethod) =>
                                                  statePaymentMethod
                                                          is FetchPaymentMethodFailure
                                                      ? Center(
                                                          child: Text(
                                                              "Terjadi Kesalahan"),
                                                        )
                                                      : AppTrans
                                                          .SharedAxisTransitionSwitcher(
                                                          transitionType:
                                                              SharedAxisTransitionType
                                                                  .vertical,
                                                          fillColor: Colors
                                                              .transparent,
                                                          child: statePaymentMethod
                                                                      is FetchPaymentMethodSuccess &&
                                                                  statePaymentMethod
                                                                          .paymentMethods
                                                                          .length >
                                                                      0
                                                              ?
                                                              SizedBox() 
                                                              // Align(
                                                              //     alignment:
                                                              //         Alignment
                                                              //             .centerRight,
                                                              //     child:
                                                              //         Material(
                                                              //       color: Colors
                                                              //           .transparent,
                                                              //       child:
                                                              //           InkWell(
                                                              //         onTap:
                                                              //             () {
                                                              //           debugPrint("ID PEMBAYARANE " +
                                                              //               widget.orderData.payment.id.toString());
                                                              //           _showPaymentMethod(
                                                              //             context:
                                                              //                 context,
                                                              //             paymentMethod:
                                                              //                 statePaymentMethod.paymentMethods,
                                                              //             selectedPayment:
                                                              //                 _selectedPaymentIndex,
                                                              //             onChange:
                                                              //                 (paymentMethodId) {
                                                              //               AppExt.popScreen(context);
                                                              //               LoadingDialog.show(context);
                                                              //               _changePaymentMethodCubit.changePaymentMethod(
                                                              //                   paymentId: widget.orderData.payment.id,
                                                              //                   paymentMethodId: paymentMethodId);
                                                              //             },
                                                              //           );
                                                              //         },
                                                              //         borderRadius:
                                                              //             BorderRadius.circular(
                                                              //                 10),
                                                              //         highlightColor: AppColor
                                                              //             .danger
                                                              //             .withOpacity(
                                                              //                 0.2),
                                                              //         splashColor: AppColor
                                                              //             .danger
                                                              //             .withOpacity(
                                                              //                 0.2),
                                                              //         splashFactory:
                                                              //             InkRipple
                                                              //                 .splashFactory,
                                                              //         child:
                                                              //             Padding(
                                                              //           padding: const EdgeInsets.symmetric(
                                                              //               horizontal:
                                                              //                   10.0,
                                                              //               vertical:
                                                              //                   3),
                                                              //           child:
                                                              //               Text(
                                                              //             "Ubah Rekening",
                                                              //             style: AppTypo.overline.copyWith(
                                                              //                 color: AppColor.danger,
                                                              //                 decoration: TextDecoration.underline),
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //     ),
                                                              //   )
                                                              : SizedBox
                                                                  .shrink(),
                                                        ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child:Image.network(
                                                      widget.orderData.payment
                                                          .paymentMethod.image,
                                                      // "",
                                                      width: 70,
                                                      height: 40,
                                                      fit: BoxFit.cover,
                                                      frameBuilder: (context,
                                                          child,
                                                          frame,
                                                          wasSynchronouslyLoaded) {
                                                        if (wasSynchronouslyLoaded) {
                                                          return child;
                                                        } else {
                                                          return AnimatedSwitcher(
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          500),
                                                              child: frame !=
                                                                      null
                                                                  ? child
                                                                  : Container(
                                                                      width: 60,
                                                                      height:
                                                                          60,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: Colors
                                                                            .grey[200],
                                                                      ),
                                                                    ));
                                                        }
                                                      },
                                                      errorBuilder: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                        AppImg.img_error,
                                                        width: 60,
                                                        height: 60,
                                                      ),
                                                    )
                                            ),
                                            SizedBox(
                                              width: _screenWidth * (4.5 / 100),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget
                                                        .orderData
                                                        .payment
                                                        .paymentMethod
                                                        .accountNumber,
                                                    style: AppTypo.LatoBold,
                                                  ),
                                                  Text(
                                                    "a/n ${widget.orderData.payment.paymentMethod.accountName}",
                                                    style: AppTypo.body2Lato,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 27,
                                              child: OutlineButton(
                                                borderSide: BorderSide(
                                                  color: AppColor.primary,
                                                ),
                                                highlightColor: AppColor.primary
                                                    .withOpacity(0.3),
                                                splashColor: AppColor.primary
                                                    .withOpacity(0.3),
                                                highlightedBorderColor:
                                                    AppColor.primary,
                                                padding: EdgeInsets.only(
                                                    left: 15, right: 15),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                onPressed: () => AppExt.handleCopy(
                                                    context,
                                                    widget
                                                        .orderData
                                                        .payment
                                                        .paymentMethod
                                                        .accountNumber,
                                                    "Nomor rekening telah disalin"),
                                                child: Text(
                                                  "Salin",
                                                  style: AppTypo.caption
                                                      .copyWith(
                                                          color:
                                                              AppColor.primary),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Divider(color: AppColor.grey),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Nominal Transfer",
                                                  style: AppTypo.body1Lato,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Rp." +
                                                      AppExt.toRupiah(widget
                                                          .orderData
                                                          .payment
                                                          .amount),
                                                  style: AppTypo.h3.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColor.primary),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 27,
                                              child: OutlineButton(
                                                borderSide: BorderSide(
                                                  color: AppColor.primary,
                                                ),
                                                highlightColor: AppColor.primary
                                                    .withOpacity(0.3),
                                                splashColor: AppColor.primary
                                                    .withOpacity(0.3),
                                                highlightedBorderColor:
                                                    AppColor.primary,
                                                padding: EdgeInsets.only(
                                                    left: 15, right: 15),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                onPressed: () => AppExt.handleCopy(
                                                    context,
                                                    "10000",
                                                    "Jumlah transfer telah disalin"),
                                                child: Text(
                                                  "Salin",
                                                  style: AppTypo.caption
                                                      .copyWith(
                                                          color:
                                                              AppColor.primary),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kIsWeb
                                            ? 35
                                            : _screenWidth * (8 / 100)),
                                    child: Column(
                                      children: [
                                        RoundedButton.contained(
                                            label: "Belanja Lagi",
                                            isUpperCase: false,
                                            textColor:
                                                AppColor.textPrimaryInverted,
                                            onPressed: (){
                                              context.beamToNamed('/wpp/dashboard/${_reshopRepo.getSlugReseller()}');
                                            }
                                        ),
                                        // SizedBox(
                                        //   height: 12,
                                        // ),
                                        // RoundedButton.outlined(
                                        //   label: "Download Invoice",
                                        //   onPressed: () {
                                        //     kIsWeb
                                        //         ? context.beamToNamed(
                                        //             '/invoicepayment/${widget.orderData.payment.id}')
                                        //         : AppExt.pushScreen(
                                        //             context,
                                        //             InvoicePaymentScreen(
                                        //               paymentId: widget
                                        //                   .orderData.payment.id,
                                        //             ));
                                        //   },
                                        //   isUpperCase: false,
                                        // ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
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

  void _showPaymentMethod({
    @required BuildContext context,
    @required List<PaymentMethod> paymentMethod,
    @required int selectedPayment,
    @required void Function(int) onChange,
  }) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    final int initialPayment = selectedPayment;
    showModalBottomSheet(
      constraints: BoxConstraints(maxWidth: kIsWeb ? 425 : 600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setSheetState) {
          return Container(
            constraints: BoxConstraints(maxHeight: _screenHeight * (90 / 100)),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: _screenWidth * (15 / 100),
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(7.5 / 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: [
                        Text(
                          "Ganti Metode Pembayaran",
                          textAlign: TextAlign.start,
                          style: AppTypo.subtitle2v2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        paymentMethod.length > 0
                            ? ListView.separated(
                                key: Key("loaded_otp"),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, id) {
                                  return PaymentOption(
                                      label: "${paymentMethod[id].name}",
                                      imageUrl: "${paymentMethod[id].image}" ??
                                          "https://end.ekomad.id/images/blank.png",
                                      selected: selectedPayment == id,
                                      onTap: () {
                                        setSheetState(() {
                                          selectedPayment = id;
                                        });
                                      });
                                },
                                separatorBuilder: (context, id) => SizedBox(
                                      height: 15,
                                    ),
                                itemCount: paymentMethod.length)
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RoundedButton.contained(
                    label: "Ubah Pembayaran",
                    disabled: selectedPayment == initialPayment,
                    onPressed: () =>
                        onChange(paymentMethod[selectedPayment].id),
                    isUpperCase: false,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}

class PaymentOption extends StatelessWidget {
  final String label;
  final String imageUrl;
  final bool selected;
  final VoidCallback onTap;

  const PaymentOption({
    Key key,
    @required this.label,
    @required this.imageUrl,
    @required this.selected,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      borderRadius: BorderRadius.circular(7.5),
      hoverColor: !context.isPhone
          ? Colors.transparent
          : AppColor.primaryLight1.withOpacity(0.3),
      splashColor: AppColor.primaryLight1.withOpacity(0.3),
      highlightColor: AppColor.primaryLight2.withOpacity(0.3),
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.all(!context.isPhone ? 20 : _screenWidth * (4.5 / 100)),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.line, width: 1),
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl ?? "https://end.ekomad.id/images/blank.png",
                memCacheHeight:
                    Get.height > 350 ? (Get.height * 0.25).toInt() : Get.height,
                width: _screenWidth * (17.5 / 100),
                height: _screenWidth * (13 / 100),
                fit: BoxFit.contain,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[200],
                  period: Duration(milliseconds: 1000),
                  child: Container(
                    width: _screenWidth * (17.5 / 100),
                    height: _screenWidth * (13 / 100),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  AppImg.img_error,
                  width: _screenWidth * (17.5 / 100),
                  height: _screenWidth * (13 / 100),
                ),
              ),
            ),
            SizedBox(
              width: _screenWidth * (4.5 / 100),
            ),
            Expanded(
              child: Text(
                label.toUpperCase(),
                style: AppTypo.h3,
              ),
            ),
            Icon(
              selected
                  ? FlutterIcons.check_circle_mco
                  : FlutterIcons.checkbox_blank_circle_outline_mco,
              color: AppColor.primary,
              size: 35,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
