import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beamer/beamer.dart';
import 'package:marketplace/data/blocs/new_cubit/cart/add_to_cart/add_to_cart_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/recipent/fetch_selected_recipent/fetch_selected_recipent_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/toko_saya/add_product_toko_saya/add_product_toko_saya_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/models/subcategory.dart';
import 'package:marketplace/data/repositories/new_repositories/recipent_repository.dart';
import 'package:marketplace/ui/screens/mobile/credentials/sign_in_screen.dart';
import 'package:marketplace/ui/screens/mobile/nav/account/update_address_screen.dart';
import 'package:marketplace/ui/widgets/bs_select_variant.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;

import 'detail_screen_list.dart';
import 'footer_product_detail.dart';

class ProductDetailBody extends StatefulWidget {
  const ProductDetailBody(
      {Key key,
      this.product,
      this.productId,
      // @required this.product,
      // @required this.productId,
      this.isBayarLangsung = false,
      this.isTelkomProduct = false,
      this.subcategories = null})
      : super(key: key);

  final Products product;
  final int productId;
  final bool isBayarLangsung;
  final bool isTelkomProduct;
  final Subcategories subcategories;

  @override
  _ProductDetailBodyState createState() => _ProductDetailBodyState();
}

class _ProductDetailBodyState extends State<ProductDetailBody> {
  final RecipentRepository _repoRecipent = RecipentRepository();
  // AddProductTokoSayaCubit _addProductTokoSayaCubit;
  // FetchSelectedRecipentCubit _fetchSelectedRecipentCubit;

  List<ProductAssets> productAssetsList = [];

  int variantIdSelected = 0;
  // ProductVariant _productVariantSelected;
  Recipent recipentMainAddress;

  @override
  void initState() {
    // _productVariantSelected = widget.product.productVariant.length > 0
    //     ? widget.product.productVariant[0]
    //     : null;
    // _addProductTokoSayaCubit = AddProductTokoSayaCubit();
    // _fetchSelectedRecipentCubit = FetchSelectedRecipentCubit()
    //   ..fetchSelectedRecipent();
    // variantIdSelected = widget.product.productVariant.length > 0
    //     ? widget.product.productVariant[0].id
    //     : 0;
    // _handleProductAssets();
    super.initState();
  }

  // _handleAddToCart({@required int sellerId, int variantId = 0}) {
  //   LoadingDialog.show(context);
  //   context.read<AddToCartCubit>().addToCart(
  //       productId: widget.productId,
  //       sellerId: sellerId,
  //       isVariant: variantId == 0 ? 0 : 1,
  //       variantId: variantId == 0 ? null : variantId);
  //   // _addToCartCubit.addToCart(productId: widget.productId, sellerId: sellerId);
  // }

  _handleProductAssets() {
    // if (widget.product.videoLink != null &&
    //     widget.product.productAssets.length > 0) {
    //   for (int i = 0; i < widget.product.productAssets.length + 1; i++) {
    //     if (i == 0) {
    //       productAssetsList
    //           .add(ProductAssets(videoLink: widget.product.videoLink));
    //     } else {
    //       productAssetsList.addAll(widget.product.productAssets);
    //     }
    //   }
    // }
    // if (widget.product.videoLink == null &&
    //     widget.product.productAssets.length > 0) {
    //   for (int i = 0; i < widget.product.productAssets.length; i++) {
    //     productAssetsList.add(widget.product.productAssets[i]);
    //   }
    // }
    // if (widget.product.videoLink != null &&
    //     widget.product.productAssets.length == 0) {
    //   productAssetsList.add(ProductAssets(videoLink: widget.product.videoLink));
    // }
  }

  @override
  void dispose() {
    // _addProductTokoSayaCubit.close();
    // _fetchSelectedRecipentCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    // final userData = BlocProvider.of<UserDataCubit>(context).state.user != null
    //     ? BlocProvider.of<UserDataCubit>(context).state.user
    //     : null;

    return
        //  MultiBlocProvider(
        //   providers: [
        //     BlocProvider(
        //       create: (_) => _addProductTokoSayaCubit,
        //     ),
        //     BlocProvider(
        //       create: (_) => _fetchSelectedRecipentCubit,
        //     ),
        //   ],
        //   child: MultiBlocListener(
        //     listeners: [
        //       BlocListener(
        //         bloc: _addProductTokoSayaCubit,
        //         listener: (context, state) {
        //           if (state is AddProductTokoSayaLoading) {
        //             LoadingDialog.show(context);
        //           }
        //           if (state is AddProductTokoSayaFailure) {
        //             if (state.result.contains("Product already exists")) {
        //               AppExt.popScreen(context);
        //               BSFeedback.showFeedBackShop(context,
        //                   icon: Icons.error_outline,
        //                   isAddToTokoSaya: true,
        //                   color: Colors.red,
        //                   title: "Produk gagal ditambahkan!",
        //                   description: "Produk ini sudah tersedia pada toko anda",
        //                   categoryId: widget.product.categoryId);
        //             } else {
        //               AppExt.popScreen(context);
        //               ScaffoldMessenger.of(context)
        //                 ..hideCurrentSnackBar()
        //                 ..showSnackBar(
        //                   SnackBar(
        //                     margin: EdgeInsets.zero,
        //                     duration: Duration(seconds: 2),
        //                     content: Text(state.result.toString()),
        //                     backgroundColor: Colors.red,
        //                     behavior: SnackBarBehavior.floating,
        //                   ),
        //                 );
        //             }
        //           }
        //           if (state is AddProductTokoSayaSuccess) {
        //             AppExt.popScreen(context);
        //             BSFeedback.showFeedBackShop(context,
        //                 isAddToTokoSaya: true,
        //                 color: AppColor.success,
        //                 title: "Produk berhasil ditambahkan!",
        //                 description:
        //                     "Anda dapat menambahkan lebih banyak produk lagi untuk menambah peluang keuntungan anda",
        //                 categoryId: widget.product.categoryId);
        //           }
        //         },
        //       ),
        //       BlocListener(
        //         bloc: _fetchSelectedRecipentCubit,
        //         listener: (context, state) {
        //           if (state is FetchSelectedRecipentSuccess) {
        //             setState(() {
        //               recipentMainAddress = state.recipent;
        //             });
        //           }
        //           if (state is FetchSelectedRecipentFailure) {
        //             ScaffoldMessenger.of(context)
        //               ..hideCurrentSnackBar()
        //               ..showSnackBar(
        //                 SnackBar(
        //                   margin: EdgeInsets.zero,
        //                   duration: Duration(seconds: 2),
        //                   content: Text('Terjadi Kesalahan'),
        //                   backgroundColor: Colors.red,
        //                   behavior: SnackBarBehavior.floating,
        //                 ),
        //               );
        //           }
        //         },
        //       ),
        //     ],
        //     child:

        //   ),
        // );
        AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        CarouselProduct(
                          images: [],
                          // images: widget.product.productAssets.length > 0
                          //     ? productAssetsList
                          //     : [
                          //         ProductAssets(
                          //             image:
                          //                 "https://venus.bisnisomall.com/images/blank.png")
                          //       ],
                          isLoading: false,
                        ),
                        // Static data
                        Image.asset(
                          AppImg.img_product_header,
                        ),
                        //Text("categoryId : ${widget.product.categoryId}, categoryName: ${widget.product.categoryName}"),
                        DetailScreenList(
                            // product: widget.product,
                            // recipentMainAddress: recipentMainAddress,
                            // onVariantSelected: (int id,
                            //     ProductVariant productVariantSelected) {
                            //   print("ID VARIANT //");
                            //   setState(() {
                            //     variantIdSelected = id;
                            //     _productVariantSelected =
                            //         productVariantSelected;
                            //   });
                            // },
                            ),
                      ],
                    ),
                    // BlocProvider.of<UserDataCubit>(context).state.user !=
                    //         null
                    //     ? BlocProvider.of<UserDataCubit>(context)
                    //                 .state
                    //                 .user
                    //                 .reseller !=
                    //             null
                    //         ? Positioned(
                    //             top: kIsWeb
                    //                 ? _screenHeight * (62 / 100)
                    //                 : _screenHeight * (43.5 / 100),
                    //             right: 8,
                    //             child: GestureDetector(
                    //               onTap: () {
                    //                 // if (widget.product.stock > 0) {
                    //                 //   _addProductTokoSayaCubit.addProduct(
                    //                 //       productId: widget.productId);
                    //                 // } else {
                    //                 //   BSFeedback.show(context,
                    //                 //       color: AppColor.danger,
                    //                 //       title:
                    //                 //           "Gagal menambah ke toko saya",
                    //                 //       description: "Stok barang habis",
                    //                 //       icon: Icons.cancel_outlined);
                    //                 // }
                    //               },
                    //               child: MouseRegion(
                    //                 cursor: SystemMouseCursors.click,
                    //                 child: Container(
                    //                   width: 50,
                    //                   height: 50,
                    //                   child: Center(
                    //                     child: Image.asset(
                    //                       AppImg.img_add_shop_product,
                    //                       width: 30,
                    //                       height: 30,
                    //                     ),
                    //                   ),
                    //                   decoration: BoxDecoration(
                    //                     boxShadow: [
                    //                       BoxShadow(
                    //                         color: Colors.black
                    //                             .withOpacity(0.1),
                    //                         spreadRadius: 0,
                    //                         blurRadius: 7,
                    //                         offset: Offset(0,
                    //                             6), // changes position of shadow
                    //                       ),
                    //                     ],
                    //                     borderRadius:
                    //                         BorderRadius.circular(35),
                    //                     color: Colors.white
                    //                     // widget.product.stock > 0
                    //                     //     ? Colors.white
                    //                     //     : Colors.grey[200]
                    //                     ,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           )
                    //         : SizedBox()
                    //     : SizedBox(),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: FooterProductDetail(
                // stock: widget.product.stock,
                phone: () {
                  AppExt.toWebUrl(
                    context,
                    "https://api.whatsapp.com/send?phone=${widget.product.supplier.phone}&text=Halo%20 ${widget.product.supplier.name}",
                  );
                },
                onPressed: () async {
                  // if (widget.product.stock == 0) {
                  //   BSFeedback.show(context,
                  //       color: AppColor.danger,
                  //       title: "Gagal menambah ke keranjang",
                  //       description: "Stok barang habis",
                  //       icon: Icons.cancel_outlined);
                  // } else {
                  //   if (BlocProvider.of<UserDataCubit>(context)
                  //           .state
                  //           .user ==
                  //       null) {
                  //     kIsWeb
                  //         ? context.beamToNamed('/signin')
                  //         : AppExt.pushScreen(
                  //             context,
                  //             SignInScreen(),
                  //           );
                  //   } else if (recipentMainAddress == null) {
                  //     BSFeedback.show(context,
                  //         color: AppColor.danger,
                  //         title:
                  //             "Alamat pengiriman kosong atau belum ditentukan",
                  //         description:
                  //             "Tentukan alamat pengiriman terlebih dahulu",
                  //         icon: Icons.cancel_outlined,
                  //         anotherWidget: RoundedButton.contained(
                  //             label: "Tentukan Alamat",
                  //             isUpperCase: false,
                  //             onPressed: () {
                  //               if (kIsWeb) {
                  //                 context.beamToNamed('/addressuser');
                  //               } else {
                  //                 AppExt.popUntilRoot(context);
                  //                 AppExt.pushScreen(
                  //                     context, UpdateAddressScreen());
                  //               }
                  //             }));
                  //   } else {
                  //     if (widget.product.productVariant.length > 0) {
                  //       BsSelectVariant().showBsReview(context,
                  //           imageProduct: widget.product.coverPhoto,
                  //           listVariant: widget.product.productVariant,
                  //           variantSelected: _productVariantSelected,
                  //           onVariantSelected:
                  //               (int val, ProductVariant val2) {
                  //         AppExt.popScreen(context);
                  //         _handleAddToCart(
                  //           sellerId: widget.product.supplierId,
                  //           variantId: val,
                  //         );
                  //       });
                  //     } else {
                  //       _handleAddToCart(
                  //         sellerId: widget.product.supplierId,
                  //         variantId: 0,
                  //       );
                  //     }
                  //   }
                  // }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
