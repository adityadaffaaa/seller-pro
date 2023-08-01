import 'package:flutter/material.dart';

import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class TagItem extends StatelessWidget {
  const TagItem({
    Key key,
    @required this.tag,
  }) : super(key: key);

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: 115,
      decoration: BoxDecoration(
        color: AppColor.grey2,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          tag,
          style: AppTypo.body2Lato.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 10,
              color: AppColor.white),
        ),
      ),
    );
  }
}