import 'package:flutter/material.dart';

import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;

class ContentDetailHeader extends StatelessWidget {
  const ContentDetailHeader({
    Key key,
    @required this.item,
    @required this.isEvent,
  }) : super(key: key);

  final dynamic item;
  final bool isEvent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            item.judul,
            style: AppTypo.subtitle1.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.start,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              "Online",
              style: AppTypo.body2.copyWith(color: AppColor.textSecondary2, fontSize: 10),
              textAlign: TextAlign.start,
            ),
            SizedBox(width: 3),
            Text(
              "-",
              style: AppTypo.body2.copyWith(color: AppColor.textSecondary2, fontSize: 10),
              textAlign: TextAlign.start,
            ),
            SizedBox(width: 3),
            Text(
              "Gratis",
              style: AppTypo.body2.copyWith(color: AppColor.textSecondary2, fontSize: 10),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              isEvent
                  ? "${AppExt.convertDateToStringFormatId(DateTime.parse(item.tanggal))}"
                  : "${AppExt.convertDateToStringDayName(DateTime.parse(item.createdAt))}, ${AppExt.convertDateToStringFormatId(DateTime.parse(item.createdAt))}",
              style: AppTypo.body2.copyWith(color: AppColor.textSecondary2, fontSize: 10),
              textAlign: TextAlign.start,
            ),
            SizedBox(width: 3),
            Text(
              isEvent
                ? "${item.waktuMulai} WIB"
                : "${AppExt.getTimeOfDate(item.createdAt)} WIB",
              style: AppTypo.body2.copyWith(color: AppColor.textSecondary2, fontSize: 10),
              textAlign: TextAlign.start,
            )
          ],
        ),
      ],
    );
  }
}