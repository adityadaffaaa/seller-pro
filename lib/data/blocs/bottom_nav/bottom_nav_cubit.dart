import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketplace/ui/widgets/a_app_config.dart';
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/colors.dart' as AppColor;

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());

  int currentIndex = 0;

  void appLoaded() {
    navItemTapped(currentIndex);
  }

  void navItemTapped(int index) {
    // if (state is BottomNavTransactionLoaded && this.currentIndex == index) {
    //   fetchTransactionsResellerCubit..load();
    //   fetchTransactionsCubit..load();
    // }
    this.currentIndex = index;
    emit(BottomNavLoading());

    BottomNavItem currentItem = navItem[this.currentIndex];

    emit(currentItem.state);
  }

  List<BottomNavItem> get navItem {
    return [
      BottomNavItem(
        icon: SvgPicture.asset(AppImg.ic_homemenu),
        activeIcon: SvgPicture.asset(
          AppImg.ic_homeactive,
          color: AppColor.appPrimary,
        ),
        label: "Home",
        state: BottomNavHomeLoaded(),
      ),
      BottomNavItem(
        icon: SvgPicture.asset(AppImg.ic_product_menu),
        activeIcon: kIsWeb
            ? SvgPicture.asset(
                AppImg.ic_product_menu_active,
                color: AppColor.primary,
              )
            : SvgPicture.asset(
                AppImg.ic_product_menu_active,
                color: AppColor.primary,
              ),
        label: "Produk",
        state: BottomNavProductLoaded(),
      ),
      BottomNavItem(
        icon: SvgPicture.asset(AppImg.ic_transactionmenu),
        activeIcon: kIsWeb
            ? SvgPicture.asset(
                AppImg.ic_transactionactive_web,
                color: AppColor.appPrimary,
              )
            : SvgPicture.asset(
                AppImg.ic_transactionactive,
              ),
        label: "Transaksi",
        state: BottomNavTransactionLoaded(),
      ),
      BottomNavItem(
        icon: SvgPicture.asset(AppImg.ic_profilemenu),
        activeIcon: kIsWeb
            ? SvgPicture.asset(
                AppImg.ic_profileactive_web,
                color: AppColor.appPrimary,
              )
            : SvgPicture.asset(
                AppImg.ic_profileactive,
              ),
        label: "Akun",
        state: BottomNavAccountLoaded(),
      ),
    ];
  }
}

class BottomNavItem {
  BottomNavItem({
    @required this.icon,
    @required this.activeIcon,
    @required this.label,
    @required this.state,
    this.onTaped,
  });

  final Widget icon;
  final Widget activeIcon;
  final String label;
  final BottomNavState state;
  final VoidCallback onTaped;
}
