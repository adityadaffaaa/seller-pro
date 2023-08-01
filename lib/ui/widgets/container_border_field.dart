import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:flutter/material.dart';

class ContainerBorderField extends StatelessWidget {
  const ContainerBorderField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              border: Border.all(
                  style: BorderStyle.solid,
                  color: AppColor.silverFlashSale,
                  width: 1),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: AppTypo.caption,
                  children: [
                    TextSpan(
                      text: 'Username : ',
                    ),
                    TextSpan(
                        text: ' ',
                        style: AppTypo.captionAccent.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColor.primary)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.copy,
                  color: AppColor.primary,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(
                  style: BorderStyle.solid,
                  color: AppColor.silverFlashSale,
                  width: 1),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: AppTypo.caption,
                  children: [
                    TextSpan(
                      text: 'Password : ',
                    ),
                    TextSpan(
                        text: ' ',
                        style: AppTypo.captionAccent.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColor.primary)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.copy,
                  color: AppColor.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
