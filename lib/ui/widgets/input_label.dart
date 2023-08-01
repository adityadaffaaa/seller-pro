import 'package:flutter/material.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;

class InputLabel extends StatelessWidget {
  InputLabel({
    Key key,
    this.isRequired = true,
    this.isOptional = false,
    @required this.title,
  }) : super(key: key);

  final bool isRequired;
  final bool isOptional;
  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(color: AppColor.textPrimary),
        children: <TextSpan>[
          isOptional
              ? TextSpan(
                  text: " (optional)",
                  style: TextStyle(color: AppColor.grey.withOpacity(0.6)),
                )
              : TextSpan(
                  text: isRequired ? " *" : "",
                  style: TextStyle(color: AppColor.red),
                ),
        ],
      ),
    );
  }
}
