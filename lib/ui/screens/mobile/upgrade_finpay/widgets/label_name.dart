import 'package:flutter/material.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;

class LabelName extends StatelessWidget {
  const LabelName({Key key, @required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTypo.body1,
        children: <TextSpan>[
          TextSpan(text: label),
          const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}
