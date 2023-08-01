import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:marketplace/ui/widgets/grid_two_product_list_item.dart';

import 'package:marketplace/utils/images.dart' as app_img;
import 'package:marketplace/utils/typography.dart' as app_typo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class ProductCatalogSection extends StatefulWidget {
  ProductCatalogSection({Key key}) : super(key: key);

  @override
  State<ProductCatalogSection> createState() => _ProductCatalogSectionState();
}

class _ProductCatalogSectionState extends State<ProductCatalogSection> {
  final _scrollController = ScrollController();

  final products = [
    const Products(
      image: app_img.img_product_1,
      commission: "1.620.000",
      title: "Paket 1 Propolis Pro A Premium (4 Box)",
      price: "540.000",
      place: "Surabaya",
      totalSold: 206,
    ),
    const Products(
      image: app_img.img_product_2,
      commission: "1.620.000",
      title: "Paket 1 Propolis Pro A Premium (4 Box)",
      price: "540.000",
      place: "Surabaya",
      totalSold: 206,
    ),
    const Products(
      image: app_img.img_product_3,
      commission: "1.620.000",
      title: "Paket 1 Propolis Pro A Premium (4 Box)",
      price: "540.000",
      place: "Surabaya",
      totalSold: 206,
    ),
    const Products(
      image: app_img.img_product_4,
      commission: "1.620.000",
      title: "Paket 1 Propolis Pro A Premium (4 Box)",
      price: "540.000",
      place: "Surabaya",
      totalSold: 206,
    ),
    const Products(
      image: app_img.img_product_5,
      commission: "1.620.000",
      title: "Paket 1 Propolis Pro A Premium (4 Box)",
      price: "540.000",
      place: "Surabaya",
      totalSold: 206,
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
            "Katalog Produk",
            style: app_typo.interSmallSemiBold.copyWith(
              color: AppColor.black,
            ),
          ),
          AlignedGridView.count(
            controller: _scrollController,
            shrinkWrap: true,
            padding: EdgeInsets.only(
              top: kIsWeb ? 0 : 20,
              left: kIsWeb ? 24 : screenWidth * (1 / 100),
              right: kIsWeb ? 24 : screenWidth * (1 / 100),
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
                onDelete: (id) {},
              );
            },
          ),
          const SizedBox.shrink(),
        ],
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
