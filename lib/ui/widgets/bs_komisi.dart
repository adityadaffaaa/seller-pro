import 'package:flutter/material.dart';
import 'package:marketplace/ui/widgets/basic_card.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;

class BsKomisi {
  static Future show(
    BuildContext context, {
    String title,
    String description,
    bool isDismissible = true,
    bool enableDrag = true,
  }) async {
    double screenWidth = MediaQuery.of(context).size.width;
    await showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (BuildContext bc) {
        return Padding(
          padding: const EdgeInsets.all(15),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Komisi $title",
                      style: AppTypo.subtitle1
                          .copyWith(fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () {
                      AppExt.popScreen(context);
                    },
                    icon: Icon(
                      Icons.close,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                description,
                style: AppTypo.latoRegular.copyWith(
                  color: AppColor.black,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
