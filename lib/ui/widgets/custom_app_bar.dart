import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/colors.dart' as AppColor;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key key,
    @required this.title,
    this.useBackButton = true,
    this.withFilter = false,
    this.withShare = false,
    this.implyLeading = false,
    this.elevation,
    this.bottom,
    this.web,
    this.mobile,
  }) : super(key: key);

  final String title;
  final bool withFilter;
  final bool useBackButton;
  final bool withShare;
  final bool implyLeading;
  final double elevation;
  final PreferredSizeWidget bottom;
  final void Function() web;
  final void Function() mobile;

  Size get preferredSize => Size(double.infinity, 56);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      automaticallyImplyLeading: implyLeading,
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: elevation ?? 0,
      shadowColor: Colors.grey,
      title: Text(
        title,
        style: AppTypo.subtitle2,
      ),
      actions: [
        withFilter
            ? Padding(
                padding: EdgeInsets.only(right: 5),
                child: IconButton(
                  splashRadius: 20,
                  onPressed: () {},
                  icon: Icon(
                    Icons.filter_list_outlined,
                    color: Colors.black,
                  ),
                ),
              )
            : withShare
                ? Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: IconButton(
                      splashRadius: 20,
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
                        color: Colors.black,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
      ],
      leading: kIsWeb && useBackButton
          ? MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: web,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColor.black,
                ),
              ),
            )
          : useBackButton ? IconButton(
              splashRadius: 20,
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.black,
              ),
              onPressed: mobile,
            ) : SizedBox(),
      bottom: bottom,
    );
  }
}
