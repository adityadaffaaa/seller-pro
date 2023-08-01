import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketplace/data/models/new_models/home_category.dart';
import 'package:marketplace/ui/screens/mobile/product_by_category/product_by_category_screen.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/constants.dart' as AppConst;

class CategoryList extends StatelessWidget {
  const CategoryList(
      {Key key, @required this.section, @required this.categoryList})
      : super(key: key);

  final String section;
  final List<HomeCategory> categoryList;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kIsWeb ? 15 : _screenWidth * (5 / 100), vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                section,
                style: AppTypo.LatoBold.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          height: 95,
          color: AppColor.white,
          padding: EdgeInsets.zero,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding:
                EdgeInsets.only(left: kIsWeb ? 8 : _screenWidth * (2 / 100)),
            separatorBuilder: (ctx, idx) => SizedBox(width: 10),
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return buildMenuItem(
                context,
                "${categoryList[index].icon}",
                categoryList[index].order,
                "${categoryList[index].name}",
                () => kIsWeb
                    ? context.beamToNamed(
                        '/productcategory/${categoryList[index].id}')
                    : AppExt.pushScreen(
                        context,
                        ProductByCategoryScreen(
                            categoryId: categoryList[index].id)),
              );
            },
          ),
        ),
      ],
    );
  }

  Material buildMenuItem(BuildContext context, String icon, int order,
      String label, VoidCallback onTap,
      [int flex = 1]) {
    return Material(
      color: AppColor.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Column(
            children: [
              if (order != 0)
                Image.network(
                  icon,
                  height: 35,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    } else {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: frame != null
                            ? child
                            : Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                              ),
                      );
                    }
                  },
                )
              else
                SvgPicture.asset(
                  AppImg.ic_allcategory,
                  height: 35,
                  placeholderBuilder: (context) => Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              SizedBox(
                height: 7.5,
              ),
              FittedBox(
                child: Container(
                  width: 62,
                  child: RichText(
                    maxLines: kIsWeb ? null : 2,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: label,
                      style: AppTypo.overline.copyWith(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
