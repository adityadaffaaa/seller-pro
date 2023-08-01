import 'package:flutter/material.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/typography.dart' as AppTypo;

import 'content_detail_tags.dart';

class ContentDetailBody extends StatelessWidget {
  const ContentDetailBody({
    Key key,
    @required this.description,
    @required this.articleTags,
  }) : super(key: key);

  final String description;
  final List<String> articleTags;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            description,
            style: AppTypo.body2Lato.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.textSecondary3,
                height: 2
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 24),
        ContentDetailTags(articleTags: articleTags),
      ],
    );
  }
}