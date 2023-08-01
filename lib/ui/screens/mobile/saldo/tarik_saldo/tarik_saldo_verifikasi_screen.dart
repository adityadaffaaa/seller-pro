import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/ui/widgets/filled_button.dart';
import 'package:marketplace/ui/widgets/rounded_button.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:pin_code_fields/pin_code_fields.dart';

import 'tarik_saldo_success_screen.dart';

class TarikSaldoVerifikasiScreen extends StatefulWidget {
  const TarikSaldoVerifikasiScreen({
    Key key,
  }) : super(key: key);

  @override
  _TarikSaldoVerifikasiScreenState createState() =>
      _TarikSaldoVerifikasiScreenState();
}

class _TarikSaldoVerifikasiScreenState
    extends State<TarikSaldoVerifikasiScreen> {
  Timer _timer;

  bool disableButton = true;
  int confirmationCode = 0;
  int _start = 60;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: kIsWeb ? 450 : 1000),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "Tarik Saldo",
              style: AppTypo.subtitle1,
            ),
            elevation: 0,
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
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Kode verifikasi (OTP) dikirim pada WhatsApp anda",
                    style: AppTypo.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  PinCodeTextField(
                    appContext: context,
                    length: 4,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    autoFocus: true,
                    onCompleted: (v) {
                      debugPrint("Completed $v");
                      setState(() {
                        disableButton = false;
                        confirmationCode = int.parse(v);
                      });
                    },
                    onChanged: (String value) {},
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RoundedButton.contained(
                    label: "Lanjut",
                    isUpperCase: false,
                    disabled: disableButton,
                    onPressed: () {},
                    color: AppColor.primary,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {},
                      radius: 20,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Kirim Ulang",
                          style: AppTypo.latoSixteen
                              .copyWith(color: AppColor.primary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
