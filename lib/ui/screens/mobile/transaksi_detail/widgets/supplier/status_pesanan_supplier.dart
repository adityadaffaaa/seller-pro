import 'package:flutter/material.dart';
import 'package:marketplace/ui/screens/mobile/transaksi_detail/transaksi_status_pesanan_screen.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class StatusPesananSupplier extends StatelessWidget {
  final String status;
  final int orderId;

  const StatusPesananSupplier({Key key, @required this.status, @required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Status",
              style: AppTypo.caption,
            ),
            SizedBox(
              height: 5,
            ),
            Text(status,
                style: AppTypo.subtitle2
                    .copyWith(color: Theme.of(context).primaryColor)),
          ],
        ),
        status != "Ditolak" ?
        TextButton(
          onPressed: () {
            AppExt.pushScreen(context, TransaksiStatusPesananScreen(orderId: orderId,isSupplier: 1,));
          },
          child: Text("Lihat Status",
              style: AppTypo.caption.copyWith(
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline,
              )),
        ) : SizedBox()
      ],
    );
  }
}
