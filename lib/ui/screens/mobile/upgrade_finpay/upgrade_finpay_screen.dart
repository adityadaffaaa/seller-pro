import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/upgrade_finpay_data_diri.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/upgrade_finpay_index.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/ui/widgets/widgets.dart';

// import 'package:marketplace/ui/screens/mobile/nav/home/widgets/apps_banner.dart';

class UpgradeFinpayScreen extends StatelessWidget {
  const UpgradeFinpayScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: kIsWeb ? 425 : 600,
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            title: Text(
              "Upgrade Premium",
              style: AppTypo.subtitle2,
            ),
            actions: [],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => AppExt.popScreen(context),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Image(
                  width: double.infinity,
                  image: AssetImage(AppImg.upgrade_finpay_banner),
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Upgrade Finpay Premium dengan mudah",
                              style: AppTypo.LatoBold,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 14.0,
                            ),
                            Divider(
                              height: 0,
                              thickness: 2.0,
                              color: AppColor.lightGrey,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                              // decoration: BoxDecoration(color: Colors.red),
                              child: Column(
                                children: [
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(16, 0, 16, 12),
                                    visualDensity:
                                        VisualDensity.adaptivePlatformDensity,
                                    title: Text("Lengkapi detail data diri",
                                        style: AppTypo.body2Lato.copyWith(
                                            fontWeight: FontWeight.w500)),
                                    leading: Image.asset(
                                      AppImg.ic_data_diri,
                                      height: 40.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Divider(
                                      height: 0,
                                      thickness: 2.0,
                                      color: AppColor.lightGrey3,
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(16, 12, 16, 12),
                                    visualDensity:
                                        VisualDensity.adaptivePlatformDensity,
                                    title: Text("Unggah foto identitas\n(KTP)",
                                        style: AppTypo.body2Lato.copyWith(
                                            fontWeight: FontWeight.w500)),
                                    leading: Image.asset(
                                      AppImg.ic_ktp,
                                      height: 40.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Divider(
                                      height: 0,
                                      thickness: 2.0,
                                      color: AppColor.lightGrey3,
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(16, 12, 16, 12),
                                    visualDensity:
                                        VisualDensity.adaptivePlatformDensity,
                                    title: Text(
                                        "Unggah selfie memegang identitas\n(KTP)",
                                        style: AppTypo.body2Lato.copyWith(
                                            fontWeight: FontWeight.w500)),
                                    leading: Image.asset(
                                      AppImg.ic_selfie,
                                      height: 40.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Divider(
                                      height: 0,
                                      thickness: 2.0,
                                      color: AppColor.lightGrey3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        RoundedButton.contained(
                          label: "Upgrade Sekarang",
                          onPressed: () =>
                              AppExt.pushScreen(context, UpgradeFinpayIndex()),
                          isUpperCase: false,
                          color: AppColor.blue2,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
