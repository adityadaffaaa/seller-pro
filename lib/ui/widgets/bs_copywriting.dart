import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/ui/widgets/border_button.dart';
import 'package:marketplace/ui/widgets/filled_button.dart';

import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class BsCopywriting {
  static Future show(
    BuildContext context, {
    String title,
    String description,
    Function() onCopy,
    Function() onShare,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
  }) async {
    double screenWidth = MediaQuery.of(context).size.width;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (BuildContext bc) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  title,
                  style: AppTypo.latoRegularSemiBold.copyWith(
                    color: AppColor.black,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  description,
                  style: AppTypo.latoRegular.copyWith(
                    color: AppColor.black,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: BorderButton(
                        height: 45,
                        onPressed: () => onCopy,
                        color: AppColor.primary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              EvaIcons.copyOutline,
                              color: AppColor.primary,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Copy",
                              style: AppTypo.caption
                                  .copyWith(color: AppColor.primary),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: FilledButton(
                        onPressed: () => onShare,
                        height: 45,
                        color: AppColor.primary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              EvaIcons.shareOutline,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Share",
                              style: AppTypo.caption
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
