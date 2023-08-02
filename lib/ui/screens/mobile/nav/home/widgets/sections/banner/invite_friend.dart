import 'package:flutter/material.dart';
import 'package:marketplace/utils/images.dart' as AppImg;

class InviteFriendBanner extends StatelessWidget {
  const InviteFriendBanner({
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
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Image.asset(
          AppImg.invite_banner,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
