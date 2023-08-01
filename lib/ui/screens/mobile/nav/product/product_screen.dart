import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:marketplace/ui/widgets/app_bar_config.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/ui/widgets/grid_two_product_list_item.dart';
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/typography.dart' as AppTypo;

import 'widgets/product_select_option.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();

  final products = [
    const Products(
      image: AppImg.img_product_1,
      commission: "1.620.000",
      title: "Paket 1 Propolis Pro A Premium (4 Box)",
      price: "540.000",
      place: "Surabaya",
      totalSold: 206,
    ),
    const Products(
      image: AppImg.img_product_2,
      commission: "1.620.000",
      title: "Paket 1 Propolis Pro A Premium (4 Box)",
      price: "540.000",
      place: "Surabaya",
      totalSold: 206,
    ),
    const Products(
      image: AppImg.img_product_3,
      commission: "1.620.000",
      title: "Paket 1 Propolis Pro A Premium (4 Box)",
      price: "540.000",
      place: "Surabaya",
      totalSold: 206,
    ),
    const Products(
      image: AppImg.img_product_4,
      commission: "1.620.000",
      title: "Paket 1 Propolis Pro A Premium (4 Box)",
      price: "540.000",
      place: "Surabaya",
      totalSold: 206,
    ),
    const Products(
      image: AppImg.img_product_5,
      commission: "1.620.000",
      title: "Paket 1 Propolis Pro A Premium (4 Box)",
      price: "540.000",
      place: "Surabaya",
      totalSold: 206,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: kIsWeb ? 500 : 450,
        ),
        child: Scaffold(
            appBar: AppBarConfig(
              bgColor: AppColor.white,
              iconColor: AppColor.black,
              logoColor: AppColor.primary,
            ),
            body: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 16),
                controller: _scrollController,
                children: [
                  Column(children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  kIsWeb ? 24 : _screenWidth * (5 / 100),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColor.navScaffoldBg,
                                  radius:
                                      kIsWeb ? 35 : _screenWidth * (6 / 100),
                                  backgroundImage: const AssetImage(
                                    AppImg.img_seller_pro,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Seller Pro Official Store",
                                          style: AppTypo.body2Lato.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "Bergabung: Juli 2023",
                                          style: AppTypo.body2Lato.copyWith(
                                              fontSize: 12,
                                              color: AppColor.textSecondary2),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => null,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 7),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.share_outlined,
                                          color: AppColor.textPrimaryInverted,
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "Bagikan Toko",
                                          style: AppTypo.body2Lato.copyWith(
                                              color:
                                                  AppColor.textPrimaryInverted),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: AppColor.primary,
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    kIsWeb ? 24 : _screenWidth * (5 / 100)),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    kIsWeb ? 24 : _screenWidth * (5 / 100)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(EvaIcons.star,
                                            color: AppColor.gold, size: 18),
                                        SizedBox(width: 5),
                                        Text(
                                          "4.9",
                                          style: AppTypo.body1Lato,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Rating & ulasan",
                                      style: AppTypo.body2Lato.copyWith(
                                          color: AppColor.textSecondary2,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("0", style: AppTypo.body1Lato),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text("Produk Terjual",
                                        style: AppTypo.body2Lato.copyWith(
                                            color: AppColor.textSecondary2,
                                            fontSize: 12))
                                  ],
                                ),
                                InkWell(
                                  onTap: () => null,
                                  child: Column(
                                    children: [
                                      Text("0", style: AppTypo.body1Lato),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text("Total Pelanggan",
                                          style: AppTypo.body2Lato.copyWith(
                                              color: AppColor.textSecondary2,
                                              fontSize: 12))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const IntrinsicHeight(
                              child: Divider(
                            height: 2,
                            color: AppColor.silverFlashSale,
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    kIsWeb ? 24 : _screenWidth * (5 / 100),
                                vertical: 14),
                            child: Row(
                              children: [
                                ProductSelectionOption(
                                    title: "Filter", onTap: () => null),
                                SizedBox(
                                  width: 13,
                                ),
                                ProductSelectionOption(
                                  title: "Kategori",
                                  onTap: () => null,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        AlignedGridView.count(
                          controller: _scrollController2,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            top: kIsWeb ? 0 : 20,
                            left: kIsWeb ? 24 : _screenWidth * (5 / 100),
                            right: kIsWeb ? 24 : _screenWidth * (5 / 100),
                          ),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          itemCount: products.length,
                          itemBuilder: (BuildContext context, int index) {
                            final product = products[index];
                            return GridTwoProductListItem(
                              product: product.title,
                              isKomisi: true,
                              komisi: product.commission,
                              image: product.image,
                              price: product.price,
                              isUpgrader: false,
                              isShop: true,
                              onDelete: (id) {
                                // BsConfirmation().show(
                                //     context: context,
                                //     onYes: () {
                                //       AppExt.popScreen(context);
                                //       _removeProductTokoSayaCubit
                                //           .deleteProduct(productId: id);
                                //     },
                                //     title:
                                //         "Apakah anda yakin ingin menghapus produk dari katalog?");
                              },
                            );
                          },
                        ),
                        const SizedBox.shrink(),
                      ],
                    )
                  ]),
                ])),
      ),
    );
  }
}

class Products {
  final String image;
  final String commission;
  final String title;
  final String price;
  final String place;
  final int totalSold;

  const Products({
    @required this.image,
    @required this.commission,
    @required this.title,
    @required this.price,
    @required this.place,
    @required this.totalSold,
  });
}
