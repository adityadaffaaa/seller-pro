import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/ui/screens/mobile/saldo/home/saldo_home_screen.dart';

import 'package:marketplace/ui/widgets/rounded_button.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/colors.dart' as AppColor;

import '../../main_screen.dart';

class TarikSaldoSuccessScreen extends StatelessWidget {
  const TarikSaldoSuccessScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () {
          AppExt.popUntilRoot(context);
          AppExt.pushScreen(context, SaldoHomeScreen());
          return;
        },
        child: Center(
            child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: kIsWeb ? 450 : 1000),
          child: Scaffold(
            body: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      textTheme: TextTheme(headline6: AppTypo.subtitle1),
                      iconTheme: IconThemeData(color: Colors.black),
                      backgroundColor: Colors.white,
                      centerTitle: true,
                      forceElevated: false,
                      pinned: true,
                      shadowColor: Colors.black54,
                      floating: true,
                      leading: IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: kIsWeb
                            ? () {
                                context.beamToReplacementNamed('/');
                              }
                            : () {
                                AppExt.pushAndRemoveScreen(context,
                                    pageRef: MainScreen());
                              },
                      ),
                      title: Text(
                        "Tarik Saldo",
                        style: AppTypo.subtitle1,
                      ),
                      brightness: Brightness.dark,
                    ),
                  ];
                },
                body: SingleChildScrollView(
                    physics: new BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kIsWeb
                                  ? _screenWidth * (2 / 100)
                                  : _screenWidth * (5 / 100)),
                          child: Column(
                            children: [
                              Image.asset(
                                AppImg.img_payment_success,
                                width: kIsWeb ? 200 : _screenWidth * (48 / 100),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                "Penarikanmu sedang diproses, harap tunggu maks. 2 hari kerja",
                                textAlign: TextAlign.center,
                                style: AppTypo.latoBold.copyWith(
                                    color: AppColor.primary, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kIsWeb
                                  ? _screenWidth * (2 / 100)
                                  : _screenWidth * (5 / 100),
                              vertical: 20),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Nama",
                                        style: AppTypo.body2Lato.copyWith(
                                            color: Color(0xFFABABAF),
                                            fontSize: 12)),
                                    Text("Alexander",
                                        style: AppTypo.latoBold.copyWith(
                                          fontSize: 12,
                                        ))
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Bank",
                                        style: AppTypo.body2Lato.copyWith(
                                            color: Color(0xFFABABAF),
                                            fontSize: 12)),
                                    Text("BNI",
                                        style: AppTypo.latoBold.copyWith(
                                          fontSize: 12,
                                        ))
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("No. Rekening",
                                        style: AppTypo.body2Lato.copyWith(
                                            color: Color(0xFFABABAF),
                                            fontSize: 12)),
                                    Text("12345678910",
                                        style: AppTypo.latoBold.copyWith(
                                          fontSize: 12,
                                        ))
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Penarikan",
                                        style: AppTypo.body2Lato.copyWith(
                                            color: Color(0xFFABABAF),
                                            fontSize: 12)),
                                    Text("Rp 23.000",
                                        style: AppTypo.latoBold.copyWith(
                                          fontSize: 12,
                                        ))
                                  ],
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                height: 30,
                              ),
                              RoundedButton.outlined(
                                  label: "Lihat Dompet",
                                  isUpperCase: false,
                                  onPressed: () {
                                    // AppExt.popUntilRoot(context);
                                    // AppExt.pushScreen(context, SaldoHomeScreen(user:userDataCubit.state.user));
                                    AppExt.pushScreen(
                                        context, SaldoHomeScreen());
                                    BlocProvider.of<BottomNavCubit>(context)
                                        .navItemTapped(1);
                                  }),
                              SizedBox(
                                height: 12,
                              ),
                              RoundedButton.contained(
                                  label: "Kembali ke homepage",
                                  isUpperCase: false,
                                  onPressed: () {
                                    context.beamToReplacementNamed('/');
                                    AppExt.pushScreen(context, MainScreen());
                                    BlocProvider.of<BottomNavCubit>(context)
                                        .navItemTapped(0);
                                  })
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        )));
    // Scaffold(
    //   backgroundColor: Color(0xFFF7F7F7),
    //   appBar: AppBar(
    //     backgroundColor: Colors.white,
    //     centerTitle: true,
    //     title: Text(
    //       "Tarik Saldo",
    //       style: AppTypo.subtitle2,
    //     ),
    //     elevation: 0,
    //     leading: IconButton(
    //       icon: Icon(Icons.arrow_back, color: Colors.black,),
    //       onPressed: (){
    //         AppExt.popScreen(context);
    //       },
    //     ),
    //   ),
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       padding: EdgeInsets.symmetric(horizontal: 16),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Card(
    //             elevation: 1,
    //             child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Align(
    //                     alignment: Alignment.center,
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         Icon(Icons.check_circle_outline, size: 60, color: Colors.green,),
    //                         SizedBox(
    //                           height: 16,
    //                         ),
    //                         Text("Pencairan Saldo Berhasil", style: AppTypo.subtitle1.copyWith(color: Colors.green),)
    //                       ],
    //                     ),
    //                   ),
    //                   SizedBox(height: 16,),
    //                   Align(
    //                     alignment: Alignment.center,
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         Text("Rp 25.000,-", style: AppTypo.subtitle2.copyWith(fontWeight: FontWeight.bold),),
    //                         SizedBox(height: 8,),
    //                         Text("10-11-2020", style: AppTypo.caption.copyWith(color: Colors.grey),),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 32,),
    //           Card(
    //             elevation: 1,
    //             child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text("Nama", style: AppTypo.caption.copyWith(color: Colors.grey),),
    //                       Text("Alexander", style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.right,),
    //                     ],
    //                   ),
    //                   Divider(thickness: 1,),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text("Bank", style: AppTypo.caption.copyWith(color: Colors.grey),),
    //                       Text("BNI", style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.right,),
    //                     ],
    //                   ),
    //                   Divider(thickness: 1,),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text("No Rekening", style: AppTypo.caption.copyWith(color: Colors.grey),),
    //                       Text("31801803713781", style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.right,),
    //                     ],
    //                   ),
    //                   Divider(thickness: 1,),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text("Keterangan", style: AppTypo.caption.copyWith(color: Colors.grey),),
    //                       Text("-", style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.right,),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
