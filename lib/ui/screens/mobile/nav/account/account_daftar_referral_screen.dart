import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:marketplace/ui/screens/mobile/nav/account/widget/list_referral_category.dart';
import 'package:marketplace/ui/screens/mobile/search/search_screen.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/utils/responsive_layout.dart';

import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;

import 'package:marketplace/utils/typography.dart' as app_typo;

class AccountDaftarReferralScreen extends StatelessWidget {
  AccountDaftarReferralScreen({Key key}) : super(key: key);

  final referrals = [
    const Referrals(
      avatar: AppImg.img_avatar_1,
      name: "Kristine Watson",
    ),
    const Referrals(
      avatar: AppImg.img_avatar_2,
      name: "Guy Hawkins",
    ),
    const Referrals(
      avatar: AppImg.img_avatar_3,
      name: "Annette Black",
    ),
    const Referrals(
      avatar: AppImg.img_avatar_4,
      name: "Ronald Richards",
    ),
    const Referrals(
      avatar: AppImg.img_avatar_5,
      name: "Ronald Richards",
    ),
    const Referrals(
      avatar: AppImg.img_avatar_6,
      name: "Tasya Kamila",
    ),
    const Referrals(
      avatar: AppImg.img_avatar_7,
      name: "Melinda Lestari",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        centerTitle: true,
        titleSpacing: 10,
        leading: IconButton(
          onPressed: () => null,
          icon: Icon(
            AntDesign.arrowleft,
            color: AppColor.black,
          ),
        ),
        title: Text(
          "Daftar Referral",
          style: app_typo.latoBold.copyWith(
            color: AppColor.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              height: 50,
              alignment: Alignment.center,
              child: EditText(
                hintText: "Cari",
                inputType: InputType.search,
                // searchIconColor: AppColor.grey,
                fillColor: AppColor.editTextField,
                readOnly: true,
                // fillColor: AppColor,
                onTap: () => AppExt.pushScreen(
                  context,
                  const SearchScreen(),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 24.0),
              child: const ListReferralCategory(),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Referral Anda",
                        style: app_typo.poppinsTitle.copyWith(
                          color: AppColor.black,
                        ),
                      ),
                      TextSpan(
                        text: " (45 Orang)",
                        style: app_typo.poppinsSubtitle.copyWith(
                          color: AppColor.grey,
                        ),
                      )
                    ])),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView.builder(
                  itemCount: referrals.length,
                  itemBuilder: (context, index) {
                    final referral = referrals[index];
                    return Container(
                      margin: referrals[index] == referrals.last
                          ? const EdgeInsets.only(bottom: 24)
                          : const EdgeInsets.only(bottom: 0),
                      decoration: BoxDecoration(
                          border: Border(
                              top: const BorderSide(
                                width: 1,
                                color: AppColor.lightGrey,
                              ),
                              bottom: BorderSide(
                                  width: 1,
                                  color: referrals[index] == referrals.last
                                      ? AppColor.lightGrey
                                      : AppColor.transparent)
                              // bottom: BorderSide(width: 1),
                              )),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 14.0),
                        leading: CircleAvatar(
                          child: Image.asset(referral.avatar),
                        ),
                        title: Text(
                          referral.name,
                          style:
                              app_typo.latoBold.copyWith(color: AppColor.black),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "6281234566789",
                              style: app_typo.latoSmall
                                  .copyWith(color: AppColor.textSecondary2),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Surabaya, Jawa Timur",
                              style: app_typo.latoSmall
                                  .copyWith(color: AppColor.orange),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Referrals {
  final String avatar;
  final String name;

  const Referrals({
    this.avatar,
    this.name,
  });
}
