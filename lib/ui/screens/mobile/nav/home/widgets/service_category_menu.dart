import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/subcategory.dart';
import 'package:marketplace/ui/screens/mobile/credentials/sign_in_screen.dart';
import 'package:marketplace/ui/widgets/bs_option_menu.dart';
import 'package:marketplace/ui/widgets/build_menu_item.dart';
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/extensions.dart' as AppExt;

import '../../../../../widgets/alert_dialog.dart';

class ServiceCategoryMenu extends StatelessWidget {
  const ServiceCategoryMenu({
    Key key,
    @required this.isElevation,
    this.categorySub,
  }) : super(key: key);

  final bool isElevation;
  final CategorySub categorySub;

  @override
  Widget build(BuildContext context) {
    final userData = BlocProvider.of<UserDataCubit>(context).state.user;
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GridView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisExtent: 95, maxCrossAxisExtent: 109),
        children: [
          BuildMenuItem().menuItem(
            context,
            elevation: isElevation,
            icon: AppImg.ic_layanan_umkm,
            label: "Layanan\nUMKM",
            onTap: () => BottomSheetMenuOption.umkmService(context,
                title: "Layanan UMKM"),
          ),
          BuildMenuItem().menuItem(
            context,
            elevation: isElevation,
            icon: AppImg.ic_syariah_corner,
            label: "Syariah\nCorner",
            onTap: () => BottomSheetMenuOption.syariahCorner(context,
                title: "Layanan Syariah Corner"),
          ),
          BuildMenuItem().menuItem(
            context,
            elevation: isElevation,
            icon: AppImg.ic_pinjaman,
            label: "Pinjaman\nModal",
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
          /*BuildMenuItem().menuItem(
            context,
            elevation: isElevation,
            icon: AppImg.ic_indibiz,
            label: "${categorySub.name}",
            onTap: () => BottomSheetMenuOption.communityService(
              context,
              title: "${categorySub.name}",
              categories: categorySub,
            ),
          ),*/
          BuildMenuItem().menuItem(
            context,
            elevation: isElevation,
            icon: AppImg.ic_tagihan,
            label: "Top Up & Tagihan",
            onTap: () => BottomSheetMenuOption.topupBill(context,
                title: "Layanan Top Up & Tagihan"),
          ),
        ],
      ),
    );
  }
}
