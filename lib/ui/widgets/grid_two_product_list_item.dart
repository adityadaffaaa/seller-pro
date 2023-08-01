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
import 'package:marketplace/data/repositories/new_repositories/recipent_repository.dart';
import 'package:marketplace/ui/screens/mobile/product_detail/product_detail_screen.dart';
import 'package:marketplace/ui/widgets/bs_bagikan_produk.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:shimmer/shimmer.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../data/models/subcategory.dart';

// ignore: must_be_immutable
class GridTwoProductListItem extends StatelessWidget {
  // final Products product;
  // final Subcategories subcategories;
  // final TokoSayaProducts productShop;
  final String product;
  final String subcategories;
  final String productShop;
  final String image;
  final String komisi;
  final String price;
  bool isDiscount,
      useLineProgress,
      isShop,
      isBumdes,
      isKomisi,
      isProductByCategory,
      isPublicWarung,
      isBayarLangsung;
  bool isUpgrader;
  final void Function(int productId) onDelete;

  //VARIABEL KHUSUS WARUNG
  final String warungSlug;

  //=======================

  GridTwoProductListItem({
    Key key,
    this.product,
    this.productShop,
    this.isDiscount = false,
    this.useLineProgress = false,
    this.isUpgrader,
    this.isShop = false,
    this.isBumdes = false,
    this.isKomisi = false,
    this.isProductByCategory = false,
    this.isPublicWarung,
    this.onDelete,
    this.warungSlug,
    this.isBayarLangsung = false,
    this.subcategories,
    this.image,
    this.komisi,
    this.price,
  }) : super(key: key);

  String getProductSlug(String name) {
    var temp = name.split(' ');
    return temp.join('-');
  }

  @override
  Widget build(BuildContext context) {
    final RecipentRepository recipentRepo = RecipentRepository();
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final isUser = BlocProvider.of<UserDataCubit>(context).state.user != null
        ? BlocProvider.of<UserDataCubit>(context).state.user
        : null;
    isUpgrader = isUser != null ? isUser.reseller != null : false;

    return kIsWeb
        ? MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                recipentRepo.isFromWppDashboard(value: true);
                recipentRepo.isFromWppDetailProductDetail(value: true);
                // context.beamToNamed(
                //     '/wpp/productdetail/$warungSlug/${product.slug}/${product.id}',
                //     data: {'isFromDashboard': true});
                // context.beamToNamed(
                //     '/productdetail/${isShop ? productShop.id : product.id}');
                // AppExt.pushScreen(
                //     context,
                //     ProductDetailScreen(
                //       productId:
                //           product != null ? product.id : productShop.productId,
                //       isBayarLangsung: isBayarLangsung,
                //       subcategories: subcategories,
                //     ));
              },
              child: cardProductWeb(context, isUser, _screenWidth),
            ),
          )
        : InkWell(
            onTap: () {
              AppExt.pushScreen(
                  context,
                  ProductDetailScreen(
                      // productId:
                      //     product != null ? product.id : productShop.productId,
                      // isBayarLangsung: isBayarLangsung,
                      // subcategories: subcategories,
                      ));
            },
            child: cardProduct(context, isUser, _screenHeight));
  }

  Widget cardProduct(BuildContext context, User userData, double screenHeight) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColor.black.withOpacity(0.08),
            blurRadius: 5,
            // spreadRadius: 8,
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
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 175,
                  ),
                  //  CachedNetworkImage(
                  //   imageUrl: isShop
                  //       ? productShop.productPhoto ??
                  //           'https://venus.bisnisomall.com/images/blank.png'
                  //       : product.productAssets.length > 0
                  //           ? product.productAssets[0].image
                  //           : 'https://venus.bisnisomall.com/images/blank.png',
                  //   memCacheHeight: Get.height > 350
                  //       ? (Get.height * 0.25).toInt()
                  //       : Get.height,
                  //   width: double.infinity,
                  //   height: 175,
                  //   fit: BoxFit.cover,
                  //   placeholder: (context, url) => Shimmer.fromColors(
                  //     baseColor: Colors.grey[300],
                  //     highlightColor: Colors.grey[200],
                  //     period: Duration(milliseconds: 1000),
                  //     child: Container(
                  //       width: double.infinity,
                  //       height: 175,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.only(
                  //               topLeft: Radius.circular(5),
                  //               topRight: Radius.circular(5)),
                  //           color: Colors.white),
                  //     ),
                  //   ),
                  //   errorWidget: (context, url, error) => Image.asset(
                  //     AppImg.img_error,
                  //     width: double.infinity,
                  //     height: 175,
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                ),
                isShop
                    ? Positioned(
                        bottom: 7,
                        right: 7,
                        child: GestureDetector(
                          onTap: () {
                            // onDelete(productShop.id);
                          },
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
          isBumdes
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  width: double.infinity,
                  child: Text("Bumdes Singosari",
                      style: AppTypo.body1Lato.copyWith(color: Colors.white)),
                  decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30))),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isUpgrader && userData.reseller != null && isKomisi == true
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          // color: AppColor.red.withOpacity(0.25),
                        ),
                        child: Text(
                          // "Komisi Rp ${AppExt.toRupiah(isShop ? productShop.commisionPrice : product.commissionPrice) ?? 0}",
                          "Komisi $komisi",
                          style: AppTypo.overline.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.red,
                              fontSize: kIsWeb ? 12 : 12),
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 5),
                Text(
                  product,
                  // "${isShop ? productShop.name : product.name}",
                  maxLines: kIsWeb ? 2 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypo.caption
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                Text(
                  // "Rp ${AppExt.toRupiah(isShop ? productShop.finalPrice : isDiscount ? product.discPrice : product.sellingPrice)}",
                  "Rp $price",
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
                              "0%",
                              // "${productShop != null ? productShop.disc : product.disc ?? 0}%",
                              style: AppTypo.overline.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.red),
                            ),
                          ),
                          SizedBox(width: 3),
                          Expanded(
                            child: Text(
                                // "Rp ${AppExt.toRupiah(isDiscount ? productShop != null ? productShop.oriPrice : product.sellingPrice : 0)}",
                                "Rp 0",
                                maxLines: kIsWeb ? null : 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypo.captionAccent.copyWith(
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
                              "Bandung",
                              // product.supplier.city,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypo.caption.copyWith(
                                  fontSize: 13, color: AppColor.editTextIcon),
                            ),
                          )
                        ],
                      )
                    : SizedBox(),
                // SizedBox(height: 5),
                // Text(
                //         "Stok ${AppExt.toRupiah(isShop ? productShop.stock : product.stock)}",
                //         style: AppTypo.captionAccent.copyWith(fontSize: 12)),
                SizedBox(height: 5),
                !useLineProgress
                    ? Text("Terjual 0",
                        // "Terjual ${AppExt.toRupiah(isShop ? productShop.sold : product.sold)}",
                        style: AppTypo.caption.copyWith(
                            fontSize: 13, color: AppColor.editTextIcon))
                    : Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: LinearProgressIndicator(
                              value: 1,
                              // product.stock == 0
                              //     ? 1
                              //     : product.sold / product.stock,
                              backgroundColor: AppColor.silverFlashSale,
                              minHeight: 15,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.redFlashSale),
                            ),
                          ),
                          Center(
                            child: Text("Terjual 0",
                                // "Terjual ${AppExt.toRupiah(product.sold)}",
                                style: AppTypo.body1.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.white)),
                          )
                        ],
                      ),
                SizedBox(
                  height: isUpgrader && userData.reseller != null ? 9 : 0,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: isUpgrader && userData.reseller != null
                ? GestureDetector(
                    onTap: () {
                      // isShop
                      //     ? productShop.stock != 0
                      //         ? BsBagikanProduk().showBsReview(
                      //             context, product, productShop, isShop)
                      //         : BSFeedback.outOfStock(
                      //             context,
                      //             imgUrl: "images/img_not_found.png",
                      //             title: "Maaf, stok barang sedang habis",
                      //             description:
                      //                 " Anda dapat membagikan produk saat stok kembali tersedia",
                      //           )
                      //     : product.stock != 0
                      //         ? BsBagikanProduk().showBsReview(
                      //             context, product, productShop, isShop)
                      //         : BSFeedback.outOfStock(
                      //             context,
                      //             imgUrl: "images/img_not_found.png",
                      //             title: "Maaf, stok barang sedang habis",
                      //             description:
                      //                 " Anda dapat membagikan produk saat stok kembali tersedia",
                      //           );
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
                        // isShop
                        //     ? productShop.stock != 0
                        //         ? AppColor.primary
                        //         : Colors.grey[350]
                        //     : product.stock != 0
                        //         ? AppColor.primary
                        //         : Colors.grey[350],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget cardProductWeb(
      BuildContext context, User userData, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColor.black.withOpacity(0.08),
            blurRadius: 5,
            // spreadRadius: 8,
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
                    child: Image(
                      image: AssetImage(image),
                      // NetworkImage(
                      //   isShop
                      //       ? productShop.productPhoto ??
                      //           'https://mercury.panenpanen.com/storage/products/'
                      //       : product.productAssets.length > 0
                      //           ? product.productAssets[0].image
                      //           : 'https://venus.bisnisomall.com/images/blank.png',
                      //   // "https://picsum.photos/200",
                      // ),
                      width: double.infinity,
                      height: context.isPhone ? screenWidth * (40 / 100) : 200,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace stackTrace) {
                        return Image.asset(
                          AppImg.img_error,
                          width: double.infinity,
                          height:
                              context.isPhone ? screenWidth * (50 / 100) : 200,
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
                                    width: double.infinity,
                                    height: context.isPhone
                                        ? screenWidth * (50 / 100)
                                        : 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10)),
                                      color: Colors.grey[200],
                                    ),
                                  ),
                          );
                        }
                      },
                    )),
                isShop
                    ? Positioned(
                        bottom: 7,
                        right: 7,
                        child: GestureDetector(
                          onTap: () {
                            // onDelete(productShop.id);
                          },
                          child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Icon(
                              FlutterIcons.trash_ent,
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
          isBumdes
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  width: double.infinity,
                  child: Text("Bumdes Singosari",
                      style: AppTypo.body1Lato.copyWith(color: Colors.white)),
                  decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30))),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isUpgrader && userData.reseller != null && isKomisi == true
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          // color: AppColor.red.withOpacity(0.25),
                        ),
                        child: Text(
                          // "Komisi ${product.komisi ?? 0}%",
                          // "Komisi Rp ${AppExt.toRupiah(isShop ? productShop.commisionPrice : product.commissionPrice) ?? 0}",
                          "Komisi Rp 20.000",
                          style: AppTypo.overline.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.red,
                              fontSize: kIsWeb ? 12 : 12),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 5,
                ),
                Text(
                  // "${isShop ? productShop.name : product.name}",
                  "Product name",
                  maxLines: kIsWeb ? 2 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypo.caption.copyWith(fontSize: 14),
                ),
                SizedBox(height: 6),
                Text(
                  // "Rp ${AppExt.toRupiah(isShop ? productShop.oriPrice : isDiscount ? product.discPrice : product.sellingPrice)}",
                  "Rp 20.000",
                  maxLines: kIsWeb ? null : 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypo.caption.copyWith(
                      fontWeight: FontWeight.w700, color: AppColor.primary),
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
                              // "${product.disc ?? 0}%",
                              "20%",
                              style: AppTypo.overline.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.red),
                            ),
                          ),
                          SizedBox(width: 3),
                          Expanded(
                            child: Text(
                                // "Rp ${AppExt.toRupiah(isDiscount ? product.sellingPrice : 0)}",
                                "Rp 30.000",
                                maxLines: kIsWeb ? null : 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypo.captionAccent.copyWith(
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
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              // product.supplier.city,
                              "Surabaya",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypo.caption.copyWith(fontSize: 12),
                            ),
                          )
                        ],
                      )
                    : SizedBox(),
                SizedBox(height: 5),
                !useLineProgress
                    ? Text(
                        // "Terjual ${AppExt.toRupiah(isShop ? productShop.sold : product.sold)}",
                        "Terjual 20",
                        style: AppTypo.captionAccent.copyWith(fontSize: 12))
                    : Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: LinearProgressIndicator(
                              value: 1,
                              // product.stock == 0
                              //     ? 1
                              //     : product.sold / product.stock,
                              backgroundColor: AppColor.silverFlashSale,
                              minHeight: 15,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.redFlashSale),
                            ),
                          ),
                          Center(
                            child: Text(
                                // "Terjual ${AppExt.toRupiah(product.sold)}",
                                "Terjual 30",
                                style: AppTypo.body1.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.white)),
                          )
                        ],
                      ),
                SizedBox(
                  height: isUpgrader && userData.reseller != null ? 9 : 0,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: isUpgrader && userData.reseller != null
                ? GestureDetector(
                    onTap: () {
                      // isShop
                      //     ? () {
                      //         if (productShop.stock != 0) {
                      //           if (kIsWeb) {
                      //             AppExt.toWebUrl(context,
                      //                 "https://api.whatsapp.com/send?text=Produk ${productShop.name} | Ekomad https://store.ekomad.id/wpp/productdetail/${userData.reseller.slug}/${productShop.slug}/${productShop.id}");
                      //           } else {
                      //             BsBagikanProduk().showBsReview(
                      //                 context, product, productShop, isShop);
                      //           }
                      //         } else {
                      //           BSFeedback.outOfStock(
                      //             context,
                      //             imgUrl: "images/img_not_found.png",
                      //             title: "Maaf, stok barang sedang habis",
                      //             description:
                      //                 " Anda dapat membagikan produk saat stok kembali tersedia",
                      //           );
                      //         }
                      //       }()
                      //     : () {
                      //         if (product.stock != 0) {
                      //           if (kIsWeb) {
                      //             AppExt.toWebUrl(context,
                      //                 "https://api.whatsapp.com/send?text=Produk ${product.name} | Ekomad https://store.ekomad.id/wpp/productdetail/${userData.reseller.slug}/${product.slug}/${product.id}");
                      //           } else {
                      //             BsBagikanProduk().showBsReview(
                      //                 context, product, productShop, isShop);
                      //           }
                      //         } else {
                      //           BSFeedback.outOfStock(
                      //             context,
                      //             imgUrl: "images/img_not_found.png",
                      //             title: "Maaf, stok barang sedang habis",
                      //             description:
                      //                 " Anda dapat membagikan produk saat stok kembali tersedia",
                      //           );
                      //         }
                      //       }();
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
                          // isShop
                          //     ? productShop.stock != 0
                          //         ? AppColor.primary
                          //         : Colors.grey[350]
                          //     : product.stock != 0
                          //         ? AppColor.primary
                          //         : Colors.grey[350],
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
