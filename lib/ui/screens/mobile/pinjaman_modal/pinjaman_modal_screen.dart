import 'package:flutter/material.dart';
import 'package:marketplace/ui/widgets/custom_app_bar.dart';

class CapitalLoan extends StatefulWidget {
  @override
  State<CapitalLoan> createState() => _CapitalLoanState();
}

class _CapitalLoanState extends State<CapitalLoan> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(
        title: "Dokumen Data Diri",
        web: (){},
        mobile: (){},
      ),
    );
  }
}
