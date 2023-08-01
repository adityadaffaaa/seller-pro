import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace/ui/screens/mobile/nav/home/widgets/sections/agenda_of_activities/agenda_list_item.dart';
import 'package:marketplace/ui/screens/mobile/view_all/agendas/detail_agenda_screen.dart';
import 'package:marketplace/ui/screens/mobile/view_all/agendas/view_all_agenda_screen.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class AgendaList extends StatelessWidget {
  const AgendaList({
    Key key,
    @required this.section,
    @required this.agendas,
    this.viewAll,
  }) : super(key: key);

  final String section;
  final List agendas;
  final Function() viewAll;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
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
                style: AppTypo.interSmallSemiBold.copyWith(
                  color: AppColor.black,
                ),
              ),
              Material(
                color: AppColor.transparent,
                child: InkWell(
                  onTap: () => ViewAllAgendaScreen(),
                  borderRadius: BorderRadius.circular(6),
                  child: Text(
                    "Lihat Semua",
                    textAlign: TextAlign.right,
                    style: AppTypo.latoBold.copyWith(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 265,
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (ctx, idx) => SizedBox(width: 10),
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              bottom: 5,
              left: kIsWeb ? 15 : _screenWidth * (5 / 100),
              right: kIsWeb ? 15 : _screenWidth * (5 / 100),
            ),
            itemCount: agendas.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final agenda = agendas[index];
              return SizedBox(
                width: 150,
                child: AgendaListItem(
                  agenda: agenda,
                  onTap: () => DetailAgendaScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
