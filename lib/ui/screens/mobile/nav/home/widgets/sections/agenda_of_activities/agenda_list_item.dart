import 'package:beamer/beamer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as app_img;
import 'package:marketplace/utils/typography.dart' as app_typo;
import 'package:marketplace/utils/extensions.dart' as app_ext;

class AgendaListItem extends StatelessWidget {
  const AgendaListItem({
    Key key,
    this.agenda,
    @required this.onTap,
  }) : super(key: key);

  final agenda;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;

    // TODO: implement build
    return InkWell(
      onTap: onTap,
      // () {

      //   // !kIsWeb
      //       ? app_ext.pushScreen(
      //           context, ArticleDetailScreen(articleId: ekomadArticle.id))
      //       : context.beamToNamed('/articledetail/${ekomadArticle.id}');
      // },
      child: cardContent(context, _screenHeight),
    );
  }

  Align cardContent(BuildContext context, double screenHeight) {
    // final DateTime _parsedDate = DateTime.parse(agenda.createdAt);

    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        elevation: 0.0,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Container(
          height: 236,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                  color: AppColor.black.withOpacity(0.08),
                  blurRadius: 5,
                  offset: Offset(0, 6)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      child: Image.asset(
                        agenda.image,
                        height: 136,
                        fit: BoxFit.cover,
                      ),
                      // CachedNetworkImage(
                      //   width: double.infinity,
                      //   height: 136,
                      //   fit: BoxFit.cover,
                      //   imageUrl: agenda.image ??
                      //       "https://end.ekomad.id/images/blank.png",
                      //   memCacheHeight: Get.height > 350
                      //       ? (Get.height * 0.25).toInt()
                      //       : Get.height,
                      //   placeholder: (context, url) => Shimmer.fromColors(
                      //     baseColor: Colors.grey[300],
                      //     highlightColor: Colors.grey[200],
                      //     period: Duration(milliseconds: 1000),
                      //     child: Container(
                      //       width: double.infinity,
                      //       height: 80,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.only(
                      //               topLeft: Radius.circular(5),
                      //               topRight: Radius.circular(5)),
                      //           color: AppColor.white),
                      //     ),
                      //   ),
                      //   errorWidget: (context, url, error) => Image.asset(
                      //     app_img.img_error,
                      //     width: double.infinity,
                      //     height: 115,
                      //     fit: BoxFit.contain,
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          agenda.judul,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: app_typo.caption.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          agenda.time,
                          maxLines: kIsWeb ? null : 1,
                          overflow: TextOverflow.ellipsis,
                          style: app_typo.caption.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: AppColor.gray),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          agenda.date,
                          maxLines: kIsWeb ? null : 1,
                          overflow: TextOverflow.ellipsis,
                          style: app_typo.caption.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: AppColor.gray),
                        ),
                      ),
                    ],
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
