import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;

class TopupMenu extends StatelessWidget {
  const TopupMenu({Key key, @required this.section}) : super(key: key);

  final String section;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kIsWeb ? 15 : _screenWidth * (5 / 100), vertical: 15),
          child: Text(
            section,
            style: AppTypo.LatoBold.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
