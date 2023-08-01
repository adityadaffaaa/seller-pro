import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class PrivacyTerms extends StatelessWidget {
  const PrivacyTerms({
    Key key,
    @required this.lauchUrl,
  }) : super(key: key);

  final Function() lauchUrl;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: AppTypo.captionAccent,
        children: [
          TextSpan(
            text: 'Dengan membuat akun berarti anda setuju dengan ',
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = lauchUrl,
            text: 'syarat dan ketentuan',
            style: AppTypo.captionAccent
                .copyWith(fontWeight: FontWeight.w700, color: AppColor.success),
          ),
          TextSpan(
            text: ' dan ',
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = lauchUrl,
            text: 'kebijakan privasi',
            style: AppTypo.captionAccent
                .copyWith(fontWeight: FontWeight.w700, color: AppColor.success),
          ),
        ],
      ),
    );
  }
}
