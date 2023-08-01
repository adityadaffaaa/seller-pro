import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/models/new_models/new_cart.dart';
import 'package:marketplace/ui/screens/mobile/checkout/widgets/checkout_courier_item.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:shimmer/shimmer.dart';

class CheckoutItem extends StatefulWidget {
  CheckoutItem(
      {Key key, this.cart, this.courierSelected, this.enableCourier = false})
      : super(key: key);

  final List<NewCart> cart;
  final bool enableCourier;
  final void Function(
          int id, int price, int indexWidget, String shippingCode, String note)
      courierSelected;

  @override
  _CheckoutItemState createState() => _CheckoutItemState();
}

class _CheckoutItemState extends State<CheckoutItem> {
  List<TextEditingController> noteTec = [];

  @override
  void initState() {
    fillNoteController();

    super.initState();
  }

  void fillNoteController() {
    for (int i = 0; i < widget.cart.length; i++) {
      noteTec.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.cart.length,
        separatorBuilder: (_, index) {
          return Divider(
            thickness: 2,
          );
        },
        itemBuilder: (context, index1) {
          NewCart item = widget.cart[index1];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Seller Pro Official Store",
                  // item.nameSeller ?? "-",
                  style: AppTypo.LatoBold.copyWith(fontSize: 14)),
              Text("Surabaya",
                  // item.city ?? "-",
                  style: AppTypo.body1
                      .copyWith(fontSize: 14, color: AppColor.grey)),
              SizedBox(
                height: 14,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                //  item.product.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 2,
                ),
                itemBuilder: (context, index2) {
                  CartProduct cartProduct2 = item.product[index2];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                AppImg.img_product_1,
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              )
                              //  CachedNetworkImage(
                              //   imageUrl: cartProduct2.productPhoto,
                              //   memCacheHeight: Get.height > 350
                              //       ? (Get.height * 0.25).toInt()
                              //       : Get.height,
                              //   width: 65,
                              //   height: 47,
                              //   fit: BoxFit.cover,
                              //   placeholder: (context, url) => Shimmer.fromColors(
                              //     baseColor: Colors.grey[300],
                              //     highlightColor: Colors.grey[200],
                              //     period: Duration(milliseconds: 1000),
                              //     child: Container(
                              //       width: 65,
                              //       height: 47,
                              //       decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(10),
                              //           color: Colors.white),
                              //     ),
                              //   ),
                              //   errorWidget: (context, url, error) => Image.asset(
                              //     AppImg.img_error,
                              //     width: 67,
                              //     height: 47,
                              //   ),
                              // ),
                              ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Paket 1 Propolis Pro A Premium (4 Box)",
                                  // cartProduct2.name,
                                  style: AppTypo.body1v2
                                      .copyWith(fontWeight: FontWeight.w600),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                cartProduct2.productVariantName != null
                                    ? Text(cartProduct2.productVariantName)
                                    : SizedBox(),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Rp 540.000"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "1 Barang",
                                  // "${cartProduct2.quantity}x",
                                  style: AppTypo.body1v2
                                      .copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 12,
              ),
              Text("Catatan (opsional)", style: AppTypo.overline),
              SizedBox(
                height: 8,
              ),
              EditText(
                  controller: noteTec[index1],
                  textStyle: AppTypo.overline,
                  hintText: "Tambahkan catatan khusus",
                  inputType: InputType.field),
              SizedBox(
                height: 25,
              ),
              CheckoutCourierItem(
                supplierId: item.supplierId,
                cart: widget.cart,
                enableCourier: widget.enableCourier,
                onChoose: (
                  id,
                  price,
                  name,
                ) {
                  widget.courierSelected(
                      id, price, index1, name, noteTec[index1].text);
                },
              ),
              // SizedBox(
              //   height: 15,
              // ),
              // CheckoutVoucherItem()
            ],
          );
        },
      ),
    );
  }
}
