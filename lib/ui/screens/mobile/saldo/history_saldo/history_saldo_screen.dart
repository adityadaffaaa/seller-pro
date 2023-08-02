import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketplace/ui/screens/mobile/saldo/detail_transaksi/detail_transaksi_komisi_screen.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;

import 'widgets/bs_saldo_tanggal.dart';

class HistorySaldoScreen extends StatefulWidget {
  const HistorySaldoScreen({Key key}) : super(key: key);

  @override
  _HistorySaldoScreenState createState() => _HistorySaldoScreenState();
}

class _HistorySaldoScreenState extends State<HistorySaldoScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: kIsWeb ? 425 : 600,
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            title: Text(
              "Riwayat",
              style: AppTypo.latoBold.copyWith(
                color: AppColor.black,
              ),
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
            bottom: PreferredSize(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 50.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 8,
                        child: EditText(
                          fillColor: AppColor.lightGrey3,
                          hintText: "Cari Riwayat",
                          inputType: InputType.search,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            BsSaldoTanggal().showBsStatus(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.filter_alt_outlined,
                                color: Colors.grey,
                              ),
                              Text(
                                "Filter",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                preferredSize: Size.fromHeight(50.0)),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      AppExt.pushScreen(context, DetailTransaksiKomisiScreen());
                      // if (state.wallets[index].type ==
                      //     "commission")
                      //   AppExt.pushScreen(
                      //       context,
                      //       DetailSaldoKomisiScreen(
                      //         logId: state.wallets[index].id,
                      //       ));
                      // if (state.wallets[index].type ==
                      //     "withdrawal")
                      //   AppExt.pushScreen(
                      //       context,
                      //       DetailSaldoPenarikanScreen(
                      //         logId: state.wallets[index].id,
                      //       ));
                      // if (state.wallets[index].type == "sale")
                      //   AppExt.pushScreen(
                      //       context,
                      //       DetailSaldoPenjualanScreen(
                      //         logId: state.wallets[index].id,
                      //       ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  AppImg.ic_dompet_2,
                                  width: 16,
                                  height: 16,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Komisi Penjualan",
                                        style: AppTypo.caption.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Komisi untuk transaksi INV/20210412/1827182 - Nurul Fatimah",
                                        style: AppTypo.caption.copyWith(
                                            color: Colors.grey, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  const Icon(Ionicons.ios_remove,
                                      size: 12, color: AppColor.red),
                                  const SizedBox(width: 2),
                                  Text(
                                    "50.000",
                                    style: AppTypo.caption.copyWith(
                                        color: AppColor.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                "10-11-2020",
                                style: AppTypo.caption.copyWith(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
