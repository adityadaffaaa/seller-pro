import 'package:flutter/material.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class ListReferralCategory extends StatefulWidget {
  const ListReferralCategory({Key key}) : super(key: key);

  @override
  State<ListReferralCategory> createState() => _ListReferralCategoryState();
}

class _ListReferralCategoryState extends State<ListReferralCategory> {
  final categories = [
    "Dropshipper",
    "Reseller",
    "Agent",
    "Distributor",
    "Contoh"
  ];

  int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final categoryText = categories[index];
          return InkWell(
            onTap: () => {
              setState(
                () {
                  currentIndex = index;
                },
              )
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.primary),
                  color: currentIndex == index
                      ? AppColor.primary
                      : AppColor.transparent),
              child: Center(
                child: Text(
                  categoryText,
                  style: AppTypo.category.copyWith(
                    color: currentIndex == index
                        ? AppColor.white
                        : AppColor.primary,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
