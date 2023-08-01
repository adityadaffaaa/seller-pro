import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class ProductCategoryList extends StatelessWidget {
  const ProductCategoryList({Key key, @required this.section})
      : super(key: key);

  final String section;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kIsWeb ? 15 : _screenWidth * (5 / 100)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                section,
                style: AppTypo.LatoBold.copyWith(
                    fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 250,
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (ctx, idx) => SizedBox(width: 10),
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
                bottom: 5,
                left: !context.isPhone ? 18 : _screenWidth * (5 / 100)),
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: 150,

              );
            },
          ),
        ),
      ],
    );
  }
}
