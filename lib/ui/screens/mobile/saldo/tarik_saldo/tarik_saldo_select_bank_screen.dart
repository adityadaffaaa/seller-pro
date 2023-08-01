import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marketplace/ui/screens/mobile/saldo/tarik_saldo/widgets/list_bank_item.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;

import 'package:marketplace/utils/typography.dart' as AppTypo;

class TarikSaldoSelectBankScreen extends StatefulWidget {
  const TarikSaldoSelectBankScreen(
      {Key key,
      this.checkoutTemp,
      this.isUseWallet = false,
      this.walletLogId,
      this.walletLogToken})
      : super(key: key);

  final checkoutTemp;
  final bool isUseWallet;

  //For Payment With Wallet
  final int walletLogId;
  final String walletLogToken;

  @override
  _TarikSaldoSelectBankScreenState createState() =>
      _TarikSaldoSelectBankScreenState();
}

class _TarikSaldoSelectBankScreenState
    extends State<TarikSaldoSelectBankScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Variable for get passing data
  int _recipentIdUser;

  @override
  void initState() {
    super.initState();
  }

  void handleBayar({@required int paymentMethodId}) {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        // AppExt.popScreen(context);
        // AppExt.popScreen(context);
        // AppExt.pushScreen(
        //     context,
        //     CheckoutScreen(
        //       cart: widget.checkoutTemp.cart,
        //     ));
        // return;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kIsWeb ? 425 : 600),
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
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // AppExt.popScreen(context);
                          },
                        ),
                        iconTheme: const IconThemeData(color: AppColor.black),
                        textTheme: TextTheme(
                          headline6: AppTypo.subtitle1,
                        ),
                        backgroundColor: Colors.white,
                        centerTitle: true,
                        forceElevated: false,
                        pinned: true,
                        shadowColor: Colors.black54,
                        floating: true,
                        title: Text(
                          "Pilih Bank",
                          style: kIsWeb
                              ? AppTypo.latoSixteen
                                  .copyWith(color: Colors.black)
                              : AppTypo.latoBold.copyWith(
                                  color: AppColor.black,
                                ),
                        ),
                        brightness: Brightness.dark,
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: _screenWidth * (5 / 120)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const ListBankItem(
                              // paymentMethod: state.paymentMethods,
                              // onSelected: (data) {
                              //   setState(() {
                              //     _selectedPayment = data;
                              //   });
                              // },
                              ),
                          const SizedBox(
                            height: 15,
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
}
