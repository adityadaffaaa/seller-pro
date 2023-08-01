import 'dart:convert';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/data/blocs/new_cubit/wpp_cart/add_to_cart_offline/add_to_cart_offline_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/ui/widgets/bs_select_variant.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;

import 'wpp_product_detail_detail_screen_list.dart';
import 'wpp_product_detail_footer.dart';

class WppProductDetailBody extends StatefulWidget {
  const WppProductDetailBody({
    Key key,
    @required this.product,
    @required this.productId,
    this.categoryId,
    this.isPublicResellerShop = false,
  }) : super(key: key);

  final Products product;
  final int productId;
  final int categoryId;
  final bool isPublicResellerShop;

  @override
  _WppProductDetailBodyState createState() => _WppProductDetailBodyState();
}

class _WppProductDetailBodyState extends State<WppProductDetailBody> {
  ProductVariant _productVariantSelected;

  @override
  void initState() {
    _productVariantSelected = widget.product.productVariant.length > 0
        ? widget.product.productVariant[0]
        : null;
    super.initState();
  }

  _handleAddToCartOffline({
    @required Products product,
    @required int productId,
    @required ProductVariant variantSelected,
    // int categoryId,
  }) {
    context.read<AddToCartOfflineCubit>().addToCartOffline(
        product: product,
        productId: productId,
        variantSelected: variantSelected);
    final data = context.read<AddToCartOfflineCubit>().state;
    BSFeedback.showFeedBackShop(context,
        isWeb: true,
        routeWeb: '/wpp/dashboard/${widget.product.resellerWebStore.slug}',
        color: AppColor.success,
        title: "Produk berhasil ditambahkan ke keranjang",
        description: "Silahkan checkout untuk melakukan pembelian");
    debugPrint("mycart $data");
  }

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        CarouselProduct(
                          images: widget.product.productAssets,
                          isLoading: false,
                        ),
                        WppProductDetailDetailScreenList(
                          product: widget.product,
                          onVariantSelected:
                              (ProductVariant productVariantSelected) {
                            setState(() {
                              _productVariantSelected = productVariantSelected;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: WppProductDetailFooter(
                stock: widget.product.stock,
                phone: () {
                  AppExt.toWebUrl(context,
                      "https://api.whatsapp.com/send?phone=${widget.product.supplier.phone}");
                },
                isButtonBeliEnable: true,
                onPressed: () {
                  if (widget.product.stock == 0) {
                    BSFeedback.show(context,
                        color: AppColor.danger,
                        title: "Gagal menambah ke keranjang",
                        description: "Stok barang habis",
                        icon: Icons.cancel_outlined);
                  } else {
                    if (widget.product.productVariant.length > 0) {
                      // if (widget.product.isBeliLangsung == 1) {
                      //   context.beamToNamed(
                      //       '/wpp/customeraddressbayarlangsung?dt=${AppExt.encryptMyData(jsonEncode(widget.product))}&dv=${AppExt.encryptMyData(jsonEncode(_productVariantSelected))}');
                      // } else 
                      if (widget.product.isLangganan == 1 || widget.product.isBeliLangsung == 1) {
                        context.beamToNamed(
                            '/wpp/indibiznetformbuyreseller1?dt=${AppExt.encryptMyData(jsonEncode(widget.product))}');
                      } else {
                        BsSelectVariant().showBsReview(context,
                            imageProduct: widget.product.coverPhoto,
                            listVariant: widget.product.productVariant,
                            variantSelected: _productVariantSelected,
                            onVariantSelected: (int val, ProductVariant val2) {
                          AppExt.popScreen(context);
                          _handleAddToCartOffline(
                              product: widget.product,
                              productId: widget.productId,
                              variantSelected: val2);
                        });
                      }
                    } else {
                      // if (widget.product.isBeliLangsung == 1) {
                      //   context.beamToNamed(
                      //       '/wpp/customeraddressbayarlangsung?dt=${AppExt.encryptMyData(jsonEncode(widget.product))}&dv=${AppExt.encryptMyData(jsonEncode(_productVariantSelected))}');
                      // } else 
                      if (widget.product.isLangganan == 1 || widget.product.isBeliLangsung == 1) {
                        context.beamToNamed(
                            '/wpp/indibiznetformbuyreseller1?dt=${AppExt.encryptMyData(jsonEncode(widget.product))}');
                      } else {
                        _handleAddToCartOffline(
                            product: widget.product,
                            productId: widget.productId,
                            variantSelected: _productVariantSelected);
                      }
                    }
                    // debugPrint("FOOTERNYA WEB");
                    // _handleAddToCartOffline(
                    //         product: widget.product,
                    //         productId: widget.productId,
                    //         variantSelected: _productVariantSelected != null ? _productVariantSelected : null
                    //         // categoryId: widget.categoryId
                    //       );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
