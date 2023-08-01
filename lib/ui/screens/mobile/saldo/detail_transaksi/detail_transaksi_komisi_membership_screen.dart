import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;

class DetailTransaksiKomisiMembershipScreen extends StatefulWidget {
  const DetailTransaksiKomisiMembershipScreen({
    Key key,
  }) : super(key: key);

  @override
  State<DetailTransaksiKomisiMembershipScreen> createState() =>
      _DetailTransaksiKomisiMembershipScreenState();
}

class _DetailTransaksiKomisiMembershipScreenState
    extends State<DetailTransaksiKomisiMembershipScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Detail Transaksi",
          style: AppTypo.latoBold.copyWith(
            color: AppColor.black,
          ),
        ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _screenWidth * (5 / 100), vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: _screenWidth,
                      // padding: EdgeInsets.symmetric(
                      //     horizontal: _screenWidth * (5/100), vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Berhasil diterima",
                            style: AppTypo.body2Lato
                                .copyWith(color: AppColor.inactiveSwitch),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "+ 25.000",
                            style: AppTypo.subtitle1.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          // Row(
                          //   mainAxisAlignment:
                          //       MainAxisAlignment.center,
                          //   children: [
                          //     Icon(
                          //       Icons.check_circle,
                          //       color: Colors.green,
                          //     ),

                          //   ],
                          // ),
                          // Text(
                          //   "${state.wallet.date}",
                          //   style: AppTypo.disableText,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -15,
                    left: _screenWidth * (40 / 100),
                    child: SvgPicture.asset(
                      AppImg.ic_status_success,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Material(
                color: Colors.white,
                elevation: 2,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _screenWidth * (5 / 100), vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rincian Referral",
                        style: AppTypo.subtitle1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Nama",
                                style: AppTypo.body2Lato.copyWith(
                                    color: Color(0xFFABABAF), fontSize: 14)),
                            Text("Alexander",
                                style: AppTypo.latoBold.copyWith(
                                  fontSize: 14,
                                ))
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("No. Handphone",
                                style: AppTypo.body2Lato.copyWith(
                                    color: Color(0xFFABABAF), fontSize: 14)),
                            Text("628123456789",
                                style: AppTypo.latoBold.copyWith(
                                  fontSize: 14,
                                ))
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Jenis Member",
                                style: AppTypo.body2Lato.copyWith(
                                    color: Color(0xFFABABAF), fontSize: 14)),
                            Text("Dropshipper",
                                style: AppTypo.latoBold.copyWith(
                                  fontSize: 14,
                                ))
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Waktu Bergabung",
                                style: AppTypo.body2Lato.copyWith(
                                    color: Color(0xFFABABAF), fontSize: 14)),
                            Text("10-11-2020, 13:10",
                                style: AppTypo.latoBold.copyWith(
                                  fontSize: 14,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
