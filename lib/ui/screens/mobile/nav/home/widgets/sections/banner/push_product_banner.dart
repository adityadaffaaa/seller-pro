import 'package:flutter/material.dart';
import 'package:marketplace/utils/images.dart' as AppImg;

class PushProductBanner extends StatelessWidget {
  const PushProductBanner({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 12, 10, 12),
        child: Image.asset(
          AppImg.push_product_banner,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
