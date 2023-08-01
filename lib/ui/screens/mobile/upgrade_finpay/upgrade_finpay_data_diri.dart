import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/upgrade_finpay_foto_ktp.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/widgets/label_name.dart';
import 'package:marketplace/ui/screens/mobile/upgrade_finpay/widgets/progress_bar.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:marketplace/ui/widgets/widgets.dart';

class UpgradeFinpayDataDiri extends StatelessWidget {
  const UpgradeFinpayDataDiri({Key key}) : super(key: key);

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
              "Lengkapi detail data diri",
              style: AppTypo.LatoBold,
            ),
          ),
          Divider(
            height: 0,
            thickness: 2.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: LabelName(
                    label: "Email",
                  ),
                ),
                EditText(
                  hintText: "ranniwidyasari@gmail.com",
                  textStyle: AppTypo.body1Lato,
                  readOnly: true,
                  fillColor: AppColor.lightGrey2,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: LabelName(
                    label: "No Whatsapp",
                  ),
                ),
                EditText(
                  hintText: "0896767676767",
                  textStyle: AppTypo.body1Lato,
                  readOnly: true,
                  fillColor: AppColor.lightGrey2,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: LabelName(
                    label: "Kewarganegaraan",
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.silverFlashSale)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pilih Kewarganegaraan",
                          style: AppTypo.body2.copyWith(color: AppColor.grey2)),
                      Icon(
                        FlutterIcons.chevron_down_mco,
                        color: AppColor.editTextIcon,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: LabelName(
                    label: "Nomor KK (Kartu Keluarga)",
                  ),
                ),
                EditText(
                  hintText: "Nomor KK",
                  readOnly: false,
                  keyboardType: TextInputType.number,
                  inputType: InputType.number,
                  textStyle: AppTypo.body2,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: LabelName(
                    label: "Nama Ibu Kandung",
                  ),
                ),
                EditText(
                  hintText: "Nama Ibu Kandung",
                  readOnly: false,
                  textStyle: AppTypo.body2,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
