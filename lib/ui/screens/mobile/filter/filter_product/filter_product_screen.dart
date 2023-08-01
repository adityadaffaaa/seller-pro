import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:marketplace/data/blocs/new_cubit/products/filter_product/fetch_filter_location/fetch_filter_location_cubit.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/responsive_layout.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;

class FilterProductScreen extends StatefulWidget {
  const FilterProductScreen({Key key}) : super(key: key);

  @override
  State<FilterProductScreen> createState() => _FilterProductScreenState();
}

class _FilterProductScreenState extends State<FilterProductScreen> {
  FetchFilterLocationCubit _fetchFilterLocationCubit;

  ScrollController _scrollController = ScrollController(initialScrollOffset: 0);
  Timer _debounce;

  int cityId = 0;
  int citySelectedIndex = -1;

  @override
  void initState() {
    _fetchFilterLocationCubit = FetchFilterLocationCubit();
    super.initState();
  }

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
  void dispose() {
    _fetchFilterLocationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _fetchFilterLocationCubit),
      ],
      child: ResponsiveLayout(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            title: Text(
              "Filter",
              style: AppTypo.subtitle2,
            ),
            actions: [],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                AppExt.popScreen(context);
              },
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _screenWidth * (5 / 100)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("Lokasi", style: AppTypo.LatoBold),
                        SizedBox(
                          height: 5,
                        ),
                        EditText(
                          hintText: "Tulis nama kota",
                          controller: _fetchFilterLocationCubit
                              .locationFilterController,
                          onChanged: onSearchChanged,
                        ),
                        BlocBuilder(
                          bloc: _fetchFilterLocationCubit,
                          builder: (context, state) {
                            if (state is FetchFilterLocationLoading) {
                              return Center(
                                child: RefreshProgressIndicator(),
                              );
                            }
                            if (state is FetchFilterLocationFailure) {
                              return Text(state.message);
                            }
                            if (state is FetchFilterLocationSuccess) {
                              final items = state.location;
                              return SizedBox(
                                height: 300,
                                child: Scrollbar(
                                  controller: _scrollController,
                                  isAlwaysShown: true,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      controller: _scrollController,
                                      itemCount: items.city.length,
                                      itemBuilder: (context, i) {
                                        return ListTile(
                                            onTap: () {
                                              setState(() {
                                                cityId = items.city[i].id;
                                                citySelectedIndex = i;
                                              });
                                            },
                                            leading: Icon(
                                              Icons.location_on_outlined,
                                            ),
                                            title: Text(
                                              "${items.city[i].name}",
                                              style: AppTypo.body1Lato.copyWith(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            minLeadingWidth: 5,
                                            contentPadding: EdgeInsets.zero,
                                            trailing: citySelectedIndex == i
                                                ? Icon(
                                                    Ionicons
                                                        .ios_checkmark_circle_outline,
                                                    color: AppColor.primary,
                                                  )
                                                : null);
                                      }),
                                ),
                              );
                            }
                            return SizedBox();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: kIsWeb ? 5 : 10,
                      horizontal: _screenWidth * (5 / 100)),
                  child: RoundedButton.contained(
                      label: "Tampilkan",
                      textColor: AppColor.textPrimaryInverted,
                      isUpperCase: false,
                      onPressed: () {
                        AppExt.popScreen(
                            context, ValueFilter(cityId: cityId.toString()));
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ValueFilter {
  String cityId;

  ValueFilter({this.cityId});
}
