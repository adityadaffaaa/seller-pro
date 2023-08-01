import 'package:flutter/material.dart';
import 'filter_item.dart';

class ContentFilterList extends StatelessWidget {
  const ContentFilterList({
    Key key,
    @required this.filterItems
  }) : super(key: key);

  final List<String> filterItems;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for(var item in filterItems) FilterItem(filterItem: item)
        ],
      )
    );
    // return ListView.separated(
    //   shrinkWrap: true,
    //   separatorBuilder: (ctx, idx) => SizedBox(width: 6),
    //   physics: BouncingScrollPhysics(),
    //   scrollDirection: Axis.horizontal,
    //   itemCount: filterItems.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return FilterItem(filterItem: filterItems[index]);
    //   },
    // );
  }
}