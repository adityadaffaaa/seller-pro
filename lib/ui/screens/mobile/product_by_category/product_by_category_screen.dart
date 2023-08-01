import 'package:animations/animations.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:beamer/beamer.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/fetch_home_categories/fetch_home_categories_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/products/fetch_products_by_category/fetch_products_by_category_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/models/new_models/home_category.dart'
    as homeCategoryModel;
import 'package:marketplace/ui/screens/mobile/cart_screen/cart_screen.dart';
import 'package:marketplace/ui/screens/mobile/filter/filter_product/filter_product_screen.dart';
import 'package:marketplace/ui/screens/mobile/search/search_screen.dart';
import 'package:marketplace/ui/widgets/grid_two_product_list_item.dart';
import 'package:marketplace/ui/widgets/shimmer_widget.dart';
import 'package:marketplace/ui/screens/mobile/screens.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/responsive_layout.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/transitions.dart' as AppTrans;

class ProductByCategoryScreen extends StatefulWidget {
  final int categoryId;

  const ProductByCategoryScreen({
    Key key,
    @required this.categoryId,
  }) : super(key: key);

  @override
  _ProductByCategoryScreenState createState() =>
      _ProductByCategoryScreenState();
}

class _ProductByCategoryScreenState extends State<ProductByCategoryScreen> {
  ScrollController listScrollController = ScrollController();
  FetchProductsByCategoryCubit _fetchProductsByCategoryCubit;
  FetchHomeCategoriesCubit _fetchHomeCategoriesCubit;

  List<homeCategoryModel.HomeCategory> horizontalCategory = [];
  int categoryId = 0;
  bool _showBackToTopButton = false;

  @override
  void initState() {
    categoryId = widget.categoryId;
    _fetchProductsByCategoryCubit = FetchProductsByCategoryCubit()
      ..fetchProductsByCategory(categoryId: widget.categoryId);
    _fetchHomeCategoriesCubit = FetchHomeCategoriesCubit()..load();
    listScrollController
      ..addListener(() {
        setState(() {
          if (listScrollController.offset >= 500) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    super.initState();
  }

  void _scrollToTop() {
    final position = listScrollController.position.minScrollExtent;
    listScrollController.animateTo(
      position,
      duration: Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _fetchProductsByCategoryCubit.close();
    _fetchHomeCategoriesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final userData = BlocProvider.of<UserDataCubit>(context).state.user;

    return WillPopScope(
      onWillPop: () async {
        if (kIsWeb) {
          AppExt.popScreen(context);
          AppExt.popScreen(context);
          return false;
        } else {
          return true;
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => _fetchProductsByCategoryCubit,
            ),
            BlocProvider(
              create: (_) => _fetchHomeCategoriesCubit,
            ),
          ],
          child: MultiBlocListener(
            listeners: [
              BlocListener(
                  bloc: _fetchHomeCategoriesCubit,
                  listener: (context, state) {
                    if (state is FetchHomeCategoriesSuccess) {
                      for (int i = 0;
                          i < state.homeCategories.length + 1;
                          i++) {
                        if (i == 0) {
                          horizontalCategory.add(homeCategoryModel.HomeCategory(
                              id: 0,
                              name: "Semua Kategori",
                              order: 0,
                              icon: "allcategory.svg"));
                        } else {
                          horizontalCategory.add(homeCategoryModel.HomeCategory(
                              id: state.homeCategories[i - 1].id,
                              name: state.homeCategories[i - 1].name,
                              order: state.homeCategories[i - 1].order,
                              icon: state.homeCategories[i - 1].icon));
                        }
                      }
                    }
                  })
            ],
            child: ResponsiveLayout(
              child: Scaffold(
                appBar: _buildAppBar(
                    context, _screenWidth, _fetchHomeCategoriesCubit),
                floatingActionButton: _showBackToTopButton == false
                    ? null
                    : FloatingActionButton(
                        onPressed: () {
                          if (listScrollController.hasClients) {
                            _scrollToTop();
                          }
                        },
                        isExtended: true,
                        tooltip: "Scroll to Top",
                        backgroundColor: AppColor.primary,
                        child: Icon(Ionicons.ios_arrow_round_up),
                      ),
                body: BlocBuilder(
                  bloc: _fetchProductsByCategoryCubit,
                  builder: (context, state) =>
                      AppTrans.SharedAxisTransitionSwitcher(
                    fillColor: Colors.transparent,
                    transitionType: SharedAxisTransitionType.vertical,
                    child: state is FetchProductsByCategoryLoading
                        ? MasonryGridView.count(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 15,
                            ),
                            crossAxisCount: 2,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return ShimmerProductItem();
                            },
                            mainAxisSpacing: 13,
                            crossAxisSpacing: 13,
                          )
                        : state is FetchProductsByCategoryFailure
                            ? Center(
                                child: ErrorFetch(
                                  message: state.message,
                                  onButtonPressed: () {
                                    _fetchProductsByCategoryCubit
                                        .fetchProductsByCategory(
                                            categoryId: widget.categoryId);
                                  },
                                ),
                              )
                            : state is FetchProductsByCategorySuccess
                                ? state.products.length > 0
                                    ? RefreshIndicator(
                                        color: AppColor.success,
                                        backgroundColor: AppColor.white,
                                        strokeWidth: 3,
                                        onRefresh: () =>
                                            _fetchProductsByCategoryCubit
                                                .fetchProductsByCategory(
                                                    categoryId:
                                                        widget.categoryId),
                                        child: MasonryGridView.count(
                                          controller: listScrollController,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15,
                                            horizontal: 15,
                                          ),
                                          crossAxisCount: 2,
                                          itemCount: state.products.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            Products _item =
                                                state.products[index];
                                            return GridTwoProductListItem(
                                              // product: _item,
                                              // isKomisi: _item.commission != 0,
                                              // isDiscount: _item.disc > 0,
                                              // isProductByCategory: true,
                                            );
                                          },
                                          mainAxisSpacing: 13,
                                          crossAxisSpacing: 13,
                                        ),
                                      )
                                    : Center(
                                        child: EmptyData(
                                          title: "Produk belum tersedia",
                                          subtitle:
                                              "Maaf, produk yang anda cari belum tersedia di wilayah anda",
                                          labelBtn: "Cari Produk Lain",
                                          onClick: () {
                                            BlocProvider.of<BottomNavCubit>(
                                                    context)
                                                .navItemTapped(0);
                                            AppExt.popUntilRoot(context);
                                          },
                                        ),
                                      )
                                : SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, double _screenWidth,
      FetchHomeCategoriesCubit fetchHomeCategoriesCub) {
    return AppBar(
      iconTheme: IconThemeData(color: AppColor.black),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: AppColor.textPrimaryInverted,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          if (kIsWeb) {
            context.beamToNamed("/");
          } else {
            BlocProvider.of<BottomNavCubit>(context).navItemTapped(0);
            AppExt.popUntilRoot(context);
          }
        },
      ),
      title: Container(
        height: 52,
        padding: EdgeInsets.only(top: 3),
        child: EditText(
          hintText: "Cari produk ...",
          inputType: InputType.search,
          fillColor: Color(0xFFF4F4F4),
          readOnly: true,
          onTap: () => AppExt.pushScreen(context, SearchScreen()),
        ),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
                padding: EdgeInsets.only(left: 8, top: 10, right: 8),
                constraints: BoxConstraints(),
                icon: Icon(
                  EvaIcons.bell,
                  size: 26,
                  color: AppColor.black,
                ),
                splashRadius: 2,
                onPressed: () {
                  // AppExt.pushScreen(
                  //   context,
                  //   BlocProvider.of<UserDataCubit>(context).state.user != null
                  //       ? CartScreen()
                  //       : SignInScreen(),
                  // );
                }),
            /*BlocProvider.of<UserDataCubit>(context).state.countCart != null &&
                    BlocProvider.of<UserDataCubit>(context).state.countCart > 0
                ? new Positioned(
                    right: 10,
                    top: -10,
                    child: Chip(
                      shape: CircleBorder(side: BorderSide.none),
                      backgroundColor: AppColor.red,
                      padding: EdgeInsets.zero,
                      labelPadding: BlocProvider.of<UserDataCubit>(context)
                                  .state
                                  .countCart >
                              99
                          ? EdgeInsets.all(2)
                          : EdgeInsets.all(4),
                      label: Text(
                        "${BlocProvider.of<UserDataCubit>(context).state.countCart}",
                        style: AppTypo.overlineInv.copyWith(fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : SizedBox.shrink(),*/
          ],
        ),
        Stack(
          children: [
            IconButton(
                padding: EdgeInsets.only(top: 10, right: 10),
                constraints: BoxConstraints(),
                icon: Icon(
                  EvaIcons.shoppingCart,
                  size: 26,
                  color: AppColor.black,
                ),
                onPressed: () {
                  kIsWeb
                      ? BlocProvider.of<UserDataCubit>(context).state.user !=
                              null
                          ? context.beamToNamed('/cart')
                          : context.beamToNamed('/signin')
                      : AppExt.pushScreen(
                          context,
                          BlocProvider.of<UserDataCubit>(context).state.user !=
                                  null
                              ? CartScreen()
                              : SignInScreen(),
                        );
                }),
            BlocProvider.of<UserDataCubit>(context).state.countCart != null &&
                    BlocProvider.of<UserDataCubit>(context).state.countCart > 0
                ? new Positioned(
                    right: kIsWeb ? 0 : -10,
                    top: kIsWeb ? -8 : -15,
                    child: Chip(
                      shape: CircleBorder(side: BorderSide.none),
                      backgroundColor: AppColor.red,
                      padding: EdgeInsets.zero,
                      labelPadding: BlocProvider.of<UserDataCubit>(context)
                                  .state
                                  .countCart >
                              99
                          ? EdgeInsets.all(2)
                          : EdgeInsets.all(4),
                      label: Text(
                        "${BlocProvider.of<UserDataCubit>(context).state.countCart}",
                        style: AppTypo.overlineInv.copyWith(fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Column(
          children: [
            BlocBuilder(
                bloc: _fetchHomeCategoriesCubit,
                builder: (context, fetchHomeCategoriesState) {
                  return fetchHomeCategoriesState is FetchHomeCategoriesLoading
                      ? Container(
                          height: 60,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(
                                  left: _screenWidth * (5 / 100)),
                              itemCount: 6,
                              itemBuilder: (ctx, idx) {
                                return ShimmerHorizontalCategory();
                              }),
                        )
                      : fetchHomeCategoriesState is FetchHomeCategoriesFailure
                          ? Center(
                              child: Text('kategori gagal dimuat'),
                            )
                          : fetchHomeCategoriesState
                                  is FetchHomeCategoriesSuccess
                              ? HorizontalCategory(
                                  categoryIdSelected: categoryId,
                                  homeCategory: horizontalCategory,
                                  onTap: (int idCategory) {
                                    setState(() {
                                      categoryId = idCategory;
                                    });
                                    _fetchProductsByCategoryCubit
                                        .fetchProductsByCategory(
                                            categoryId: idCategory ?? 0);
                                  },
                                )
                              : SizedBox.shrink();
                }),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _screenWidth * (5 / 100), vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      ValueFilter filterProduct = await AppExt.pushScreen(
                          context, const FilterProductScreen());
                      if (filterProduct != null) {
                        _fetchProductsByCategoryCubit.fetchFilterProducts(
                            cityId: filterProduct.cityId);
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          EvaIcons.funnel,
                          size: 28,
                          color: AppColor.primary,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Filter",
                            style: AppTypo.body1.copyWith(
                              fontSize: 13,
                              color: AppColor.primary,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
