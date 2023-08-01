import 'dart:developer';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/transitions.dart' as AppTrans;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/constants.dart' as AppConst;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:shimmer/shimmer.dart';

class ListBankItem extends StatefulWidget {
  const ListBankItem({
    Key key,
  }) : super(key: key);

  @override
  _ListBankItemState createState() => _ListBankItemState();
}

class _ListBankItemState extends State<ListBankItem> {
  int _selectedOpt = -1;

  final banks = [
    const Bank(
      icon: AppImg.ic_bni,
      label: "Bank BNI",
      information: "Dicek Manual (Max 2x24 jam)",
      handlingFee: 500,
    ),
    const Bank(
      icon: AppImg.ic_bri,
      label: "Bank BRI",
      information: "Dicek Manual (Max 2x24 jam)",
      handlingFee: 500,
    ),
    const Bank(
      icon: AppImg.ic_mandiri,
      label: "Bank Mandiri",
      information: "Dicek Manual (Max 2x24 jam)",
      handlingFee: 500,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return ListView.separated(
        key: Key("loaded_otp"),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final bank = banks[index];
          log('image: ');
          return _buildOption(
            _screenWidth,
            bank.label,
            bank.icon,
            bank.information,
            bank.handlingFee,
            _selectedOpt == index,
            () {
              setState(() {
                _selectedOpt = index;
              });
            },
            context,
          );
        },
        separatorBuilder: (context, id) => SizedBox(
              height: 15,
            ),
        itemCount: banks.length);
  }

  Widget _buildOption(
      double _screenWidth,
      String label,
      String imageUrl,
      String information,
      int handlingFee,
      bool selected,
      VoidCallback onTap,
      BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        // borderRadius: BorderRadius.circular(7.5),
        // splashColor: AppColor.primaryLight1.withOpacity(0.3),
        // highlightColor: AppColor.primaryLight2.withOpacity(0.3),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(kIsWeb ? 15 : _screenWidth * (4.5 / 100)),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.line, width: 1),
            borderRadius: BorderRadius.circular(7.5),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: kIsWeb
                    ? Image(
                        image: NetworkImage(
                          imageUrl,
                          // "https://picsum.photos/200",
                        ),
                        width: 60,
                        height: 56,
                        fit: BoxFit.contain,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Image.asset(
                            "",
                            width: 60,
                            height: 56,
                            fit: BoxFit.contain,
                          );
                        },
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          } else {
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: frame != null
                                  ? child
                                  : Container(
                                      width: 60,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(7.5),
                                        color: Colors.grey[200],
                                      ),
                                    ),
                            );
                          }
                        },
                      )
                    : Image.asset(
                        imageUrl,
                        // memCacheHeight: Get.height > 350
                        //     ? (Get.height * 0.25).toInt()
                        //     : Get.height,
                        width: _screenWidth * (17.5 / 100),
                        height: _screenWidth * (13 / 100),
                        fit: BoxFit.contain,
                        // placeholder: (context, url) => Shimmer.fromColors(
                        //   baseColor: Colors.grey[300],
                        //   highlightColor: Colors.grey[200],
                        //   period: Duration(milliseconds: 1000),
                        //   child: Container(
                        //     width: _screenWidth * (17.5 / 100),
                        //     height: _screenWidth * (13 / 100),
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: Colors.white),
                        //   ),
                        // ),
                        // errorWidget: (context, url, error) => Image.asset(
                        //   AppImg.img_error,
                        //   width: _screenWidth * (17.5 / 100),
                        //   height: _screenWidth * (13 / 100),
                        // ),
                      ),
              ),
              SizedBox(
                width: _screenWidth * (4.5 / 100),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTypo.poppinsSubtitle.copyWith(
                        color: AppColor.black,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      information,
                      style: AppTypo.latoSmall.copyWith(
                        color: AppColor.textSecondary2,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Biaya penanganan: ",
                            style: AppTypo.latoSmall.copyWith(
                              color: AppColor.textSecondary2,
                            ),
                          ),
                          TextSpan(
                            text: "Rp ${handlingFee}",
                            style: AppTypo.latoSmall.copyWith(
                              color: AppColor.primary,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              selected
                  ? Icon(
                      Icons.check_circle,
                      color: AppColor.primary,
                      size: 35,
                    )
                  : Container(
                      margin: EdgeInsets.only(right: 2),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColor.line, width: 1),
                      ),
                    ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Bank {
  final String icon;
  final String label;
  final String information;
  final int handlingFee;
  const Bank({
    @required this.icon,
    @required this.label,
    @required this.information,
    @required this.handlingFee,
  });
}
