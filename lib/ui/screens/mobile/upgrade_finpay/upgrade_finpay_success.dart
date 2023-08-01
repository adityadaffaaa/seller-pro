import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/ui/screens/mobile/nav/home/widgets/apps_banner.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/widgets/label_name.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/widgets/progress_bar.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/widgets/upload_foto_frame.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/ui/widgets/widgets.dart';

class UpgradeFinpaySuccess extends StatelessWidget {
  const UpgradeFinpaySuccess({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: kIsWeb ? 425 : 600,
        ),
        child: Scaffold(
          appBar: AppBar(
            shadowColor: AppColor.grey.withOpacity(0.1),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 5.0,
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
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(AppImg.img_upgrade_finpay_success),
                      ),
                      Text(
                        "Upgrade Akun Berhasil",
                        style: AppTypo.LatoBold.copyWith(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Terima kasih telah melakukan upgrade akun Finpay, permintaan anda akan di proses maksimal 2 x 24 jam",
                        style: AppTypo.body1.copyWith(color: AppColor.grey2),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  RoundedButton.contained(
                    label: "Selesai",
                    onPressed: () => AppExt.popUntilRoot(context),
                    isUpperCase: false,
                    color: AppColor.blue2,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
