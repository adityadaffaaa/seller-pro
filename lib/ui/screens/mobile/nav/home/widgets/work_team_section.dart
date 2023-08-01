import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:marketplace/utils/typography.dart' as app_typo;
import 'package:marketplace/utils/images.dart' as app_img;
import 'package:marketplace/utils/colors.dart' as AppColor;

class WorkTeamSection extends StatelessWidget {
  WorkTeamSection({Key key}) : super(key: key);
  final scrollController = ScrollController();

  final workTeams = [
    const WorkTeam(
      icon: app_img.ic_tim_kerja,
      count: 50,
      title: "Total Tim Kerja",
    ),
    const WorkTeam(
      icon: app_img.ic_dropshipper,
      count: 10,
      title: "Dropshipper",
    ),
    const WorkTeam(
      icon: app_img.ic_reseller,
      count: 10,
      title: "Reseller",
    ),
    const WorkTeam(
      icon: app_img.ic_agen,
      count: 10,
      title: "Agent",
    ),
    const WorkTeam(
      icon: app_img.ic_distributor,
      count: 10,
      title: "Distributor",
    ),
    const WorkTeam(
      icon: app_img.ic_stokis,
      count: 10,
      title: "Stokis",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * (90 / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tim Kerja",
            style: app_typo.interSmallSemiBold.copyWith(
              color: AppColor.black,
            ),
          ),
          AlignedGridView.count(
            controller: scrollController,
            shrinkWrap: true,
            padding: EdgeInsets.only(
              top: kIsWeb ? 0 : 20,
              left: kIsWeb ? 24 : screenWidth * (1 / 100),
              right: kIsWeb ? 24 : screenWidth * (1 / 100),
            ),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              final workTeam = workTeams[index];
              return CardWorkTeam(
                icon: workTeam.icon,
                count: workTeam.count,
                title: workTeam.title,
              );
            },
          ),
        ],
      ),
    );
  }
}

class CardWorkTeam extends StatelessWidget {
  final String icon;
  final int count;
  final String title;

  const CardWorkTeam({
    Key key,
    @required this.icon,
    @required this.count,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColor.grey.withOpacity(0.45),
            blurRadius: 5,
          ),
        ],
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            icon,
            height: 28,
          ),
          const SizedBox(
            height: 6.0,
          ),
          Text(
            "${count}",
            style: app_typo.interSmallSemiBold.copyWith(
              color: AppColor.black,
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          Text(
            title,
            style: app_typo.interVerySmall.copyWith(
              color: AppColor.grey,
            ),
          )
        ],
      ),
    );
  }
}

class WorkTeam {
  final String icon;
  final int count;
  final String title;

  const WorkTeam({
    @required this.icon,
    @required this.count,
    @required this.title,
  });
}
