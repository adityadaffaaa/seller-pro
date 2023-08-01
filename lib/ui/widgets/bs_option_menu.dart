import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/ui/widgets/alert_dialog.dart';
import 'package:marketplace/ui/widgets/build_menu_item.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;


class BottomSheetMenuOption {
  const BottomSheetMenuOption();

  static Future umkmService(BuildContext context, {String title}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    AppExt.hideKeyboard(context);
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(13),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: kIsWeb
                    ? _screenWidth * (6 / 100)
                    : _screenWidth * (12 / 100),
                height: 7,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(7.5 / 2),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: AppTypo.LatoBold.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: GridView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 90,
                    mainAxisExtent: 90,
                  ),
                  children: [
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_halal,
                      label: "Sertifikasi Halal",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_bpom,
                      label: "Izin BPOM",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_nib,
                      label: "Nomor Induk Berusaha",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_sppirt,
                      label: "SPP-IRT",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_merk,
                      label: "Pendaftaran Merk",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future syariahCorner(BuildContext context, {String title}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    AppExt.hideKeyboard(context);
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(13),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: kIsWeb
                    ? _screenWidth * (6 / 100)
                    : _screenWidth * (12 / 100),
                height: 7,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(7.5 / 2),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: AppTypo.LatoBold.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: GridView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 90,
                    mainAxisExtent: 90,
                  ),
                  children: [
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_qurban,
                      label: "Qurban",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_fidyah,
                      label: "Fidyah",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_zakat,
                      label: "Zakat",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_wakaf,
                      label: "Wakaf",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_donasi,
                      label: "Donasi",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /*static Future communityService(BuildContext context,
      {String title, CategorySub categories}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    AppExt.hideKeyboard(context);
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(13),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: kIsWeb
                    ? _screenWidth * (6 / 100)
                    : _screenWidth * (12 / 100),
                height: 7,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(7.5 / 2),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: AppTypo.LatoBold.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: GridView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 90,
                    mainAxisExtent: 90,
                  ),
                  children: List.generate(
                    categories.subcategories.length,
                    (index) {
                      return BuildMenuItem().menuItemTelkom(
                        context,
                        elevation: false,
                        icon: categories.subcategories[index].icon,
                        label: categories.subcategories[index].name,
                        onTap: () async {
                          final data = Subcategories(
                            id: categories.subcategories[index].id,
                            name: categories.subcategories[index].name,
                            slug: categories.subcategories[index].slug,
                            icon: categories.subcategories[index].icon,
                          );
                          AppExt.popScreen(context);
                          if (categories.subcategories[index].slug ==
                              "indibiz-pay") {
                            if (BlocProvider.of<UserDataCubit>(context)
                                    .state
                                    .user ==
                                null) {
                              kIsWeb
                                  ? context.beamToNamed('/signin')
                                  : AppExt.pushScreen(
                                      context,
                                      SignInScreen(),
                                    );
                            } else {
                              if (kIsWeb) {
                                context.beamToNamed(
                                    '/telkomproducts?dt=${AppExt.encryptMyData(jsonEncode(data))}');
                              } else {
                                AppExt.pushScreen(
                                    context,
                                    TelkomProducts(
                                        subcategories:
                                            categories.subcategories[index]));
                              }
                            }
                          } else {
                            if (kIsWeb) {
                              context.beamToNamed(
                                  '/telkomproducts?dt=${AppExt.encryptMyData(jsonEncode(data))}');
                            } else {
                              AppExt.pushScreen(
                                  context,
                                  TelkomProducts(
                                      subcategories:
                                          categories.subcategories[index]));
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }*/

  static Future topupBill(BuildContext context, {String title}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    AppExt.hideKeyboard(context);
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(13),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: kIsWeb
                    ? _screenWidth * (6 / 100)
                    : _screenWidth * (12 / 100),
                height: 7,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(7.5 / 2),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: AppTypo.LatoBold.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: GridView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 90,
                    mainAxisExtent: 90,
                  ),
                  children: [
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_pulsa,
                      label: "Pulsa",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_paket_data,
                      label: "Paket Data",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_listrik,
                      label: "Listrik",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_internet,
                      label: "Internet",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                    BuildMenuItem().menuItem(
                      context,
                      elevation: false,
                      icon: AppImg.ic_pdam,
                      label: "PDAM",
                      onTap: () => WarningAlertDialog(
                        context,
                        "Coming Soon",
                        "Nantikan update terbaru dari kami.",
                        "Oke",
                        () {
                          AppExt.popScreen(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
