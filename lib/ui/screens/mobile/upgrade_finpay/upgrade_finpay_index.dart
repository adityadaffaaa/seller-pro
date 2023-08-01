import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/upgrade_finpay_success.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/widgets/label_name.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/widgets/progress_bar.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/upgrade_finpay_data_diri.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/upgrade_finpay_foto_ktp.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/upgrade_finpay_selfie.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/widgets/upload_foto_frame.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:marketplace/ui/widgets/widgets.dart';

class UpgradeFinpayIndex extends StatefulWidget {
  const UpgradeFinpayIndex({Key key}) : super(key: key);

  @override
  State<UpgradeFinpayIndex> createState() => _UpgradeFinpayIndexState();
}

class _UpgradeFinpayIndexState extends State<UpgradeFinpayIndex> {
  int index;

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

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
              onPressed: () => {
                if (index > 0 && index < 3)
                  {
                    setState(() {
                      index--;
                    })
                  }
                else
                  {
                    AppExt.popScreen(context),
                  }
              },
            ),
          ),
          body: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 24.0,
                  ),
                  child: ProgressBar(step: index + 1),
                ),
                index == 1
                    ? UpgradeFinpayFotoKtp()
                    : index == 2
                        ? UpgradeFinpaySelfie()
                        : UpgradeFinpayDataDiri(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 16.0),
                  child: RoundedButton.contained(
                    label: "Selanjutnya",
                    onPressed: () => {
                      if (index < 2)
                        {
                          setState(() {
                            index++;
                          })
                        }
                      else
                        {
                          AppExt.pushScreen(
                            context,
                            UpgradeFinpaySuccess(),
                          ),
                        }
                    },
                    isUpperCase: false,
                    color: AppColor.blue2,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
