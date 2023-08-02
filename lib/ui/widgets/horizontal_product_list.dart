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
  // final List products;
  final Function() viewAll;
  final bool isBumdes;
  final int warungPhoneNumber;

  const HorizontalProductList(
      {Key key,
      @required this.section,
      // @required this.products,
      @required this.viewAll,
      this.isBumdes = false,
      this.warungPhoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;

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
                style: AppTypo.latoBold.copyWith(
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
                          style: AppTypo.latoBold.copyWith(
                              color: AppColor.primary,
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
          height: 325,
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
            separatorBuilder: (ctx, idx) => const SizedBox(
              width: 10,
            ),
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              bottom: 5,
              left: kIsWeb ? 15 : _screenWidth * (5 / 100),
              right: kIsWeb ? 15 : _screenWidth * (5 / 100),
            ),
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              // return const Text("Halo");
              // Products _item = products[index];
              return SizedBox(
                width: 156,
                child: ProductListItem(),
              );
            },
          ),
        ),
      ],
    );
  }
}
