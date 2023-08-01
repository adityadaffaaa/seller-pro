import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class HorizontalProductList extends StatelessWidget {
  final String section;
  final List<Products> products;
  final Function() viewAll;
  final bool isBumdes;
  final int warungPhoneNumber;

  const HorizontalProductList(
      {Key key,
      @required this.section,
      // @required this.products,
      this.products,
      @required this.viewAll,
      this.isBumdes = false,
      this.warungPhoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;

    final isUser = BlocProvider.of<UserDataCubit>(context).state.user != null
        ? BlocProvider.of<UserDataCubit>(context).state.user
        : null;

    final bool isUpgradeUser =
        BlocProvider.of<UserDataCubit>(context).state.user != null &&
                BlocProvider.of<UserDataCubit>(context).state.user.reseller !=
                    null ||
            BlocProvider.of<UserDataCubit>(context).state.user != null &&
                BlocProvider.of<UserDataCubit>(context).state.user.supplier !=
                    null;

    final bool isReseller = isUser != null ? isUser.reseller != null : false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kIsWeb ? 15 : _screenWidth * (5 / 100), vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                section,
                style: AppTypo.LatoBold.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              viewAll != null
                  ? Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: viewAll,
                        borderRadius: BorderRadius.circular(5),
                        child: Text(
                          "Lihat Semua",
                          textAlign: TextAlign.right,
                          style: AppTypo.LatoBold.copyWith(
                              color: AppColor.success,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
        // SizedBox(height: 5),
        Container(
          height: isReseller
              ? 365
              : isUpgradeUser
                  ? 365
                  : kIsWeb
                      ? 335
                      : 325,
          // isUpgradeUser && isBumdes
          //     ? 400
          //     :
          // isUpgradeUser && isHasReseller
          //     ? 362
          //     : isUpgradeUser
          //         ? 320
          //         : 300,
          // isBumdes
          //     ? 340
          //     : 310,
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (ctx, idx) => SizedBox(
              width: 10,
            ),
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              bottom: 5,
              left: kIsWeb ? 15 : _screenWidth * (5 / 100),
              right: kIsWeb ? 15 : _screenWidth * (5 / 100),
            ),
            itemCount: products.length < 8 ? products.length : 8,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              Products _item = products[index];
              return Container(
                width: 156,
                child: ProductListItem(
                  // product: _item,
                  // isKomisi: _item.commission != 0 && _item.commission != null,
                  // isDiscount: _item.disc > 0,
                  // isBumdes: isBumdes,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
