import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketplace/data/models/user.dart';
import 'package:marketplace/ui/screens/mobile/nav/account/account_upgrade_member_screen.dart';
import 'package:marketplace/ui/screens/mobile/saldo/home/saldo_home_screen.dart';
import 'package:marketplace/ui/widgets/alert_dialog.dart';
import 'package:marketplace/ui/widgets/bs_share_link_referral.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/extensions.dart' as AppExt;

class AccountInfoItem extends StatelessWidget {
  AccountInfoItem({Key key, @required this.user}) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
                style: BorderStyle.solid,
                color: AppColor.silverFlashSale,
                width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  highlightColor: AppColor.transparent,
                  onTap: () {
                    AppExt.pushScreen(context, SaldoHomeScreen());
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        AppImg.ic_dompet,
                        width: 22,
                        height: 22,
                        color: AppColor.primary,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text("Saldo Dompet",
                          style: AppTypo.body2Lato
                              .copyWith(fontSize: 11, color: AppColor.grey)),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        user.walletBalance ?? 'Rp. 0',
                        style: AppTypo.LatoBold.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  highlightColor: AppColor.transparent,
                  onTap: () => null,
                  // WarningAlertDialog(
                  //   context,
                  //   "Coming Soon",
                  //   "Nantikan update terbaru dari kami.",
                  //   "Oke",
                  //   () {
                  //     AppExt.popScreen(context);
                  //   },
                  // ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                            width: 1, color: AppColor.silverFlashSale),
                        left: BorderSide(
                            width: 1, color: AppColor.silverFlashSale),
                      ),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          AppImg.ic_coin,
                          width: 22,
                          height: 22,
                          color: AppColor.primary,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text("Koin",
                            style: AppTypo.body2Lato
                                .copyWith(fontSize: 11, color: AppColor.grey)),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "0",
                          style: AppTypo.LatoBold.copyWith(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  highlightColor: AppColor.transparent,
                  onTap: () => null,
                  // WarningAlertDialog(
                  //   context,
                  //   "Coming Soon",
                  //   "Nantikan update terbaru dari kami.",
                  //   "Oke",
                  //   () {
                  //     AppExt.popScreen(context);
                  //   },
                  // ),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        AppImg.ic_voucher,
                        width: 22,
                        height: 22,
                        color: AppColor.primary,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text("Voucher",
                          style: AppTypo.body2Lato
                              .copyWith(fontSize: 11, color: AppColor.grey)),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "0",
                        style: AppTypo.LatoBold.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: AppColor.silverFlashSale,
                      width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () => null,
                  child: Row(
                    children: [
                      Expanded(
                        child: CircleAvatar(
                          backgroundColor: AppColor.tertiary,
                          radius: 18,
                          child: SvgPicture.asset(
                            AppImg.ic_round_list,
                            height: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Daftar Referral",
                          style: AppTypo.body1Lato.copyWith(
                            color: AppColor.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: AppColor.silverFlashSale,
                      width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () =>
                      AppExt.pushScreen(context, AccountUpgradeMemberScreen()),
                  child: Row(
                    children: [
                      Expanded(
                        child: CircleAvatar(
                          backgroundColor: AppColor.tertiary,
                          radius: 18,
                          child: SvgPicture.asset(
                            AppImg.ic_upgrade_account,
                            height: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Upgrade Akun",
                          style: AppTypo.body1Lato.copyWith(
                            color: AppColor.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          decoration: BoxDecoration(
            border: Border.all(
                style: BorderStyle.solid,
                color: AppColor.silverFlashSale,
                width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            onTap: () => BsShareLinkReferral.show(context),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor.tertiary,
                        radius: 22,
                        child: SvgPicture.asset(
                          AppImg.ic_new_member,
                          height: 28,
                        ),
                      ),
                      Text(
                        "Ajak Member Baru",
                        style: AppTypo.body1Lato.copyWith(
                          color: AppColor.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 16,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                            width: 1, color: AppColor.silverFlashSale),
                        left: BorderSide(
                            width: 1, color: AppColor.silverFlashSale),
                      ),
                    ),
                    child: Text("Ajak member baru dan dapatkan bonus",
                        style: AppTypo.body2Lato),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
