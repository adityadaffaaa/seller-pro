import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:marketplace/data/blocs/new_cubit/products/filter_product/fetch_filter_location/fetch_filter_location_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/region/fetch_regions/fetch_regions_cubit.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/ui/widgets/rounded_button.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class BSFilterProduct {
  const BSFilterProduct();

  static Future show(BuildContext context,
      {bool isDismissible = true,
      Function(String sortBy, String lowPriceRange, String highPriceRange,
              String cityId)
          onFilter}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    AppExt.hideKeyboard(context);
    await showModalBottomSheet(
        constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
        isDismissible: isDismissible,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return BSFilterProductItem(
            onFilter: onFilter,
          );
        });
    return;
  }
}

class BSFilterProductItem extends StatefulWidget {
  const BSFilterProductItem({Key key, @required this.onFilter})
      : super(key: key);

  final Function(String sortBy, String lowPriceRange, String highPriceRange,
      String cityId) onFilter;

  @override
  _BSFilterProductItemState createState() => _BSFilterProductItemState();
}

class _BSFilterProductItemState extends State<BSFilterProductItem> {
  @override
  void initState() {
    // _getProvince();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SingleChildScrollView(
        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Center(
                child: Container(
                  width: _screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Filter",
                    style: AppTypo.LatoBold,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Lokasi", style: AppTypo.body1Lato),
                  // Text("Lihat Semua",
                  //     style: AppTypo.LatoBold.copyWith(
                  //         fontSize: 10, color: AppColor.primary)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FilterLocation(),
              SizedBox(
                height: 10,
              ),
              RoundedButton.contained(
                  label: "Tampilkan",
                  textColor: AppColor.textPrimaryInverted,
                  isUpperCase: false,
                  onPressed: () {
                    AppExt.popScreen(context);
                  }),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FilterLocation extends StatefulWidget {
  const FilterLocation({Key key}) : super(key: key);

  @override
  _FilterLocationState createState() => _FilterLocationState();
}

class _FilterLocationState extends State<FilterLocation> {
  FetchFilterLocationCubit _fetchFilterLocationCubit;

  Timer _debounce;

  onSearchChanged(String keyword) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      AppExt.hideKeyboard(context);
      if (keyword.isNotEmpty) {
        _fetchFilterLocationCubit.fetchLocation(keyword: keyword);
      }
    });
  }

  @override
  void initState() {
    _fetchFilterLocationCubit = FetchFilterLocationCubit();
    super.initState();
  }

  @override
  void dispose() {
    _fetchFilterLocationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _fetchFilterLocationCubit),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditText(
            hintText: "Tulis nama kota",
            controller: _fetchFilterLocationCubit.locationFilterController,
            onChanged: onSearchChanged,
          ),
          BlocBuilder<FetchFilterLocationCubit, FetchFilterLocationState>(
            builder: (context, state) {
              if (state is FetchFilterLocationLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FetchFilterLocationFailure) {
                return Text("Failure");
              }
              if (state is FetchFilterLocationSuccess) {
                final items = state.location;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.city.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        onTap: () {
                          AppExt.popScreen(context);
                        },
                        leading: Icon(
                          Icons.location_on_outlined,
                        ),
                        title: Text(
                          "${items.city[i].name}",
                          style: AppTypo.body1Lato
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        minLeadingWidth: 5,
                        contentPadding: EdgeInsets.zero,
                      );
                    });
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
