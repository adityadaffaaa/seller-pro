import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class DetailPesananItemMenungguPembayaran extends StatelessWidget {
  const DetailPesananItemMenungguPembayaran({
    Key key,
    @required this.image,
    @required this.itemName,
    @required this.qtyItem,
    @required this.priceItem,
    @required this.variantPrice,
  }) : super(key: key);

  final String image;
  final String itemName;
  final String qtyItem;
  final String priceItem;
  final String variantPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  image,
                  height: 50,
                  width: 50,
                )),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style:
                        AppTypo.caption.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    priceItem,
                    style: AppTypo.caption,
                  ),
                ],
              ),
            ),
            Text(
              qtyItem,
              style: AppTypo.caption,
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
