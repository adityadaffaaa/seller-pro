import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:marketplace/ui/screens/mobile/view_all/agendas/detail_agenda_screen.dart';
import 'package:marketplace/ui/widgets/basic_card.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;

class ViewAllAgendaScreen extends StatelessWidget {
  const ViewAllAgendaScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screnHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 10,
        leading: IconButton(
          onPressed: () => AppExt.popScreen(context),
          icon: Icon(
            AntDesign.arrowleft,
            color: AppColor.black,
          ),
        ),
        title: Text(
          "Agenda Kegiatan",
          style: AppTypo.latoBold.copyWith(
            color: AppColor.black,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                InkWell(
                  onTap: () => AppExt.pushScreen(context, DetailAgendaScreen()),
                  child: BasicCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Image.asset(
                            AppImg.img_agenda_1,
                            height: 88,
                            width: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: screnHeight * (10 / 100),
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "UMKM Go Online: Trik Jitu Jualan Laris Manis di Marketplace",
                                    style: AppTypo.latoSmallSemiBold.copyWith(
                                      color: AppColor.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "16.00 - 17.00 WIB",
                                    style: AppTypo.latoSmall.copyWith(
                                      fontSize: 10,
                                      color: AppColor.gray,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "31 Jan 2023",
                                    style: AppTypo.latoSmall.copyWith(
                                      fontSize: 10,
                                      color: AppColor.gray,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
