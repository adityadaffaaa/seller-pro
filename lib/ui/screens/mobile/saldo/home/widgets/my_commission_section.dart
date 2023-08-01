import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:marketplace/ui/widgets/basic_card.dart';
import 'package:marketplace/ui/widgets/bs_confirmation.dart';
import 'package:marketplace/ui/widgets/bs_feedback.dart';
import 'package:marketplace/ui/widgets/bs_kategori.dart';
import 'package:marketplace/ui/widgets/bs_komisi.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/colors.dart' as AppColor;

class MyCommissionSection extends StatelessWidget {
  const MyCommissionSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.silverFlashSale)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("18 Jun 2023 - 17 Jul 2023",
                  style: AppTypo.body2.copyWith(color: AppColor.gray)),
              const Icon(
                FlutterIcons.chevron_down_mco,
                color: AppColor.editTextIcon,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () => BsKomisi.show(context,
              title: "Referral",
              description:
                  "Komisi referral adalah komisi yang anda dapatkan ketika ada member baru yang bergabung menggunakan kode referral anda."),
          child: BasicCard(
            hasShadow: false,
            color: AppColor.bgBadgePurple,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  AppImg.ic_komisi_referral,
                  height: 32,
                  width: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Komisi Referral",
                        style: AppTypo.interVerySmall
                            .copyWith(color: AppColor.gray),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "0",
                        style: AppTypo.interSmallSemiBold.copyWith(
                          color: AppColor.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: () => BsKomisi.show(context,
              title: "Penjualan",
              description:
                  "Komisi penjualan adalah komisi yang anda dapatkan dari hasil penjualan anda."),
          child: BasicCard(
            hasShadow: false,
            color: AppColor.bgBadgeBlue2,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  AppImg.ic_komisi_penjualan,
                  height: 32,
                  width: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Komisi Penjualan",
                        style: AppTypo.interVerySmall
                            .copyWith(color: AppColor.gray),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "0",
                        style: AppTypo.interSmallSemiBold.copyWith(
                          color: AppColor.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: () => BsKomisi.show(
            context,
            title: "Pass Up",
            description:
                "Komisi pass up adalah komisi yang anda dapatkan ketika ada member yang membeli produk dari referral anda.",
          ),
          child: BasicCard(
            hasShadow: false,
            color: AppColor.bgBadgeOrange,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  AppImg.ic_komisi_pass_up,
                  height: 32,
                  width: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Komisi Pass Up",
                        style: AppTypo.interVerySmall
                            .copyWith(color: AppColor.gray),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "0",
                        style: AppTypo.interSmallSemiBold.copyWith(
                          color: AppColor.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
