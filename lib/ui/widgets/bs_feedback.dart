import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/ui/screens/mobile/cart_screen/cart_screen.dart'
    as cart;
import 'package:marketplace/ui/screens/mobile/main_screen.dart';
import 'package:marketplace/ui/widgets/rounded_button.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

import '../screens/mobile/view_all/products/view_all_product_screen.dart';

class BSFeedback {
  const BSFeedback();

  static Future show(BuildContext context,
      {String title,
      String description,
      IconData icon,
      Color color,
      textColor,
      bool isWarung = false,
      bool isDismissible = true,
      bool enableDrag = true,
      bool isWithBackButton = false,
      bool isWeb = false,
      Widget anotherWidget,
      String routeWeb}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    AppExt.hideKeyboard(context);
    await showModalBottomSheet(
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        // constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Icon(
                  icon ?? Icons.check_circle_outline,
                  color: color ?? AppColor.primary,
                  size: 55,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title ?? "",
                  textAlign: TextAlign.center,
                  style:
                      AppTypo.h3.copyWith(color: color ?? AppColor.textPrimary),
                ),
                Text(description ?? "",
                    textAlign: TextAlign.center,
                    style: AppTypo.subtitle2Accent),
                SizedBox(
                  height: 10,
                ),
                anotherWidget ?? SizedBox()
              ],
            ),
          );
        });
    return;
  }

  static Future outOfStock(BuildContext context,
      {String title,
      String description,
      String imgUrl,
      Color color,
      textColor,
      bool isWarung = false,
      bool isDismissible = true,
      bool isWithBackButton = false,
      bool isWeb = false,
      String routeWeb}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    AppExt.hideKeyboard(context);
    await showModalBottomSheet(
        isDismissible: isDismissible,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        imgUrl,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title ?? "",
                      textAlign: TextAlign.center,
                      style: AppTypo.h3
                          .copyWith(color: color ?? AppColor.textPrimary),
                    ),
                    Text(description ?? "",
                        textAlign: TextAlign.center,
                        style: AppTypo.subtitle2Accent),
                    SizedBox(
                      height: 10,
                    ),
                    isWithBackButton == true
                        ? RoundedButton.contained(
                            label: "Kembali",
                            isUpperCase: false,
                            isSmall: true,
                            onPressed: () {
                              isWeb == true
                                  ? context.beamToNamed(routeWeb)
                                  : () {
                                      AppExt.popScreen(context, true);
                                      AppExt.popScreen(context, true);
                                    }();
                            })
                        : SizedBox()
                  ],
                ),
              ],
            ),
          );
        });
    return;
  }

  static Future finpayActivate(BuildContext context,
      {String title,
      String description,
      String imgUrl,
      Color color,
      textColor,
      bool isWeb = false,
      VoidCallback onPressed,
      String routeWeb}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    AppExt.hideKeyboard(context);
    await showModalBottomSheet(
        isDismissible: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        imgUrl,
                        width: 200,
                        height: 150,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      title ?? "",
                      textAlign: TextAlign.center,
                      style: AppTypo.h3
                          .copyWith(color: color ?? AppColor.textPrimary),
                    ),
                    Text(description ?? "",
                        textAlign: TextAlign.center,
                        style: AppTypo.subtitle2Accent),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedButton.contained(
                      label: "Aktifkan Finpay",
                      isUpperCase: false,
                      isSmall: true,
                      onPressed: onPressed,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
    return;
  }

  static Future unselectVariant(BuildContext context,
      {String title,
      String description,
      String imgUrl,
      Color color,
      textColor,
      bool isWarung = false,
      bool isDismissible = true,
      bool isWithBackButton = false,
      bool isWeb = false,
      String routeWeb}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    AppExt.hideKeyboard(context);
    await showModalBottomSheet(
        isDismissible: isDismissible,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        imgUrl,
                        width: 85,
                        height: 85,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title ?? "",
                      textAlign: TextAlign.center,
                      style: AppTypo.h3
                          .copyWith(color: color ?? AppColor.textPrimary),
                    ),
                    Text(description ?? "",
                        textAlign: TextAlign.center,
                        style: AppTypo.subtitle2Accent),
                    SizedBox(
                      height: 10,
                    ),
                    isWithBackButton == true
                        ? RoundedButton.contained(
                            label: "Kembali",
                            isUpperCase: false,
                            isSmall: true,
                            onPressed: () {
                              isWeb == true
                                  ? context.beamToNamed(routeWeb)
                                  : () {
                                      AppExt.popScreen(context, true);
                                      AppExt.popScreen(context, true);
                                    }();
                            })
                        : SizedBox()
                  ],
                ),
              ],
            ),
          );
        });
    return;
  }

  static Future showFeedBackShop(BuildContext context,
      {String title,
      String description,
      IconData icon,
      Color color,
      textColor,
      bool isWarung = false,
      bool isDismissible = true,
      bool isWithBackButton = false,
      bool isWeb = false,
      bool isAddToTokoSaya = false,
      int categoryId,
      String routeWeb}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    AppExt.hideKeyboard(context);
    BottomNavCubit _bottomNavCubit;
    await showModalBottomSheet(
        isDismissible: isDismissible,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    Icon(
                      icon ?? Icons.check_circle_outline,
                      color: color ?? AppColor.primary,
                      size: 55,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title ?? "",
                      textAlign: TextAlign.center,
                      style: AppTypo.h3.copyWith(color: AppColor.textPrimary),
                    ),
                    Text(description ?? "",
                        textAlign: TextAlign.center,
                        style: AppTypo.subtitle2Accent),
                    SizedBox(
                      height: 10,
                    ),
                    isAddToTokoSaya == true
                        ? RoundedButton.contained(
                            label: "Lanjut mencari produk",
                            isUpperCase: false,
                            isSmall: true,
                            onPressed: () {
                              AppExt.pushScreen(
                                  context,
                                  ViewAllProductScreen(
                                      categoryId: categoryId,
                                      isRecomProduct: true));
                            })
                        : RoundedButton.contained(
                            label: "Lihat keranjang",
                            isUpperCase: false,
                            isSmall: true,
                            textColor: Colors.white,
                            onPressed: () {
                              if (kIsWeb) {
                                context.beamToNamed('/wpp/cart');
                                // context.beamToNamed('/cart'); => DIAKTIFKAN UNTUK WEBSITE GENERAL BUKAN TOKO RESELLER
                              } else {
                                AppExt.pushScreen(context, cart.CartScreen());
                              }
                            }),
                    SizedBox(
                      height: 10,
                    ),
                    isAddToTokoSaya == true
                        ? RoundedButton.outlined(
                            label: "Lihat daftar produk",
                            isUpperCase: false,
                            isSmall: true,
                            onPressed: () {
                              if (kIsWeb) {
                                AppExt.pushScreen(context, MainScreen());
                                BlocProvider.of<BottomNavCubit>(context)
                                    .navItemTapped(1);
                              } else {
                                AppExt.popUntilRoot(context);
                                BlocProvider.of<BottomNavCubit>(context)
                                    .navItemTapped(1);
                              }
                            })
                        : RoundedButton.outlined(
                            label: "Lanjut belanja",
                            isUpperCase: false,
                            isSmall: true,
                            onPressed: () {
                              if (isWeb) {
                                context.beamToNamed(routeWeb);
                              } else {
                                AppExt.pushScreen(
                                    context,
                                    ViewAllProductScreen(
                                        categoryId: categoryId,
                                        isRecomProduct: true));
                              }
                            }),
                  ],
                ),
              ],
            ),
          );
        });
    return;
  }
}

class BottomSheetFeedbackAddCart {
  const BottomSheetFeedbackAddCart();

  static Future show(BuildContext context,
      {String title,
      String description,
      IconData icon,
      Color color,
      int phonenumber,
      bool isWarung = false,
      String routeCart}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    AppExt.hideKeyboard(context);
    await showModalBottomSheet(
        constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    Icon(
                      icon ?? Icons.check_circle_outline,
                      color: color ?? AppColor.primary,
                      size: 55,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppTypo.h3,
                    ),
                    Text(description,
                        textAlign: TextAlign.center,
                        style: AppTypo.subtitle2Accent),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton.contained(
                        label: "Lihat keranjang",
                        isUpperCase: false,
                        isSmall: true,
                        textColor: Colors.white,
                        onPressed: () {
                          AppExt.popScreen(context);
                          kIsWeb
                              ? context.beamToNamed('/cart')
                              : AppExt.pushScreen(context, cart.CartScreen());
                          // isWarung
                          //     ? WpCartScreen(phone: phonenumber)
                          //     : newScreen.CartScreen());
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedButton.outlined(
                        label: "Lanjut belanja",
                        isUpperCase: false,
                        isSmall: true,
                        onPressed: () {
                          AppExt.popScreen(context);
                        }),
                  ],
                ),
              ],
            ),
          );
        });
    return;
  }
}
