import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/constants.dart' as AppConst;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class AccountProfileHeader extends StatelessWidget {
  AccountProfileHeader({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    // TODO: implement build
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: kIsWeb ? 58 : screenSize.width * (12 / 100),
            backgroundColor: AppColor.navScaffoldBg,
            backgroundImage: user.avatar != null
                ? NetworkImage(
                    "${AppConst.STORAGE_URL}/user/avatar/${user.avatar}")
                : AssetImage(AppImg.img_default_account),
          ),
          SizedBox(height: 10),
          Text(
            "Mohammad Arda",
            // user.name,
            style: AppTypo.subtitle1.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            "088121721261",
            // user.phonenumber,
            style: AppTypo.caption,
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              color: AppColor.member,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text("Stokis",
                style: AppTypo.membership.copyWith(
                  color: AppColor.white,
                )),
          )
        ],
      ),
    );
  }
}
