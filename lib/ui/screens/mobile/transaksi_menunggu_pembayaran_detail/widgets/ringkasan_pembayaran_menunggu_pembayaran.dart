import 'package:flutter/material.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/models/new_models/order.dart';
import 'package:marketplace/ui/widgets/data_table.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;

class RingkasanPembayaranMenungguPembayaran extends StatefulWidget {
  const RingkasanPembayaranMenungguPembayaran({
    Key key,
    @required this.data,
  }) : super(key: key);

  final PaymentDetail data;

  @override
  _RingkasanPembayaranMenungguPembayaranState createState() =>
      _RingkasanPembayaranMenungguPembayaranState();
}

class _RingkasanPembayaranMenungguPembayaranState
    extends State<RingkasanPembayaranMenungguPembayaran> {
  int total;

  @override
  void initState() {
    super.initState();
    final productsLen = widget.data.orders.map((e) => e.items.length);
    total = productsLen.reduce((a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ringkasan Pembayaran",
          style: AppTypo.subtitle1.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 16,
        ),
        dataTable.boldDetail(
          "Metode Pembayaran",
          widget.data.bankName,
        ),
        SizedBox(
          height: 3,
        ),
        dataTable.boldDetail(
          "Subtotal ( $total Item )",
          widget.data.subtotal,
        ),
        SizedBox(
          height: 3,
        ),
        dataTable.boldDetail(
          "Ongkos Kirim",
          widget.data.totalOngkir,
        ),
        SizedBox(
          height: 3,
        ),
        widget.data.saldoDiscount != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Saldo Dompet",
                    style: AppTypo.caption,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "- ${widget.data.saldoDiscount}",
                    style: AppTypo.overline.copyWith(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : SizedBox(),
        SizedBox(
          height: 6,
        ),
        Divider(
          thickness: 1,
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "TOTAL",
                  style: AppTypo.caption.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.data.totalPayment,
                  style: AppTypo.caption.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
