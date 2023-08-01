import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/data/models/new_models/tag_news_activity.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class FilterItem extends StatefulWidget {
  // final bool isActive;
  final String filterItem;
  final Function(int idTags) onTap;
  final int tagsIdSelected;

  const FilterItem({
    Key key,
    @required this.filterItem,
    this.onTap,
    this.tagsIdSelected,
  }) : super(key: key);

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    int idTags = widget.tagsIdSelected;

    return GestureDetector(
            onTap: () {
              // if (idTags != _filterItems.id) {
              //   setState(() {
              //     idTags = _filterItems.id;
              //   });
              //   widget.onTap(_filterItems.id);
              // }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                border: Border.all(color: AppColor.grey2)
              ),
              child: Center(
                  child: Text(
                      "${widget.filterItem}",
                      style: AppTypo.LatoBold.copyWith(
                          fontSize: 16, fontWeight: FontWeight.normal, color: AppColor.grey2),
                    ),
                  ),
                  // idTags == _filterItems.id
                  //     ? Container(
                  //   height: 2,
                  //   width: 58,
                  //   decoration: BoxDecoration(
                  //     color: idTags == _filterItems.id
                  //         ? AppColor.appPrimary
                  //         : AppColor.transparent,
                  //     borderRadius: BorderRadius.circular(5),
                  //   ),
                  // )
                  //     : SizedBox(),
                  // SizedBox(
                  //   height: idTags == _filterItems.id ? 3 : 0,
                  // ),
              ),
            );
  }
}
