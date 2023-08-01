import 'package:flutter/material.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;

class ProgressBar extends StatelessWidget {
  ProgressBar({Key key, @required this.step}) : super(key: key);

  final int step;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            height: 18.0,
            decoration: BoxDecoration(
                color: AppColor.appPrimary,
                borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
        SizedBox(
          width: 4.0,
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            height: 18.0,
            decoration: BoxDecoration(
                color: step < 2 ? AppColor.lightGrey : AppColor.appPrimary,
                borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
        SizedBox(
          width: 4.0,
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            height: 18.0,
            decoration: BoxDecoration(
                color: step < 3 ? AppColor.lightGrey : AppColor.appPrimary,
                borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
      ],
    );
  }
}
