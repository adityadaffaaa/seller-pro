import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketplace/data/blocs/new_cubit/products/fetch_product_recom/fetch_product_recom_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/new_repositories/recipent_repository.dart';
import 'package:marketplace/ui/screens/mobile/product_detail/widget/product_description.dart';
import 'package:marketplace/ui/widgets/bs_copywriting.dart';
import 'package:marketplace/ui/widgets/data_table.dart';
import 'package:marketplace/ui/widgets/filled_button.dart';
import 'package:marketplace/ui/widgets/horizontal_product_list.dart';
import 'package:marketplace/ui/widgets/variant_rounded_container.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;

import 'rounded_container.dart';

class DetailScreenList extends StatefulWidget {
  const DetailScreenList({
    Key key,
    // @required this.product,
    this.product,
    this.onVariantSelected,
    // @required this.recipentMainAddress,
    this.recipentMainAddress,
  }) : super(key: key);

  final Products product;
  final Recipent recipentMainAddress;
  final Function(int id, ProductVariant productVariantSelected)
      onVariantSelected;

  @override
  _DetailScreenListState createState() => _DetailScreenListState();
}

class _DetailScreenListState extends State<DetailScreenList> {
  final RecipentRepository recipentRepo = RecipentRepository();
final ScrollController _scrollController = ScrollController();

  bool isUser;
  bool isReseller;
  int variantSelectedId = 0;

  ProductVariant _productVariant;

  // List<ProductVariant> _listProductVariant=[];

  @override
  void initState() {
    super.initState();
    _productVariant = widget.product.productVariant.length > 0
        ? widget.product.productVariant[0]
        : null;
    variantSelectedId = widget.product.productVariant.length > 0
        ? widget.product.productVariant[0].id
        : 0;
    // initProductVariant();
  }

  // void initProductVariant(){
  //   for (int i = 0; i < widget.product.productVariant.length; i++) {
  //     _listProductVariant.add(widget.product.productVariant[i]);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    final userData = BlocProvider.of<UserDataCubit>(context).state.user != null
        ? BlocProvider.of<UserDataCubit>(context).state.user
        : null;

    isUser = userData != null;
    isReseller = isUser ? userData.reseller != null : false;

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // "${widget.product.name} ${widget.product.productVariant.length > 0 ? _productVariant.variantName : ""}",
                  "Paket 1 Propolis Pro A Premium (4 Box)",
                  // widget.product.name,
                  style:
                      AppTypo.subtitle1.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Rp 499.000",
                          // widget.product.productVariant.length > 0
                          //     ? 'Rp ${AppExt.toRupiah((_productVariant.variantFinalPrice))}'
                          //     : 'Rp ${AppExt.toRupiah(widget.product.discPrice != 0 ? widget.product.discPrice : widget.product.sellingPrice)}',
                          style: AppTypo.subtitle1.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RoundedContainer(
                          fillColor: Color(0x3300AE8F),
                          child: Image.asset(
                            AppImg.ic_truck,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dikirim Dari",
                              style: AppTypo.caption,
                            ),
                            Text(
                              "Bojonegoro",
                              // "${widget.product.supplier.city}",
                              style: AppTypo.caption
                                  .copyWith(color: Color(0xFF00AE8F)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                widget.product.productVariant.length > 0 &&
                        _productVariant.variantDisc != 0
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
                              "30%",
                              // "${_productVariant.variantDisc ?? 0}%",
                              style: AppTypo.overline.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.red),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: Text("Rp 20.000",
                                // "Rp ${AppExt.toRupiah(_productVariant.variantSellPrice ?? 0)}",
                                maxLines: kIsWeb ? null : 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypo.captionAccent.copyWith(
                                    decoration: TextDecoration.lineThrough)),
                          ),
                        ],
                      )
                    : widget.product.disc != 0
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
                                  "20%",
                                  // "${widget.product.disc ?? 0}%",
                                  style: AppTypo.overline.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.red),
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                child: Text("Rp 20.000",
                                    // "Rp ${AppExt.toRupiah(widget.product.sellingPrice ?? 0)}",
                                    maxLines: kIsWeb ? null : 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypo.captionAccent.copyWith(
                                        decoration:
                                            TextDecoration.lineThrough)),
                              ),
                            ],
                          )
                        : SizedBox(),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.star_fill,
                      color: Colors.orangeAccent,
                      size: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "4.9",
                      style:
                          AppTypo.caption.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "(134 ulasan)",
                      style: AppTypo.caption.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          isUser &&
                  isReseller &&
                  widget.product.isBeliLangsung != 1 &&
                  widget.product.isLangganan != 1
              ? Divider(
                  thickness: 7,
                  color: Color(0xFFEBECED),
                )
              : SizedBox(),
          isReseller &&
                  widget.product.isBeliLangsung == 0 &&
                  widget.product.isLangganan == 0
              ? Padding(
                  padding: EdgeInsets.only(top: 10, left: 16, right: 16),
                  child: Row(
                    children: [
                      Text("Komisi"),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Rp " + AppExt.toRupiah(widget.product.commissionPrice),
                        style: AppTypo.overline.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColor.red,
                            fontSize: 12),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
          !isUser
              ? SizedBox()
              : Divider(
                  thickness: 7,
                  color: Color(0xFFEBECED),
                ),
          !isUser
              ? SizedBox()
              : Container(
                  margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                  child: Row(
                    children: [
                      Icon(EvaIcons.pinOutline),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Domisili Anda ",
                        style: AppTypo.caption,
                      ),
                      widget.recipentMainAddress != null
                          ? Container(
                              constraints: const BoxConstraints(maxWidth: 160),
                              child: Text(
                                " ${widget.recipentMainAddress.subdistrict}" ??
                                    " -",
                                style: AppTypo.caption.copyWith(
                                    color: Theme.of(context).primaryColor),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            )
                          : Text(
                              recipentRepo.getSelectedSubdistrictStorage() !=
                                      null
                                  ? recipentRepo
                                          .getSelectedSubdistrictStorage()[
                                      'subdistrict']
                                  : ' -',
                              style: AppTypo.caption.copyWith(
                                  color: Theme.of(context).primaryColor),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                    ],
                  ),
                ),
          !isUser ? SizedBox() : SizedBox(height: 10),
          widget.product.productVariant.length > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      thickness: 7,
                      color: Color(0xFFEBECED),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pilih Varian : ",
                            style: AppTypo.subtitle1
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Pilih varian terlebih dahulu",
                            style:
                                AppTypo.latoSmall.copyWith(color: AppColor.red),
                          ),
                          // List Varian
                          SizedBox(
                            height: 50,
                            child: ListView(
                              padding: const EdgeInsets.all(6),
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (var i = 0;
                                    i < 10;
                                    // widget.product.productVariant.length;
                                    i++)
                                  VariantRoundedContainer(
                                    title:
                                        "Paket 1 Propolis Pro A Premium (4 Box)",
                                    isSelected: false,
                                    onTap: () {},
                                    // title: widget
                                    //     .product.productVariant[i].variantName,
                                    // isSelected: variantSelectedId ==
                                    //     widget.product.productVariant[i].id,
                                    // onTap: () {
                                    //   setState(() {
                                    //     variantSelectedId =
                                    //         widget.product.productVariant[i].id;
                                    //     _productVariant =
                                    //         widget.product.productVariant[i];
                                    //   });
                                    //   widget.onVariantSelected(
                                    //       widget.product.productVariant[i].id,
                                    //       _productVariant);
                                    // },
                                  ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 50,
                          //   child: ListView.builder(
                          //     padding: EdgeInsets.symmetric(vertical: 7),
                          //     shrinkWrap: true,
                          //     scrollDirection: Axis.horizontal,
                          //     itemCount: widget.product.productVariant.length,
                          //     itemBuilder: (context, index) {
                          //       ProductVariant productVariant =
                          //           widget.product.productVariant[index];

                          //       return VariantRoundedContainer(
                          //         title: productVariant.variantName,
                          //         isSelected:
                          //             variantSelectedId == productVariant.id,
                          //         onTap: () {
                          //           setState(() {
                          //             variantSelectedId = productVariant.id;
                          //             _productVariant = productVariant;
                          //           });
                          //           widget.onVariantSelected(
                          //               productVariant.id, _productVariant);
                          //         },
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          Divider(
            thickness: 7,
            color: Color(0xFFEBECED),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: _screenWidth * (2 / 100), vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 8,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppImg.ic_shop_fill,
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          "Paket 1 Propolis Pro A Premium (4 Box)",
                          style: AppTypo.caption
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      // Expanded(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         "${widget.product.supplier.name ?? "-"}",
                      //         style: AppTypo.caption
                      //             .copyWith(fontWeight: FontWeight.w600),
                      //       ),
                      //       Text(
                      //         "${widget.product.supplier.city ?? "-"}",
                      //         style: AppTypo.caption
                      //             .copyWith(fontWeight: FontWeight.w400),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                // Flexible(
                //   flex: 4,
                //   child: Container(
                //     margin: EdgeInsets.only(right: 16),
                //     child: MaterialButton(
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(5.0),
                //           side: BorderSide(color: AppColor.primary)),
                //       onPressed: () {
                //         _launchUrl(context, "https://warung.panenpanen.id/wpp/dashboard/${product.reseller.slug}");
                //       },
                //       child: Text(
                //         "Kunjungi Toko",
                //         style: AppTypo.caption.copyWith(color: AppColor.primary),
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Divider(
            thickness: 7,
            color: Color(0xFFEBECED),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 13,
                ),
                Text(
                  "Deskripsi",
                  style:
                      AppTypo.subtitle1.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8,
                ),
                dataTable.description(
                  "Berat",
                  "250 Gram",
                  // widget.product.productVariant.length > 0
                  //     ? "${_productVariant.variantWeight} ${_productVariant.variantUnit}"
                  //     : "${widget.product.weight} ${widget.product.unit}",
                  AppTypo.caption,
                  null,
                ),
                SizedBox(
                  height: 3,
                ),
                dataTable.description(
                  "Kategori",
                  "Kesehatan",
                  // "${widget.product.categoryName}",
                  AppTypo.caption.copyWith(
                      color: AppColor.primary, fontWeight: FontWeight.w600),
                  () {},
                ),
                SizedBox(
                  height: 3,
                ),
                ProductDescription(
                    description:
                        "Propolis Pro A Premium merupakan produk seri Premium dari Pro A, adalah produk Minuman Kesehatan dengan kekuatan Sinergi 3 Herbal Penyembuh dan Sistem Immune Booster"
                    // widget.product.productVariant.length > 0
                    //     ? widget.product.description
                    //     : widget.product.description ?? '-',
                    ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 7,
            color: Color(0xFFEBECED),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 13,
                ),
                Text(
                  "Komisi Penjualan",
                  style:
                      AppTypo.subtitle1.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Berikut adalah daftar komisi penjualan yang akan anda dapatkan berdasarkan level membership. ",
                  style: AppTypo.caption,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                      dataRowHeight: 30,
                      headingRowHeight: 30,
                      // headingRowColor: MaterialStatePropertyAll(
                      //   AppColor.lightGrey,
                      // ),
                      border: TableBorder.all(
                        color: AppColor.grey.withOpacity(0.4),
                      ),
                      columns: [
                        DataColumn(
                            label: Text(
                          "Level Membership",
                          style: AppTypo.latoRegularSemiBold.copyWith(
                            color: AppColor.black,
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          "Komisi Penjualan",
                          style: AppTypo.latoRegularSemiBold.copyWith(
                            color: AppColor.black,
                          ),
                        ))
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(
                            Text(
                              "Referral Langsung",
                              style: AppTypo.latoRegular.copyWith(
                                color: AppColor.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              "Rp 5.000",
                              style: AppTypo.latoRegular.copyWith(
                                color: AppColor.black,
                              ),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text(
                              "Tier 1",
                              style: AppTypo.latoRegular.copyWith(
                                color: AppColor.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              "Rp 2.000",
                              style: AppTypo.latoRegular.copyWith(
                                color: AppColor.black,
                              ),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text(
                              "Tier 2",
                              style: AppTypo.latoRegular.copyWith(
                                color: AppColor.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              "Rp 1.000",
                              style: AppTypo.latoRegular.copyWith(
                                color: AppColor.black,
                              ),
                            ),
                          ),
                        ]),
                      ]),
                )
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Divider(
            thickness: 7,
            color: Color(0xFFEBECED),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Komisi Penjualan",
                  style:
                      AppTypo.subtitle1.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Klik tombol dibawah untuk mengakses marketing kit. Marketing kit berisi gambar/video yang dapat Anda gunakan untuk mempromosikan produk.",
                  style: AppTypo.caption,
                ),
                const SizedBox(
                  height: 8,
                ),
                FilledButton(
                  color: AppColor.primary,
                  onPressed: () => null,
                  child: Text(
                    "Lihat Marketing Kit",
                    style: AppTypo.interVerySmall.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                  rounded: 5,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 7,
            color: Color(0xFFEBECED),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Copywriting",
                  style:
                      AppTypo.subtitle1.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                ListView.separated(
                  itemCount: 6,
                  shrinkWrap: true,
                  controller: _scrollController,
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 1,
                    );
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => BsCopywriting.show(
                        context,
                        title: "PRODUCT KNOWLEDGE - PROPOLIS PRO A PREMIUM",
                        description:
                            "*Sehat Fisik dan Sehat Finansial*\n\nKesehatan adalah harta yang sangat berharga bagi siapa pun yang ingin menjalani kehidupan dengan sebaik-baiknya.\n\nKini, telah hadir formula terbaru, *Propolis Pro A Premium* kemasan ampul 5 ml yang praktis dan higienes. Suplemen ini dibuat dari 100% herbal yang menggabungkan manfaat *Propolis, Habbatussauda (Jintan Hitam)* dan *Black Garlic (Bawang Hitam)*.\n\nSangat bermanfaat untuk membantu meningkatkan *Sistem Kekebalan Tubuh* dan melancarkan *Sistem Peredaran Darah*, agar kita bisa terhindar atau terbebas dari berbagai penyakit seperti *Diabetes, Stroke, Kolesterol, Asam Lambung, Jantung dan sebagainya.*\n\nSimak penjelasan ilmiahnya di:\n\n https://www.youtube.com/watch?v=Zt_m9B6ptBk\n\nDengan membeli 40 box Propois Pro A Premium, Anda akan mendapatkan GRATIS 8 box. Selain itu, Anda juga berhak untuk menjadi Distributor dari produk ini dan memiliki peluang mendapatkan berbagai komisi yang bisa menjadi sumber penghasilan baru dan passive income bagi Anda. Silahkan hubungi orang yang memberikan informasi ini. \n\nYuk, sehat fisik dan sehat finansial bersama Propolis Pro A Premium:\n\n LINK PEMBELIAN PRO A DI APLIKASI - PAKET DISTRIBUTOR\n\n Info lebih lanjut, hubungi:\n\nNAMA AFFILIATE (http://wa.me/NOMOR WA AFFILIATE)",
                        onCopy: () => null,
                        onShare: () => null,
                      ),
                      child: ListTile(
                        leading: Text(
                          "PRODUCT KNOWLEDGE - PROPOLIS PRO A PREMIUM",
                          style: AppTypo.latoRegular.copyWith(
                            color: AppColor.black,
                          ),
                        ),
                        trailing: Icon(
                          EvaIcons.arrowIosForwardOutline,
                          color: AppColor.grey,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 7,
            color: Color(0xFFEBECED),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              HorizontalProductList(
                section: "Produk yang mungkin anda cari",
                viewAll: null,
              )
            ],
          ),
          /*Divider(
          thickness: 7,
          color: Color(0xFFEBECED),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Ulasan Pembeli",
                      style: AppTypo.subtitle1
                          .copyWith(fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: () {
                      AppExt.pushScreen(context, CommentScreen());
                    },
                    child: Text(
                      "Lihat Semua",
                      style: AppTypo.caption.copyWith(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.star_fill,
                    color: Colors.orangeAccent,
                    size: 30,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "4.9",
                    style: AppTypo.subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Text(
                    "dari 134 ulasan",
                    style: AppTypo.caption.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  for (var i = 0; i <= 4; i++)
                    Icon(
                      CupertinoIcons.star_fill,
                      color: Colors.orangeAccent,
                      size: 20,
                    )
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(
                    "Rusmini",
                    style: AppTypo.caption,
                  ),
                  Text(
                    " • ",
                    style: AppTypo.caption.copyWith(color: Colors.grey),
                  ),
                  Text(
                    "30 Apr",
                    style: AppTypo.caption.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "Pengiriman cepat dan bahannya bagus banget",
                style: AppTypo.caption,
              ),
            ],
          ),
        ),*/
        ],
      ),
    );
  }
}
