import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:marketplace/ui/widgets/grid_two_product_list_item.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class AccountUpgradeMemberScreen extends StatelessWidget {
  AccountUpgradeMemberScreen({Key key}) : super(key: key);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 1,
        shadowColor: AppColor.lightGrey,
        centerTitle: true,
        titleSpacing: 10,
        leading: IconButton(
          onPressed: () => AppExt.popScreen(context),
          icon: Icon(
            AntDesign.arrowleft,
            color: AppColor.black,
          ),
        ),
        title: Text(
          "Yuk Gabung Seller Pro",
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
                      isUpgrader: true,
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
                  }),
              const SizedBox.shrink(),
            ],
          ),
        ),
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
