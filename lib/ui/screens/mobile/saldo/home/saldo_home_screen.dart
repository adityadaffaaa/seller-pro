import 'package:beamer/beamer.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketplace/ui/screens/mobile/saldo/home/widgets/greenBG.dart';
import 'package:marketplace/ui/screens/mobile/saldo/home/widgets/my_commission_section.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;

import '../../../../../../data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'widgets/saldo_option_section.dart';

class SaldoHomeScreen extends StatefulWidget {
  const SaldoHomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _SaldoHomeScreenState createState() => _SaldoHomeScreenState();
}

class _SaldoHomeScreenState extends State<SaldoHomeScreen> {
  final ScrollController _scrollController = ScrollController();

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
    // TODO: implement build
    Size deviceSize = MediaQuery.of(context).size;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: kIsWeb ? 425 : 600,
        ),
        child: Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            title: Text(
              "Dompet",
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
                // if (kIsWeb) {
                //   AppExt.pushScreen(context, MainScreen());
                //   BlocProvider.of<BottomNavCubit>(context).navItemTapped(0);
                // } else {
                //   AppExt.popScreen(context);
                // }
              },
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Stack(
                    children: const [
                      GreenBG(
                        walletsBalance: "162.000",
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SaldoOptionSection(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                    child: Text(
                      "Komisi Anda",
                      style: AppTypo.subtitle1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: const MyCommissionSection(),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    child: Text("Transaksi Terakhir",
                        style: AppTypo.subtitle1
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: ListView.separated(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: 5,
                      separatorBuilder: (context, _) {
                        return const SizedBox(
                          height: 15,
                          child: Divider(
                            thickness: 1,
                          ),
                        );
                      },
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              "Hasil Penjualan Produk",
                                              style: AppTypo.caption,
                                            ),
                                            Text(
                                              "Transaksi Penjualan Berhasil - INV/20210412/1827182",
                                              style: AppTypo.caption.copyWith(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Ionicons.ios_add,
                                            size: 12,
                                            color: AppColor.textPrimary),
                                        const SizedBox(width: 2),
                                        Text(
                                          "92.500",
                                          style: AppTypo.caption.copyWith(
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
                  InkWell(
                    onTap: () => null,
                    child: Text(
                      "Lihat lainnya",
                      style: AppTypo.latoSmallSemiBold.copyWith(
                        color: AppColor.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
