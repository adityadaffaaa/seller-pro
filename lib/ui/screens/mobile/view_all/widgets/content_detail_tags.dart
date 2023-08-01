import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/ui/screens/mobile/view_all/widgets/tag_item.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class ContentDetailTags extends StatelessWidget {
  const ContentDetailTags({
    Key key,
    @required this.articleTags,
  }) : super(key: key);

  final List<String> articleTags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: Text(
            "Tagar :",
            style: AppTypo.body2Lato.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColor.textSecondary3,
            ),
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          runSpacing: 6,
          spacing: 6,
          children: [
            for(var tag in articleTags) TagItem(tag: tag)
          ]
        )
        // MasonryGridView.count(
        //   crossAxisCount: 6,
        //   mainAxisSpacing: 6,
        //   crossAxisSpacing: 6,
        //   shrinkWrap: true,
        //   itemCount: articleTags.length,
        //   itemBuilder: (context, index) {
        //     return Container(
        //       padding: EdgeInsets.all(8),
        //       width: 120,
        //       decoration: BoxDecoration(
        //         color: AppColor.grey2,
        //         borderRadius: BorderRadius.all(Radius.circular(20)),
        //       ),
        //       child: Center(
        //         child: Text(
        //           index != null
        //               ? articleTags[index]
        //               : null,
        //           style: AppTypo.body2Lato.copyWith(fontWeight: FontWeight.w600, fontSize: 10, color: AppColor.white),
        //         ),
        //       ),
        //     );
        //   },
        // )
      ],
    );
  }
}