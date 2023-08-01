import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;

class DetailTransaksiKomisiScreen extends StatefulWidget {
  const DetailTransaksiKomisiScreen({
    Key key,
  }) : super(key: key);

  @override
  State<DetailTransaksiKomisiScreen> createState() =>
      _DetailTransaksiKomisiScreenState();
}

class _DetailTransaksiKomisiScreenState
    extends State<DetailTransaksiKomisiScreen> {
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
              horizontal: _screenWidth * (5 / 100), vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
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
                            "+ 162.500",
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
                height: 16,
              ),
              Material(
                elevation: 2,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: _screenWidth * (5 / 100), vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rincian Transaksi",
                        style: AppTypo.subtitle1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              AppImg.img_opak,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                            // Image.network(
                            //   "",
                            //   width: 70,
                            //   height: 70,
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Opak asli oded"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Rp.18.500,-",
                                  style: AppTypo.caption.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "25-10-2020, 13:08",
                                  style: AppTypo.body2Lato.copyWith(
                                    color: AppColor.textSecondary2,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Terjual",
                        style: AppTypo.subtitle1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Text(
                            "32x",
                            style: AppTypo.caption.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 5,
                            child: Text("Opak Oded Asli"),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Rp 92.500",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Komisi",
                        style: AppTypo.subtitle1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Text(
                            "5x",
                            style: AppTypo.caption.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 5,
                            child: Text('5.000/ pcs'),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Rp 25.000",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
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
