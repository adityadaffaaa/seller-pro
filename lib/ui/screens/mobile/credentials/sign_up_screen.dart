import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beamer/beamer.dart';
import 'package:marketplace/data/blocs/sign_up/sign_up_bloc.dart';
import 'package:marketplace/ui/screens/mobile/credentials/widgets/privacy_terms.dart';
import 'package:marketplace/ui/screens/mobile/screens.dart';
import 'package:marketplace/ui/widgets/a_app_config.dart';

import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/responsive_layout.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/colors.dart' as AppColor;

class SignUpScreen extends StatefulWidget {
  final bool isFromRoot;

  const SignUpScreen({Key key, this.isFromRoot = false}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpBloc _signUpBloc;

  TextEditingController _nameController, _phoneNumberController;
  bool _isButtonEnabled;
  bool _isChecked;

  @override
  void initState() {
    _signUpBloc = SignUpBloc();

    _nameController = TextEditingController(text: "");
    _phoneNumberController = TextEditingController(text: "");
    _isButtonEnabled = false;
    _isChecked = false;

    _nameController.addListener(_checkEmpty);
    _phoneNumberController.addListener(_checkEmpty);

    super.initState();
    _checkEmpty();
  }

  void _checkEmpty() {
    if (_nameController.text.trim().isEmpty ||
        _phoneNumberController.text.trim().isEmpty ||
        _phoneNumberController.text.trim().length < 9) {
      setState(() {
        _isButtonEnabled = false;
      });
    } else
      setState(() {
        _isButtonEnabled = true;
      });
  }

  void _handleSubmit() {
    AppExt.hideKeyboard(context);

    _signUpBloc.add(SignUpButtonPressed(
      name: _nameController.text,
      phoneNumber: _phoneNumberController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final config = AAppConfig.of(context);
    double _screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => _signUpBloc,
      child: GestureDetector(
        onTap: () => AppExt.hideKeyboard(context),
        child: ResponsiveLayout(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              brightness: Brightness.light,
              iconTheme: IconThemeData(color: AppColor.black),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
            body: BlocListener<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  AppExt.pushScreen(
                      context,
                      OtpScreen(
                        phoneNumber: state.phoneNumber,
                        otpTimeout: state.otpTimeOut,
                        isFromRoot: widget.isFromRoot,
                        isSignUp: true,
                      ));
                } else if (state is SignUpFailure) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${state.error}'),
                      duration: Duration(seconds: 2),
                      backgroundColor: AppColor.danger,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kIsWeb ? 15 : _screenWidth * (8 / 100)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: kIsWeb ? 15 : _screenWidth * (5 / 100),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            AppImg.img_logo_ekomad,
                            width: kIsWeb ? 200 : _screenWidth * (48 / 100),
                          ),
                        ),
                        SizedBox(
                          height: kIsWeb ? 16 : _screenWidth * (4 / 100),
                        ),
                        Text(
                          "Buat Akun",
                          style: AppTypo.h1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Dapatkan lebih banyak pelanggan tetap dengan bergabung bersama ekosistem kami.",
                          style: AppTypo.captionAccent
                              .copyWith(color: Color(0xFF777C7E)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        EditText(
                          keyboardType: TextInputType.name,
                          hintText: "Nama",
                          controller: _nameController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        EditText(
                          keyboardType: TextInputType.phone,
                          hintText: "Nomor WhatsApp",
                          inputType: InputType.phone,
                          controller: this._phoneNumberController,
                          inputFormatter: [
                            FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        /* IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Kode Refferal",
                                        hintStyle: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                            color: AppColor.inactiveSwitch),
                                        isDense: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: AppColor.silverFlashSale,
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: AppColor.silverFlashSale,
                                              width: 1),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.primary,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text("Gunakan",
                                        style: AppTypo.body1.copyWith(
                                            color: Colors.white, fontSize: 13)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ), */
                        const SizedBox(
                          height: 20,
                        ),
                        CheckboxListTile(
                          value: _isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              _isChecked = value;
                            });
                          },
                          contentPadding: EdgeInsets.symmetric(
                              horizontal:
                                  kIsWeb ? 8 : _screenWidth * (0.2 / 100)),
                          controlAffinity: ListTileControlAffinity.leading,
                          title: PrivacyTerms(
                            lauchUrl: () => kIsWeb
                                ? AppExt.toWebUrl(
                                    context, "https://admasolusi.com/privacy")
                                : AppExt.pushScreen(
                                    context,
                                    WebviewAdmaPrivacyScreen(
                                        link: "https://admasolusi.com/privacy"),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) => RoundedButton.contained(
                            label: "Buat Akun",
                            onPressed: _isChecked == true
                                ? _isButtonEnabled
                                    ? () => _handleSubmit()
                                    : null
                                : null,
                            isLoading: state is SignUpLoading,
                          ),
                        ),
                        SizedBox(
                          height: kIsWeb ? 10 : _screenWidth * (10 / 100),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sudah mempunyai akun? ",
                              style: AppTypo.caption,
                            ),
                            GestureDetector(
                              onTap: () => kIsWeb
                                  ? context.beamToNamed('/signin')
                                  : AppExt.popScreen(context),
                              child: Text(
                                " Masuk",
                                style: AppTypo.caption.copyWith(
                                  color: AppColor.success,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _screenWidth * (5 / 100),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _signUpBloc.close();
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
