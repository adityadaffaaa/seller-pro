import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class ProductDescription extends StatefulWidget {
  const ProductDescription({Key key, @required this.description})
      : super(key: key);

  final String description;

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _expand = false;

  @override
  Widget build(BuildContext context) {
    final desc = widget.description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          desc,
          style: AppTypo.caption,
          overflow: TextOverflow.ellipsis,
          maxLines: _expand ? 20 : 3,
        ),
        SizedBox(height: 2),
        LayoutBuilder(builder: (context, constraints) {
          final numLines = _calculateNumLines(desc, constraints);

          print("numLines ${numLines}");
          if(numLines > 3) {
            return TextButton(
              onPressed: () {
                setState(() {
                  _expand = !_expand;
                });
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  overlayColor: MaterialStateProperty.all(Colors.transparent)
              ),
              child: Text(
                !_expand ? "Lihat Selengkapnya" : "Sembunyikan",
                style: AppTypo.caption.copyWith(color: AppColor.primary),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        })
        // (expanded && kIsWeb) || (!expanded && !kIsWeb)
        //   ? SizedBox.shrink()
        //   : (!expanded && kIsWeb) || (expanded && !kIsWeb)
        //     ? TextButton(
        //         onPressed: () {
        //           setState(() {
        //             _expand = !_expand;
        //           });
        //         },
        //         style: ButtonStyle(
        //             padding: MaterialStateProperty.all(EdgeInsets.zero),
        //             overlayColor: MaterialStateProperty.all(Colors.transparent)
        //         ),
        //         child: Text(
        //           !_expand ? "Lihat Selengkapnya" : "Sembunyikan",
        //           style: AppTypo.caption.copyWith(color: AppColor.primary),
        //         ),
        //       )
        //     : SizedBox.shrink()
      ],
    );
  }

  int _calculateNumLines(String text, constraints) {
    var _screenWidth = MediaQuery.of(context).size.width;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: AppTypo.caption),
      //maxLines: 3,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: constraints.maxWidth);
    return textPainter.computeLineMetrics().length;
    // return textPainter.didExceedMaxLines;
  }
}
