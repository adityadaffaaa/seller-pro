import 'package:flutter/material.dart';
import 'package:marketplace/ui/widgets/basic_card.dart';
import 'package:marketplace/ui/widgets/bs_share_link_referral.dart';
import 'package:marketplace/utils/typography.dart' as app_typo;
import 'package:marketplace/utils/images.dart' as app_img;
import 'package:marketplace/utils/colors.dart' as AppColor;

class InviteFriendsSection extends StatelessWidget {
  const InviteFriendsSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BasicCard(
      width: screenWidth * (90 / 100),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 84.0,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      app_img.img_bg_invite_friends,
                    ),
                    fit: BoxFit.cover)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: screenWidth * (90 / 100),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 5, 14, 0),
              child: Row(
                children: [
                  Image.asset(
                    app_img.img_mobile_marketing,
                    height: 80.0,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ajak teman gabung ke seller pro dan dapatkan komisi nya",
                          style: app_typo.interSmall.copyWith(
                            color: AppColor.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () => BsShareLinkReferral.show(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                "Undang Teman",
                                style: app_typo.interSmall.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
