import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/ui/widgets/rounded_button.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/colors.dart' as AppColor;

class TarikSaldoDetailScreen extends StatefulWidget {
  const TarikSaldoDetailScreen({
    Key key,
  }) : super(key: key);

  @override
  _TarikSaldoDetailScreenState createState() => _TarikSaldoDetailScreenState();
}

class _TarikSaldoDetailScreenState extends State<TarikSaldoDetailScreen> {
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
    return Center(
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kIsWeb
                            ? _screenWidth * (3 / 100)
                            : _screenWidth * (5 / 100),
                        vertical: 20),
                    child: Column(
                      children: [
                        Text("20.000,-",
                            style: AppTypo.latoBold.copyWith(
                              fontSize: 18,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Saldo yang di tarik",
                          style: AppTypo.body2Lato
                              .copyWith(color: Color(0xFFABABAF), fontSize: 14),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nama",
                                style: AppTypo.body2Lato
                                    .copyWith(color: AppColor.inactiveSwitch),
                              ),
                              Text("Text",
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
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bank",
                                style: AppTypo.body2Lato
                                    .copyWith(color: AppColor.inactiveSwitch),
                              ),
                              Text("Nama",
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
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "No. Rekening",
                                style: AppTypo.body2Lato
                                    .copyWith(color: AppColor.inactiveSwitch),
                              ),
                              Text("12345678910",
                                  style: AppTypo.latoBold.copyWith(
                                    fontSize: 14,
                                  ))
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        RoundedButton.contained(
                            label: "Tarik",
                            isUpperCase: false,
                            onPressed: () {})
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
