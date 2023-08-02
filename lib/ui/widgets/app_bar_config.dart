import 'package:flutter/foundation.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/ui/screens/mobile/cart_screen/cart_screen.dart';
import 'package:marketplace/ui/screens/mobile/screens.dart';
import 'package:marketplace/ui/screens/mobile/search/search_screen.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class AppBarConfig extends StatelessWidget implements PreferredSizeWidget {
  AppBarConfig(
      {Key key,
      this.bgColor,
      this.iconColor,
      this.logoColor,
      this.haveNotificationMenu = true})
      : super(key: key);

  final Color bgColor, iconColor, logoColor;
  final bool haveNotificationMenu;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: iconColor ?? Colors.white),
      backgroundColor: bgColor ?? AppColor.primary,
      elevation: 0.0,
      centerTitle: false,
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 11, top: 4, left: 10, right: 10),
        child: kIsWeb
            ? Image.asset(AppImg.img_seller_pro, width: 28, height: 28)
            : Image.asset(
                AppImg.img_seller_pro,
                fit: BoxFit.contain,
                width: 30,
                height: 30,
                // color: logoColor ?? Colors.white,
              ),
      ),
      titleSpacing: 0,
      title: Container(
        height: 50,
        child: EditText(
          hintText: "Cari produk",
          inputType: InputType.search,
          fillColor: Color(0xFFF4F4F4),
          readOnly: true,
          onTap: () => AppExt.pushScreen(context, SearchScreen()),
        ),
      ),
      actions: [
        haveNotificationMenu
            ? Stack(
                children: [
                  IconButton(
                      padding: EdgeInsets.only(left: 5, top: 10, right: 12),
                      constraints: BoxConstraints(),
                      icon: Icon(EvaIcons.bell, size: 26),
                      splashRadius: 2,
                      onPressed: () {
                        // AppExt.pushScreen(
                        //   context,
                        //   BlocProvider.of<UserDataCubit>(context).state.user != null
                        //       ? CartScreen()
                        //       : SignInScreen(),
                        // );
                      }),
                  /* BlocProvider.of<UserDataCubit>(context).state.countCart != null &&
                    BlocProvider.of<UserDataCubit>(context).state.countCart > 0
                ? new Positioned(
                    right: 10,
                    top: -10,
                    child: Chip(
                      shape: CircleBorder(side: BorderSide.none),
                      backgroundColor: AppColor.red,
                      padding: EdgeInsets.zero,
                      labelPadding: BlocProvider.of<UserDataCubit>(context)
                                  .state
                                  .countCart >
                              99
                          ? EdgeInsets.all(2)
                          : EdgeInsets.all(4),
                      label: Text(
                        "${BlocProvider.of<UserDataCubit>(context).state.countCart}",
                        style: AppTypo.overlineInv.copyWith(fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : SizedBox.shrink(), */
                ],
              )
            : SizedBox(),
        Stack(
          children: [
            IconButton(
                padding: EdgeInsets.only(top: 10, right: 10),
                constraints: BoxConstraints(),
                icon: Icon(EvaIcons.shoppingCart, size: 26),
                onPressed: () {
                  AppExt.pushScreen(
                    context,
                    BlocProvider.of<UserDataCubit>(context).state.user != null
                        ? CartScreen()
                        : SignInScreen(),
                  );
                }),
            BlocProvider.of<UserDataCubit>(context).state.countCart != null &&
                    BlocProvider.of<UserDataCubit>(context).state.countCart > 0
                ? new Positioned(
                    right: kIsWeb ? 8 : -10,
                    top: kIsWeb ? -5 : -8,
                    child: Chip(
                      shape: CircleBorder(side: BorderSide.none),
                      backgroundColor: AppColor.red,
                      padding: EdgeInsets.zero,
                      labelPadding: BlocProvider.of<UserDataCubit>(context)
                                  .state
                                  .countCart >
                              99
                          ? EdgeInsets.all(2)
                          : EdgeInsets.all(4),
                      label: Text(
                        "",
                        // "${BlocProvider.of<UserDataCubit>(context).state.countCart}",
                        style: AppTypo.overlineInv.copyWith(fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
