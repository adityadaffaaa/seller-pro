import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/upgrade_finpay_success.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/widgets/label_name.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/widgets/progress_bar.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/widgets/upload_foto_frame.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/ui/widgets/widgets.dart';

class UpgradeFinpaySelfie extends StatelessWidget {
  const UpgradeFinpaySelfie({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: Text(
              "Foto Selfie Bersama Kartu Identitas Penduduk (KTP)",
              style: AppTypo.LatoBold,
            ),
          ),
          Divider(
            height: 0,
            thickness: 2.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 14.0,
            ),
            child: Image(
              image: AssetImage(AppImg.img_selfie),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Text("1",
                          style: AppTypo.LatoBold.copyWith(
                            color: AppColor.white,
                          )),
                      radius: 16.0,
                      backgroundColor: AppColor.blue2,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Foto dan data KTP terbaca dengan jelas",
                      style: AppTypo.body2Lato.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 14,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Text("2",
                          style: AppTypo.LatoBold.copyWith(
                            color: AppColor.white,
                          )),
                      radius: 16.0,
                      backgroundColor: AppColor.blue2,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "KTP masih aktif atau berlaku",
                      style: AppTypo.body2Lato.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 14,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Text("3",
                          style: AppTypo.LatoBold.copyWith(
                            color: AppColor.white,
                          )),
                      radius: 16.0,
                      backgroundColor: AppColor.blue2,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "KTP milik anda sendiri",
                      style: AppTypo.body2Lato.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Divider(
              height: 0,
              thickness: 2.0,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelName(label: "Upload Foto Identitas"),
              SizedBox(
                height: 10.0,
              ),
              UploadFotoFrame(
                width: double.infinity,
                height: 160.0,
                radius: 5.0,
                hintText: "Upload Foto selfie dengan KTP",
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                "foto selfie dengan KTP wajib diisi",
                style: AppTypo.caption.copyWith(color: AppColor.blue2),
              )
            ],
          )
        ],
      ),
    );
  }
}
