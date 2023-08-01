import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class SelectedRecipent extends StatelessWidget {
  const SelectedRecipent({
    Key key,
    @required this.section,
    @required this.onPressed,
  }) : super(key: key);

  final String section;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kIsWeb ? 15 : screenWidth * (5 / 100), vertical: kIsWeb ? 10 : 0.5),
      child: Row(
        children: [
          Icon(
            EvaIcons.pinOutline,
            color: Colors.black54,
            size: 18,
          ),
          SizedBox(width: 5),
          Text(
            "Domisili Anda ",
            style: AppTypo.caption,
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 160),
            child: Text(
              section,
              style: AppTypo.caption.copyWith(
                  color: AppColor.primary, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          IconButton(
            icon: Icon(EvaIcons.chevronDownOutline),
            splashRadius: 12,
            color: Colors.black38,
            iconSize: 20,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
