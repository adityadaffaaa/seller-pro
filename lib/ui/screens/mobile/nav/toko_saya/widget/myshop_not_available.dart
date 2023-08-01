import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/ui/screens/mobile/join_user/join_user_screen.dart';
import 'package:marketplace/ui/screens/mobile/screens.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;

class MyShopNotAvailable extends StatelessWidget {
  const MyShopNotAvailable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _screenWidth * (8 / 100)),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImg.img_open_shop,
                  width: _screenWidth * (70 / 100),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Text("Toko Anda Belum Tersedia",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: AppTypo.LatoBold.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary)),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Bergabunglah menjadi reseller kami untuk membuka toko dan raih penghasilan tambahan hingga jutaan rupiah",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style:
                              AppTypo.body2Lato.copyWith(color: AppColor.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                RoundedButton.contained(
                    label: "Gabung Reseller",
                    isUpperCase: false,
                    textColor: AppColor.textPrimaryInverted,
                    onPressed: () {
                      if (BlocProvider.of<UserDataCubit>(context).state.user !=
                          null) {
                        if (kIsWeb) {
                          context.beamToNamed('/joinreseller');
                        } else {
                          BlocProvider.of<BottomNavCubit>(context)
                              .navItemTapped(3);
                          AppExt.pushScreen(
                              context,
                              JoinUserScreen(
                                userType: UserType.reseller,
                              ));
                        }
                      } else {
                        if (kIsWeb) {
                          context.beamToNamed('/signin');
                        } else {
                          AppExt.pushScreen(context, SignInScreen());
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
