import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/ui/widgets/filled_button.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class BsSaldoTanggal {
  Future<void> showBsStatus(BuildContext context) async {
    await showModalBottomSheet(
        constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                    // shrinkWrap: true,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Pilih Status",
                          style: AppTypo.subtitle1
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      RadioTanggalSaldo(),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Mulai Dari", style: AppTypo.caption),
                                  Text(
                                    DateFormat("dd MMM yyyy", 'in_ID').format(
                                        "Date" ??
                                            DateTime.now()
                                                .subtract(Duration(days: 1))),
                                    style: AppTypo.caption
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              onTap: () {
                                // _showDatePicker(context,
                                //     initialDateTime: state.startDate ??
                                //         DateTime.now().subtract(
                                //             Duration(days: 1)),
                                //     onDateTimeChanged: (val) {
                                //   context
                                //       .read<
                                //           TransaksiFilterTanggalCubit>()
                                //       .changeStartDate(val);
                                // });
                              },
                            ),
                            GestureDetector(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Sampai", style: AppTypo.caption),
                                  Text(
                                      DateFormat("dd MMM yyyy", 'in_ID')
                                          .format("Date" ?? DateTime.now()),
                                      style: AppTypo.caption.copyWith(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              onTap: () => _showDatePicker(context,
                                  initialDateTime: "Date" ??
                                      DateTime.now()
                                          .subtract(Duration(days: 1)),
                                  onDateTimeChanged: (val) {
                                // context
                                //     .read<TransaksiFilterTanggalCubit>()
                                //     .changeEndDate(val);
                              }),
                            ),
                          ],
                        ),
                      )
                    ]),
                SizedBox(
                  width: double.infinity,
                  child:
                      //  ElevatedButton(onPressed: () {}, child: Text("data"))
                      FilledButton(
                        color: AppColor.primary,
                          // color: Theme.of(context).primaryColor,
                          child: Text(
                            "Tampilkan",
                            style: AppTypo.subtitle1
                                .copyWith(color: Colors.white),
                          ),
                          onPressed: () {}),
                ),
              ],
            ),
          );
        });
  }
}

void _showDatePicker(BuildContext context,
    {DateTime initialDateTime, Function(DateTime) onDateTimeChanged}) {
  // showCupertinoModalPopup is a built-in function of the cupertino library
  showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
            height: 330,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => AppExt.popScreen(context),
                        child: Icon(
                          Icons.close,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Material(
                        child: Text(
                          "Pilih Tanggal",
                          style: AppTypo.caption
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                      initialDateTime: initialDateTime,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: onDateTimeChanged),
                ),

                // Close the modal
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {}, child: Text("data"))
                    //  FilledButton(
                    //     color: Theme.of(context).primaryColor,
                    //     child: Text(
                    //       "Tampilkan",
                    //       style:
                    //           AppTypo.subtitle1.copyWith(color: Colors.white),
                    //     ),
                    //     onPressed: () {
                    //       AppExt.popScreen(context);
                    //     }),
                    )
              ],
            ),
          ));
}

class RadioTanggalSaldo extends StatelessWidget {
  const RadioTanggalSaldo({Key key}) : super(key: key);

  List<Widget> radioListStatus() {
    List<String> _status = [
      "Semua Tanggal Transaksi",
      "90 Hari Terakhir",
      "30 Hari Terakhir",
      "Pilih Tanggal Manual",
    ];

    List<Widget> widgets = [];
    for (var i = 0; i < _status.length; i++) {
      widgets.add(Text("data")
          // BlocBuilder<TransaksiFilterTanggalCubit, TransaksiFilterTanggalState>(
          //   builder: (context, state) {
          //     return RadioListTile(
          //       value: _status.length,
          //       groupValue: state.status,
          //       title: Text(_status[i]),
          //       onChanged: (val) {
          //         context
          //             .read<TransaksiFilterTanggalCubit>()
          //             .changeStatus(val, i);
          //       },
          //       selected: state.status == _status[i],
          //       controlAffinity: ListTileControlAffinity.trailing,
          //     );
          //   },
          // ),
          );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: radioListStatus(),
    );
  }
}
