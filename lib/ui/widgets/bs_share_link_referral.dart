import 'package:flutter/material.dart';
import 'package:marketplace/ui/widgets/basic_card.dart';
import 'package:marketplace/utils/typography.dart' as app_typo;
import 'package:marketplace/utils/extensions.dart' as app_ext;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as app_img;

class BsShareLinkReferral {
  static Future show(
    BuildContext context, {
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
                  Text("Bagikan Link Referral",
                      style: app_typo.subtitle1
                          .copyWith(fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () {
                      app_ext.popScreen(context);
                    },
                    icon: Icon(
                      Icons.close,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColor.bgBadgeGreen,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColor.bgTextGreen),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: AppColor.bgTextGreen,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        "Ajak member baru dan dapatkan bonus",
                        style: app_typo.latoRegular.copyWith(
                          color: AppColor.textSecondary3,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => null,
                    child: Column(
                      children: [
                        Image.asset(
                          app_img.ic_facebook,
                          height: 40,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Facebook",
                          style: app_typo.interVerySmall.copyWith(
                            color: AppColor.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => null,
                    child: Column(
                      children: [
                        Image.asset(
                          app_img.ic_whatsapp,
                          height: 40,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Whatsapp",
                          style: app_typo.interVerySmall.copyWith(
                            color: AppColor.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => null,
                    child: Column(
                      children: [
                        Image.asset(
                          app_img.ic_telegram,
                          height: 40,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Telegram",
                          style: app_typo.interVerySmall.copyWith(
                            color: AppColor.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => null,
                    child: Column(
                      children: [
                        Image.asset(
                          app_img.ic_copylink,
                          height: 40,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Salin Link",
                          style: app_typo.interVerySmall.copyWith(
                            color: AppColor.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
