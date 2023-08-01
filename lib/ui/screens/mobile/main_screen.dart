import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/ui/screens/mobile/nav/account/account_screen.dart';
import 'package:marketplace/ui/screens/mobile/nav/home/home_nav.dart';
import 'package:marketplace/ui/screens/mobile/nav/product/product_screen.dart';
import 'package:marketplace/ui/screens/mobile/nav/toko_saya/toko_saya_screen.dart';
import 'package:marketplace/ui/screens/mobile/screens.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/responsive_layout.dart';
import 'package:marketplace/utils/transitions.dart' as AppTrans;
import 'package:marketplace/utils/typography.dart' as AppTypo;

import '../mobile/nav/transaksi/transaksi_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldRootKey =
      new GlobalKey<ScaffoldState>();

  int recipentId = 0;
  int recipentIdFromGs;

  BottomNavCubit _bottomNavCubit;
  DateTime currentBackPressTime;

  Recipent recipentMainAddress;

  @override
  void initState() {
    super.initState();
    _bottomNavCubit = BlocProvider.of<BottomNavCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Scaffold(
        key: _scaffoldRootKey,
        body: BlocBuilder(
          bloc: _bottomNavCubit,
          builder: (context, state) => AppTrans.SharedAxisTransitionSwitcher(
            transitionType: SharedAxisTransitionType.vertical,
            fillColor: AppColor.navScaffoldBg,
            child: state is BottomNavHomeLoaded
                ? HomeNav()
                : state is BottomNavProductLoaded
                    ? BlocProvider.of<UserDataCubit>(context).state.user != null
                        // ? TransactionNav()
                        ? ProductScreen()
                        : SignInScreen(isFromRoot: true)
                    : state is BottomNavTransactionLoaded
                        ? BlocProvider.of<UserDataCubit>(context).state.user !=
                                null
                            // ? TransactionNav()
                            ? TransaksiScreen()
                            : SignInScreen(isFromRoot: true)
                        : state is BottomNavAccountLoaded
                            ? BlocProvider.of<UserDataCubit>(context)
                                        .state
                                        .user !=
                                    null
                                ? AccountScreen()
                                : SignInScreen(isFromRoot: true)
                            : SizedBox.shrink(),
          ),
        ),
        bottomNavigationBar:
            //  !context.isPhone
            //     ? null
            //     :
            BlocBuilder<BottomNavCubit, BottomNavState>(
          bloc: _bottomNavCubit,
          builder: (context, state) => Theme(
            data: ThemeData(
              splashFactory: InkRipple.splashFactory,
              splashColor: AppColor.primaryDark.withOpacity(0.07),
              highlightColor: AppColor.success.withOpacity(0.07),
            ),
            child: BottomNavigationBar(
              backgroundColor: AppColor.bottomNavBg,
              selectedItemColor: AppColor.primary,
              unselectedItemColor: AppColor.bottomNavIconInactive,
              selectedFontSize: 13,
              unselectedFontSize: 13,
              selectedLabelStyle:
                  AppTypo.overline.copyWith(fontWeight: FontWeight.w700),
              unselectedLabelStyle:
                  AppTypo.overline.copyWith(fontWeight: FontWeight.w700),
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              onTap: (index) => _bottomNavCubit.navItemTapped(index),
              currentIndex: _bottomNavCubit.currentIndex,
              items: _bottomNavCubit.navItem
                  .map(
                    (e) => BottomNavigationBarItem(
                      icon: e.icon,
                      activeIcon: e.activeIcon,
                      label: e.label,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
