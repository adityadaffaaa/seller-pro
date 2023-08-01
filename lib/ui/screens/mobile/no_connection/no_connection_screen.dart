import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/data/blocs/new_cubit/check_network/check_network_cubit.dart';
import 'package:marketplace/ui/widgets/rounded_button.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BlocListener<CheckNetworkCubit, CheckNetworkState>(
        listener: (context, state) {
          if (state is CheckNetworkSuccess) {
            AppExt.popScreen(context, true);
          }
        },
        child: Scaffold(
          body: Container(
            child: Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: _screenWidth * (5/100), vertical: 125),
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Image.asset(
                      AppImg.img_product_error,
                      width: 300,
                    ),
                  Text(
                        "Tidak ada koneksi internet, periksa data maupun jaringan anda",
                        textAlign: TextAlign.center,
                        style: AppTypo.body1Lato
                            .copyWith(color: AppColor.textPrimary, fontSize: 18)),
                  SizedBox(height: 25,),
                  RoundedButton.contained(
                      label: "Refresh halaman",
                      isUpperCase: false,
                      onPressed: () {
                        context.read<CheckNetworkCubit>().checker();
                      })
              ],
            ),
                )),
          ),
        ),
      ),
    );
  }
}
