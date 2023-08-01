import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:marketplace/ui/widgets/filled_button.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class DetailAgendaScreen extends StatelessWidget {
  const DetailAgendaScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 10,
        leading: IconButton(
          onPressed: () => null,
          icon: const Icon(
            AntDesign.arrowleft,
            color: AppColor.black,
          ),
        ),
        title: Text(
          "Detail Agenda",
          style: AppTypo.latoBold.copyWith(
            color: AppColor.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Image.asset(
                AppImg.img_agenda_1,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "UMKM Go Online: Trik Jitu Jualan Laris Manis di Marketplace",
                      style: AppTypo.latoRegularSemiBold.copyWith(
                        color: AppColor.black,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Online - Gratis",
                      style: AppTypo.latoSmall.copyWith(
                        color: AppColor.gray,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Selasa, 31 Januari 2023, 16.00 - 17.00 WIB",
                      style: AppTypo.latoSmall.copyWith(
                        color: AppColor.gray,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet consectetur. Viverra maecenas mi sit viverra id nunc faucibus in turpis. Sollicitudin sit netus platea leo consequat facilisis sit. Imperdiet lobortis tristique sagittis odio montes a. Luctus cras eu euismod sit semper metus bibendum eget. Pulvinar quam et nibh at tellus felis luctus eget. Arcu nulla at et scelerisque senectus sit urna odio. Eget cum quam pretium bibendum a dapibus lorem aliquam. Auctor vitae et mus adipiscing fames adipiscing vitae fringilla. ",
                      style: AppTypo.latoSmallSemiBold.copyWith(
                        color: AppColor.textSecondary3,
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Tagar :",
                      style: AppTypo.latoSmallSemiBold.copyWith(
                        color: AppColor.textSecondary3,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.bgBadgeSilver,
                          ),
                          child: Text(
                            "webinar",
                            style: AppTypo.latoSmallSemiBold
                                .copyWith(color: AppColor.white),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.bgBadgeSilver,
                          ),
                          child: Text(
                            "marketplace",
                            style: AppTypo.latoSmallSemiBold
                                .copyWith(color: AppColor.white),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.bgBadgeSilver,
                          ),
                          child: Text(
                            "marketing ",
                            style: AppTypo.latoSmallSemiBold
                                .copyWith(color: AppColor.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 38,
                    ),
                    SizedBox(
                      width: screenWidth,
                      child: FilledButton(
                        rounded: 5,
                        color: AppColor.blue2,
                        child: Text(
                          "Daftar Sekarang",
                          style: AppTypo.interVerySmall.copyWith(
                            color: AppColor.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () => null,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
