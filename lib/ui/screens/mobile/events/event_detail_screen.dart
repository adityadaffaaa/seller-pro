import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/ui/widgets/custom_app_bar.dart';
import 'package:marketplace/utils/responsive_layout.dart';

import 'package:marketplace/utils/extensions.dart' as AppExt;

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({Key key}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    // TODO: implement build
    return ResponsiveLayout(
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            title: "Detail Event",
            elevation: 0.5,
            mobile: () => AppExt.popScreen(context),
            web: () => context.beamBack(),
          ),
        ),
      ),
    );
  }
}
