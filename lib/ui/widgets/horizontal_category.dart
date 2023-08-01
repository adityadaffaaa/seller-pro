import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/data/models/new_models/category.dart';
import 'package:marketplace/data/models/new_models/home_category.dart';
import 'package:marketplace/ui/widgets/basic_card.dart';
import 'package:shimmer/shimmer.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;

class HorizontalCategory extends StatefulWidget {
  const HorizontalCategory(
      {Key key,
      @required this.homeCategory,
      this.onTap,
      this.categoryIdSelected})
      : super(key: key);

  final List<HomeCategory> homeCategory;
  final Function(int idCategory) onTap;
  final int categoryIdSelected;

  @override
  _HorizontalCategoryState createState() => _HorizontalCategoryState();
}

class _HorizontalCategoryState extends State<HorizontalCategory> {
  @override
  Widget build(BuildContext context) {
    int idCategory = widget.categoryIdSelected;
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: kIsWeb ? 10 : _screenWidth * (3 / 100)),
        itemCount: widget.homeCategory.length,
        itemBuilder: (ctx, idx) {
          HomeCategory homecategories = widget.homeCategory[idx];
          return InkWell(
            onTap: () {
              if (idCategory != homecategories.id) {
                setState(() {
                  idCategory = homecategories.id;
                });
                widget.onTap(homecategories.id);
              }
            },
            child: Container(
              width: 130,
              padding: EdgeInsets.all(8),
              margin:
                  EdgeInsets.only(right: kIsWeb ? 8 : _screenWidth * (2 / 100)),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(listDecor[idx]), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  idCategory == homecategories.id
                      ? Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                              color: idCategory == homecategories.id
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5)),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: idCategory == homecategories.id ? 3 : 0,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        FittedBox(
                          child: Container(
                            width: kIsWeb ? 72 : 68,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              homecategories.name,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: AppTypo.body2Lato
                                  .copyWith(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List listDecor = [
    "https://i.ibb.co/hBFFBkg/card-category.png",
    "https://i.ibb.co/GWmDsYG/card-category1.png",
    "https://i.ibb.co/1vK9Nz0/card-category2.png",
    "https://i.ibb.co/Yp4KqCh/card-category3.png",
    "https://i.ibb.co/L9LYFf9/card-category4.png",
    "https://i.ibb.co/xHfKSpZ/card-category5.png",
    "https://i.ibb.co/0t4w7cm/card-category6.png",
    "https://i.ibb.co/48z5zDH/card-category7.png",
    "https://i.ibb.co/j6Q5s5Z/card-category8.png",
    "https://i.ibb.co/jwqw8Br/card-category9.png",
  ];
}

class ShimmerHorizontalCategory extends StatelessWidget {
  const ShimmerHorizontalCategory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[200],
        period: Duration(milliseconds: 1000),
        child: Container(
            width: 130,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: _screenWidth * (5 / 100)),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: SizedBox()));
  }
}
