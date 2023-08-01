// import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/ui/screens/mobile/payment/payment_bayar_langsung_detail_screen.dart';
import 'package:marketplace/ui/screens/mobile/saldo/tarik_saldo/tarik_saldo_detail_screen.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import 'package:marketplace/ui/widgets/rounded_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;

class TarikSaldoScreen extends StatefulWidget {
  const TarikSaldoScreen({Key key}) : super(key: key);

  @override
  _TarikSaldoScreenState createState() => _TarikSaldoScreenState();
}

class _TarikSaldoScreenState extends State<TarikSaldoScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _saldoCtrl = TextEditingController();
  TextEditingController _noRekCtrl = TextEditingController();
  TextEditingController _atasNamaCtrl = TextEditingController();

  //For Passing From _showPaymentMethod()
  int _selectedPaymentIdx;

  int minWithdraw = 0;

  @override
  void initState() {
    super.initState();
  }

  String saldoValidation(String value) {
    // if (value.isEmpty) {
    //   return "Wajib diisi";
    // } else if (int.parse(AppExt.deleteAllComma(value)) < minWithdraw) {
    //   return "Minimal saldo yang ditarik yaitu $minWithdraw";
    // } else if (int.parse(AppExt.deleteAllComma(value)) >
    //     int.parse(AppExt.deleteDotInPrice(user.walletBalance))) {
    //   return "Saldo anda tidak cukup";
    // }
    return null;
  }

  String generalValidation(String value) {
    if (value.isEmpty) {
      return "Wajib diisi";
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: kIsWeb ? 425 : 600,
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            title: Text(
              "Tarik Saldo",
              style: AppTypo.subtitle1,
            ),
            actions: [],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                AppExt.popScreen(context);
              },
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey[300])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "images/icons/ic_saldo.svg",
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Total Saldo Anda",
                                style: AppTypo.disableText,
                              ),
                            ],
                          ),
                          Text("21.000",
                              style: AppTypo.caption
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Saldo yang ditarik",
                      style: AppTypo.boldCaption,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    EditText(
                      hintText: "Saldo yang ditarik",
                      controller: _saldoCtrl,
                      isHint: true,
                      keyboardType: TextInputType.number,
                      validator: saldoValidation,
                      inputType: InputType.price,
                      inputFormatter: [ThousandsFormatter()],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey[300]),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ketentuan",
                              style: AppTypo.boldCaption,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "•",
                                  style: AppTypo.captionGold,
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    "Diproses dalam kurung waktu 2x24 jam pada jam kerja",
                                    style: AppTypo.caption,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "•",
                                  style: AppTypo.captionGold,
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    "Minimal pencairan dana sebesar Rp 20.000,-",
                                    style: AppTypo.caption,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "•",
                                  style: AppTypo.captionGold,
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    "Jumlah yang di tarik tidak melebihi saldo yang dimiliki",
                                    style: AppTypo.caption,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Pilih Bank",
                      style: AppTypo.boldCaption,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => null,
                        // _showPaymentMethod(
                        //   context: context,
                        //   selectedPaymentIndex: _selectedPaymentIdx,
                        // ),
                        child: Container(
                          padding: EdgeInsets.only(
                              right: kIsWeb
                                  ? _screenWidth * (1 / 100)
                                  : _screenWidth * (3 / 100),
                              left: kIsWeb
                                  ? _screenWidth * (1 / 100)
                                  : _screenWidth * (3 / 100),
                              top: kIsWeb
                                  ? _screenWidth * (1 / 100)
                                  : _screenWidth * (3 / 100),
                              bottom: kIsWeb
                                  ? _screenWidth * (1 / 100)
                                  : _screenWidth * (3 / 100)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 3, color: Colors.grey[300])),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: "",
                                    // memCacheHeight: Get.height > 350
                                    //     ? (Get.height * 0.25)
                                    //         .toInt()
                                    //     : Get.height,
                                    width: kIsWeb
                                        ? _screenWidth * (8 / 100)
                                        : _screenWidth * (17.5 / 100),
                                    height: kIsWeb
                                        ? _screenWidth * (4 / 100)
                                        : _screenWidth * (10 / 100),
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.grey[200],
                                      period: Duration(milliseconds: 1000),
                                      child: Container(
                                        width: kIsWeb
                                            ? _screenWidth * (8 / 100)
                                            : _screenWidth * (17.5 / 100),
                                        height: kIsWeb
                                            ? _screenWidth * (4 / 100)
                                            : _screenWidth * (10 / 100),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      AppImg.img_error,
                                      width: kIsWeb
                                          ? _screenWidth * (8 / 100)
                                          : _screenWidth * (17.5 / 100),
                                      height: kIsWeb
                                          ? _screenWidth * (4 / 100)
                                          : _screenWidth * (10 / 100),
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    "Pilih Bank",
                                    style: AppTypo.caption,
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                      ),
                    )
                    // ? ListTile(
                    //     //contentPadding: EdgeInsets.symmetric(horizontal: 6),
                    //     onTap: () => _showPaymentMethod(
                    //         context: context,
                    //         paymentMethod: state.paymentMethods,
                    //         selectedPaymentIndex:
                    //             _selectedPaymentIdx,
                    //         onChange: (int paymentIdxSelected,
                    //             PaymentMethod paymentMethod) {
                    //           setState(() {
                    //             _selectedPaymentIdx =
                    //                 paymentIdxSelected;
                    //             _paymentMethod = paymentMethod;
                    //           });
                    //         }),
                    //     leading: _paymentMethod != null
                    //         ? CachedNetworkImage(
                    //             imageUrl: _paymentMethod.image,
                    //             memCacheHeight: Get.height > 350
                    //                 ? (Get.height * 0.25)
                    //                     .toInt()
                    //                 : Get.height,
                    //             width:
                    //                 _screenWidth * (14.5 / 100),
                    //             height:
                    //                 _screenWidth * (10 / 100),
                    //             fit: BoxFit.contain,
                    //             placeholder: (context, url) =>
                    //                 Shimmer.fromColors(
                    //               baseColor: Colors.grey[300],
                    //               highlightColor:
                    //                   Colors.grey[200],
                    //               period: Duration(
                    //                   milliseconds: 1000),
                    //               child: Container(
                    //                 width: _screenWidth *
                    //                     (17.5 / 100),
                    //                 height: _screenWidth *
                    //                     (13 / 100),
                    //                 decoration: BoxDecoration(
                    //                     borderRadius:
                    //                         BorderRadius
                    //                             .circular(10),
                    //                     color: Colors.white),
                    //               ),
                    //             ),
                    //             errorWidget:
                    //                 (context, url, error) =>
                    //                     Image.asset(
                    //               AppImg.img_error,
                    //               width: _screenWidth *
                    //                   (17.5 / 100),
                    //               height:
                    //                   _screenWidth * (13 / 100),
                    //             ),
                    //           )
                    //         : Icon(
                    //             Icons.monetization_on_outlined,
                    //             color: Theme.of(context)
                    //                 .primaryColor,
                    //           ),
                    //     title: Text(
                    //       _paymentMethod != null
                    //           ? _paymentMethod.name
                    //           : "Pilih Bank",
                    //       style: AppTypo.caption,
                    //     ),
                    //     trailing: Icon(Icons.arrow_forward_ios),
                    //     shape: RoundedRectangleBorder(
                    //         side: BorderSide(
                    //             color: Colors.grey[300],
                    //             width: 3),
                    //         borderRadius:
                    //             BorderRadius.circular(5)),
                    //   )
                    ,
                    Text(
                      "Wajib diisi",
                      style: AppTypo.body1Lato
                          .copyWith(color: Colors.red[800], fontSize: 12),
                    ),
                    SizedBox(height: _selectedPaymentIdx == -1 ? 12 : 8),
                    Text(
                      "No. Rekening",
                      style: AppTypo.boldCaption,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    EditText(
                      hintText: "No. Rekening",
                      controller: _noRekCtrl,
                      validator: generalValidation,
                      keyboardType: TextInputType.number,
                      isHint: true,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Atas Nama",
                      style: AppTypo.boldCaption,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    EditText(
                      hintText: "Atas Nama",
                      controller: _atasNamaCtrl,
                      validator: generalValidation,
                      isHint: true,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    RoundedButton.contained(
                        label: "Tarik",
                        isUpperCase: false,
                        onPressed: () {
                          if (_selectedPaymentIdx == null) {
                            setState(() {
                              _selectedPaymentIdx = -1;
                            });
                          }
                          if (_selectedPaymentIdx != -1) {
                            if (_formKey.currentState.validate()) {
                              AppExt.pushScreen(
                                  context, TarikSaldoDetailScreen());
                            }
                          }
                        })
                  ],
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
  }) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
        constraints: BoxConstraints(maxWidth: kIsWeb ? 450 : 1000),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        builder: (BuildContext bc) {
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
                          "Pilih Bank",
                          textAlign: TextAlign.start,
                          style: AppTypo.subtitle2v2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          itemCount: 2,
                          key: Key("loaded_otp"),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return PaymentOption();
                          },
                          separatorBuilder: (context, id) => SizedBox(
                            height: 15,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
