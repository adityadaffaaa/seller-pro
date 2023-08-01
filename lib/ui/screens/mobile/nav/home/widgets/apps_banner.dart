import 'package:flutter/material.dart';

class AppsBanner extends StatelessWidget {
  const AppsBanner({Key key, @required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Image(
        width: double.infinity,
        fit: BoxFit.cover,
        image: AssetImage(imageUrl),
      ),
    );
  }
}
