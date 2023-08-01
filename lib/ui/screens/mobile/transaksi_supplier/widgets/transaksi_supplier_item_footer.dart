import 'package:flutter/material.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/change_transaction_status_supplier_cubit/change_transaction_status_supplier_cubit.dart';
import 'package:marketplace/data/models/new_models/order.dart';
import 'package:marketplace/ui/screens/mobile/transaksi_detail/transaksi_status_pesanan_screen.dart';
import 'package:marketplace/ui/widgets/bs_confirmation.dart';
import 'package:marketplace/ui/widgets/filled_button.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:flutter_bloc/flutter_bloc.dart';

class TransaksiSupplierItemFooter extends StatefulWidget {
  const TransaksiSupplierItemFooter({
    Key key,
    @required this.item,
  }) : super(key: key);

  final OrderResponseData item;

  @override
  State<TransaksiSupplierItemFooter> createState() =>
      _TransaksiSupplierItemFooterState();
}

class _TransaksiSupplierItemFooterState
    extends State<TransaksiSupplierItemFooter> {

  TextEditingController _airwayBillCtrl = TextEditingController();

  void airwayBillDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            child: Container(
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Masukkan Nomor Resi",
                        style: AppTypo.LatoBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Silahkan masukan no.resi paket",
                        style: AppTypo.body2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    EditText(controller: _airwayBillCtrl,hintText: "Contoh : AUR482731C2"),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedButton.contained(
                        label: "Submit",
                        textColor: Colors.white,
                        isUpperCase: false,
                        onPressed: () {
                          context.read<ChangeTransactionStatusSupplierCubit>().changeStatus(orderId: widget.item.id, status: 4,airwayBill: _airwayBillCtrl.text);
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return widget.item.status.toLowerCase() == "menunggu konfirmasi"
        ? waitingConfirmFooter(context)
        : generalFooter(context);
  }

  Padding waitingConfirmFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                BsConfirmation().show(
                    context: context,
                    onYes: () {
                      context.read<ChangeTransactionStatusSupplierCubit>().changeStatus(orderId: widget.item.id, status: 3);
                    },
                    title: "Apakah anda yakin ingin memproses pesanan ?");
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Terima",
                        style: AppTypo.LatoBold.copyWith(color: Colors.green),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                BsConfirmation().show(
                    context: context,
                    onYes: () {
                      context.read<ChangeTransactionStatusSupplierCubit>().changeStatus(orderId: widget.item.id, status: 8);
                    },
                    title: "Apakah anda yakin ingin menolak pesanan ?");
              },
              child: Container(
                 color: Colors.transparent,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.not_interested,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Tolak",
                        style: AppTypo.LatoBold.copyWith(color: Colors.red),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Row generalFooter(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Harga", style: AppTypo.caption),
              Text(
                "${widget.item.totalPrice}",
                style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        /*child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("560 232 7752", style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600)),
            Text("a/n PT.ADMA Digital Solusi", style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),*/
        _action(context, widget.item),
      ],
    );
  }

  Widget _action(BuildContext context, OrderResponseData item) {
    final status = item.status;
    if (status == "Menunggu Pembayaran") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("560 232 7752",
              style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600)),
          Text("a/n PT.ADMA Digital Solusi",
              style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600)),
        ],
      );
    } else if (status == "Diproses") {
      return FilledButton(
        onPressed: () => airwayBillDialog(),
        color: Theme.of(context).primaryColor,
        child: Text(
          "Kirim",
          style: AppTypo.caption.copyWith(color: Colors.white),
        ),
      );
    } else if (status == "Dikirim") {
      return FilledButton(
        onPressed: () {
          AppExt.pushScreen(context, TransaksiStatusPesananScreen(orderId:item.id,isSupplier: 1,));
        },
        color: Theme.of(context).primaryColor,
        child: Text(
          "Lacak",
          style: AppTypo.caption.copyWith(color: Colors.white),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
