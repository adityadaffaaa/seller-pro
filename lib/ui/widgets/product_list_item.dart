import 'package:beamer/beamer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/ui/screens/mobile/product_detail/product_detail_screen.dart';
import 'package:marketplace/ui/widgets/bs_bagikan_produk.dart';
import 'package:marketplace/ui/widgets/bs_feedback.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:shimmer/shimmer.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../data/blocs/new_cubit/toko_saya/fetch_product_toko_saya/fetch_product_toko_saya_bloc.dart';

// ignore: must_be_immutable
class ProductListItem extends StatelessWidget {
  bool isDiscount,
      useLineProgress,
      isShop,
      isBumdes,
      isKomisi,
      isFlashSale,
      isPublicResellerShop;
  bool isUpgrader;
  final void Function(int productId) onDelete;

  ProductListItem({
    Key key,
    this.isUpgrader = false,
    this.isDiscount = false,
    this.useLineProgress = false,
    this.isShop = false,
    this.isBumdes = false,
    this.isKomisi = false,
    this.isFlashSale = false,
    this.isPublicResellerShop = false,
    this.onDelete,
  }) : super(key: key);

  String getProductSlug(String name) {
    var temp = name.split(' ');
    return temp.join('-');
  }

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;

    return kIsWeb
        ? MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {},
              child: cardProduct(context, _screenHeight),
            ),
          )
        : InkWell(
            onTap: () {
              AppExt.pushScreen(context, ProductDetailScreen());
            },
            child: cardProduct(context, _screenHeight));
  }

  Widget cardProduct(BuildContext context, double screenHeight) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColor.black.withOpacity(0.08),
            blurRadius: 5,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl: 'https://venus.bisnisomall.com/images/blank.png',
                    memCacheHeight: Get.height > 350
                        ? (Get.height * 0.25).toInt()
                        : Get.height,
                    width: double.infinity,
                    height: 175,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[200],
                      period: Duration(milliseconds: 1000),
                      child: Container(
                        width: double.infinity,
                        height: 175,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            color: Colors.white),
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      AppImg.img_error,
                      width: double.infinity,
                      height: 175,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                isShop
                    ? Positioned(
                        bottom: 7,
                        right: 7,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Icon(
                              EvaIcons.trash2,
                              color: AppColor.redFlashSale,
                              size: 15,
                            )),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isUpgrader
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          "Komisi Rp 20.000",
                          style: AppTypo.overline.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.red,
                              fontSize: kIsWeb ? 12 : 12),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          "",
                          style: AppTypo.overline.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.red,
                              fontSize: kIsWeb ? 12 : 12),
                        ),
                      ),
                SizedBox(height: 5),
                Text(
                  "Product Name",
                  maxLines: kIsWeb ? 2 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypo.caption
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                Text(
                  "Rp 30.000",
                  maxLines: kIsWeb ? null : 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypo.caption.copyWith(
                      fontWeight: FontWeight.w800, color: AppColor.primary),
                ),
                isDiscount ? SizedBox(height: 6) : SizedBox.shrink(),
                isDiscount
                    ? Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: AppColor.red.withOpacity(0.25),
                            ),
                            child: Text(
                              "10%",
                              style: AppTypo.overline.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.red),
                            ),
                          ),
                          SizedBox(width: 3),
                          Expanded(
                            child: Text("Rp 20.000",
                                maxLines: kIsWeb ? null : 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypo.caption.copyWith(
                                    decoration: TextDecoration.lineThrough)),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                SizedBox(height: !isShop ? 6 : 0),
                !isShop
                    ? Row(
                        children: [
                          kIsWeb
                              ? WebsafeSvg.asset(AppImg.ic_marker_map,
                                  width: 10)
                              : SvgPicture.asset(AppImg.ic_marker_map,
                                  width: 10),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              "Bogor, Indonesia",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypo.caption.copyWith(
                                  fontSize: 13, color: AppColor.editTextIcon),
                            ),
                          )
                        ],
                      )
                    : SizedBox(),
                SizedBox(height: 5),
                !useLineProgress
                    ? Text("Terjual 20",
                        style: AppTypo.caption.copyWith(
                            fontSize: 13, color: AppColor.editTextIcon))
                    : Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: AppColor.silverFlashSale,
                              minHeight: 15,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.redFlashSale),
                            ),
                          ),
                          Center(
                            child: Text("Terjual 20",
                                style: AppTypo.body1.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.white)),
                          )
                        ],
                      ),
                SizedBox(
                  height: isUpgrader ? 9 : 0,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: isUpgrader
                ? GestureDetector(
                    onTap: () {
                      // if (product.stock != 0) {
                      //   if (kIsWeb) {
                      //     AppExt.toWebUrl(context,
                      //         "https://api.whatsapp.com/send?text=Produk ${product.name} | Ekomad https://store.ekomad.id/wpp/productdetail/${userData.reseller.slug}/${getProductSlug(product.name)}/${product.id}");
                      //   } else {
                      //     BsBagikanProduk()
                      //         .showBsReview(context, product, null, isShop);
                      //   }
                      // } else {
                      BSFeedback.outOfStock(
                        context,
                        imgUrl: "images/img_not_found.png",
                        title: "Maaf, stok barang sedang habis",
                        description:
                            " Anda dapat membagikan produk saat stok kembali tersedia",
                      );
                      //   }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            EvaIcons.shareOutline,
                            color: AppColor.textPrimaryInverted,
                            size: 15,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Bagikan",
                            style: AppTypo.body2Lato
                                .copyWith(color: AppColor.textPrimaryInverted),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
