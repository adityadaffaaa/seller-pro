import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/fetch_transaction_menunggu_pembayaran_detail/fetch_transaction_menunggu_pembayaran_detail_cubit.dart';
import 'package:marketplace/ui/screens/mobile/transaksi_detail/widgets/invoice_pesanan_user.dart';
import 'package:marketplace/ui/widgets/fetch_conditions.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;

import '../nav/transaksi/transaksi_menunggu_pembayaran_screen.dart';
import 'widgets/detail_menunggu_pembayaran_header.dart';
import 'widgets/detail_pengiriman_menunggu_pembayaran.dart';
import 'widgets/detail_pesanan_list_menunggu_pembayaran.dart';
import 'widgets/ringkasan_pembayaran_menunggu_pembayaran.dart';
import 'widgets/status_pesanan_menunggu_pembayaran.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TransaksiMenungguPembayaranDetailScreen extends StatefulWidget {
  const TransaksiMenungguPembayaranDetailScreen(
      {Key key, @required this.paymentId})
      : super(key: key);

  final int paymentId;

  @override
  _TransaksiMenungguPembayaranDetailScreenState createState() =>
      _TransaksiMenungguPembayaranDetailScreenState();
}

class _TransaksiMenungguPembayaranDetailScreenState
    extends State<TransaksiMenungguPembayaranDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<FetchTransactionMenungguPembayaranDetailCubit>()
        .fetchDetail(paymentId: widget.paymentId);
    debugPrint("PAYMENT ID : ${widget.paymentId.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: kIsWeb ? 450 : 1000),
        child: Scaffold(
          appBar: AppBar(
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
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Detail Pesanan",
              style: AppTypo.subtitle2,
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: SafeArea(
            child: BlocBuilder<FetchTransactionMenungguPembayaranDetailCubit,
                FetchTransactionMenungguPembayaranDetailState>(
              builder: (context, state) {
                if (state is FetchTransactionMenungguPembayaranDetailSuccess) {
                  final items = state.items;
                  return Container(
                    padding: EdgeInsets.all(12),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StatusPesananMenungguPembayaran(
                              status: items.status,
                              orderId: items.orders[0].id,
                              resi: items.transactionCode),
                          Divider(
                            thickness: 1,
                          ),
                          DetailMenungguPembayaranHeader(
                            data: items,
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          DetailPesananListMenungguPembayaran(
                            data: items,
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          RingkasanPembayaranMenungguPembayaran(
                            data: items,
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          DetailPengirimanMenungguPembayaran(data: items)
                        ],
                      ),
                    ),
                  );
                }
                if (state is FetchTransactionMenungguPembayaranDetailFailure) {
                  return Center(
                    child: ErrorFetch(
                      message: state.message,
                      onButtonPressed: () {
                        context
                            .read<
                                FetchTransactionMenungguPembayaranDetailCubit>()
                            .fetchDetail(paymentId: widget.paymentId);
                      },
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
