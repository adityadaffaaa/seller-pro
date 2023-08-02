import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/api/api_provider.dart';
import 'package:marketplace/data/blocs/app_info/app_info_cubit.dart';
import 'package:marketplace/data/blocs/fetch_categorysub/fetch_categorysub_cubit.dart';
import 'package:marketplace/data/blocs/fetch_home_categories/fetch_home_categories_cubit.dart';
import 'package:marketplace/data/blocs/fetch_home_slider/fetch_home_slider_cubit.dart';
import 'package:marketplace/data/blocs/fetch_user/fetch_user_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/check_network/check_network_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/products/fetch_products/fetch_products_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/products/fetch_products_by_category/fetch_products_by_category_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/recipent/fetch_selected_recipent/fetch_selected_recipent_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/new_models/home_category.dart';
import 'package:marketplace/data/models/new_models/products.dart';
import 'package:marketplace/data/models/new_models/recipent.dart';
import 'package:marketplace/data/repositories/authentication_repository.dart';
import 'package:marketplace/data/repositories/new_repositories/recipent_repository.dart';
import 'package:marketplace/ui/screens/mobile/cart_screen/cart_screen.dart';
import 'package:marketplace/ui/screens/mobile/credentials/sign_in_screen.dart';
import 'package:marketplace/ui/screens/mobile/nav/home/widgets/apps_banner.dart';
import 'package:marketplace/ui/screens/mobile/nav/home/widgets/bs_delivery_address.dart';
import 'package:marketplace/ui/screens/mobile/nav/home/widgets/handling_recipent_overlay.dart';
import 'package:marketplace/ui/screens/mobile/nav/home/widgets/hero_section.dart';
import 'package:marketplace/ui/screens/mobile/nav/home/widgets/invite_friends_section.dart';
import 'package:marketplace/ui/screens/mobile/nav/home/widgets/product_catalog_section.dart';
import 'package:marketplace/ui/screens/mobile/nav/home/widgets/sections/banner/push_product_banner.dart';
import 'package:marketplace/ui/screens/mobile/nav/home/widgets/sections/recipents/selected_recipent.dart';
import 'package:marketplace/ui/screens/mobile/nav/home/widgets/service_category_menu.dart';
import 'package:marketplace/ui/screens/mobile/nav/home/widgets/work_team_section.dart';
import 'package:marketplace/ui/screens/mobile/no_connection/no_connection_screen.dart';
import 'package:marketplace/ui/screens/mobile/search/search_screen.dart';
import 'package:marketplace/ui/screens/mobile/view_all/products/view_all_product_screen.dart';
import 'package:marketplace/ui/widgets/alert_dialog.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/ui/widgets/fetch_conditions.dart';
import 'package:marketplace/ui/widgets/horizontal_agenda_list.dart';
import 'package:marketplace/ui/widgets/horizontal_category_list.dart';
import 'package:marketplace/ui/widgets/horizontal_product_list.dart';
import 'package:marketplace/ui/widgets/shimmer_widget.dart';
import 'package:marketplace/ui/widgets/ui_debug_switcher.dart';

/* EXTENSIONS */
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/colors.dart' as AppColor;

class HomeNav extends StatefulWidget {
  const HomeNav({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> with TickerProviderStateMixin {
  int categoryId = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final AuthenticationRepository _authRepository = AuthenticationRepository();
  final RecipentRepository _recipentRepository = RecipentRepository();
  final ApiProvider _apiProvider = ApiProvider();

  /* Animation */
  AnimationController _colorAnimationController;
  Animation<Color> _backgroundColorTween;

  /* CUBIT */
  FetchProductsCubit _fetchFlashSaleCubit,
      _fetchPromoCubit,
      _fetchBestSellCubit;
  FetchProductsByCategoryCubit _fetchProductsByCategoryCubit;
  FetchSelectedRecipentCubit _fetchSelectedRecipent;
  FetchHomeSliderCubit _fetchHomeSliderCubit;
  FetchHomeCategoriesCubit _fetchHomeCategoriesCubit;
  FetchCategorysubCubit _fetchCategorysubCubit;
  FetchUserCubit _fetchUserCubit;

  List<HomeCategory> categoryTemp = [];

// static data
  final agendas = [
    const Agenda(
      image: AppImg.img_agenda_1,
      judul: "UMKM Go Online: Trik Jitu Jualan Laris Manis di Marketplace",
      time: "16.00 - 17.00",
      date: "31 Jan 2023",
    ),
    const Agenda(
      image: AppImg.img_agenda_2,
      judul: "UMKM Go Ekspor! Tahapan Memulai Ekspor untuk UMKM",
      time: "16.00 - 17.00",
      date: "01 Feb 2023",
    ),
    const Agenda(
      image: AppImg.img_agenda_3,
      judul: "Optimalkan Bisnis UMKM dengan Kata Kunci yang Tepat",
      time: "16.00 - 17.00",
      date: "05 Jan 2023",
    ),
  ];

  @override
  void dispose() {
    _fetchFlashSaleCubit.close();
    _fetchPromoCubit.close();
    _fetchBestSellCubit.close();
    _fetchHomeSliderCubit.close();
    _fetchHomeCategoriesCubit.close();
    _fetchCategorysubCubit.close();
    _fetchProductsByCategoryCubit.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<CheckNetworkCubit>().checker();
    context.read<AppInfoCubit>().load();
    context.read<UserDataCubit>().loadUser();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkHaveMainAddress();
    });
    // TODO: implement initState
    _fetchHomeSliderCubit = FetchHomeSliderCubit()..fetchHomeSlider();
    _fetchFlashSaleCubit = FetchProductsCubit()..fetchProductsFlashSale();
    _fetchPromoCubit = FetchProductsCubit()..fetchProductsPromo();
    _fetchBestSellCubit = FetchProductsCubit()..fetchProductsBestSell();
    _fetchProductsByCategoryCubit = FetchProductsByCategoryCubit()
      ..fetchProductsByCategory(categoryId: categoryId);
    _fetchHomeCategoriesCubit = FetchHomeCategoriesCubit()..load();
    _fetchCategorysubCubit = FetchCategorysubCubit()..load(id: 23);
    _fetchSelectedRecipent = FetchSelectedRecipentCubit()
      ..fetchSelectedRecipent();

    _colorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _backgroundColorTween =
        ColorTween(begin: Colors.transparent, end: Color(0xFF0B4ED0))
            .animate(_colorAnimationController);
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels / 150);

      return true;
    }
  }

  void _checkHaveMainAddress() async {
    RecipentObjectResponse userMainAddress =
        await _recipentRepository.getMainAddress();
    if (userMainAddress == null) {
      int mainAddressSubdistrictId =
          _recipentRepository.getSelectedSubdistrictIdStorage();
      if (mainAddressSubdistrictId == 0) {
        bool isRefresh = await AppExt.pushScreen(
            context,
            HandlingRecipentOverlay(
              isFromDeliverTo: false,
            ));
        if (isRefresh ?? true) {
          refreshData(true);
        }
      }
    }
  }

  Future refreshData(bool useNetworkChecker) async {
    if (useNetworkChecker) {
      context.read<CheckNetworkCubit>().checker();
    }
    _fetchPromoCubit.fetchProductsPromo();
    _fetchBestSellCubit.fetchProductsBestSell();
    _fetchFlashSaleCubit.fetchProductsFlashSale();
    _fetchHomeSliderCubit.fetchHomeSlider();
    _fetchProductsByCategoryCubit.fetchProductsByCategory(
        categoryId: categoryId);
    _fetchHomeCategoriesCubit.load();
    _fetchSelectedRecipent.fetchSelectedRecipent();
  }

  void _handleCopy(String text, String message) {
    Clipboard.setData(new ClipboardData(text: text));
    ScaffoldMessenger.of(_scaffoldKey.currentContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        new SnackBar(
          backgroundColor: Colors.grey[900],
          content: new Text(
            message,
          ),
          duration: Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final userDataCubit = BlocProvider.of<UserDataCubit>(context);
    final isUser = BlocProvider.of<UserDataCubit>(context).state.user != null
        ? BlocProvider.of<UserDataCubit>(context).state.user
        : null;

    // TODO: implement build
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => _fetchFlashSaleCubit),
          BlocProvider(create: (_) => _fetchPromoCubit),
          BlocProvider(create: (_) => _fetchBestSellCubit),
          BlocProvider(create: (_) => _fetchHomeSliderCubit),
          BlocProvider(create: (_) => _fetchHomeCategoriesCubit),
          BlocProvider(create: (_) => _fetchSelectedRecipent),
          BlocProvider(create: (_) => _fetchProductsByCategoryCubit),
          BlocProvider(create: (_) => _fetchCategorysubCubit),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<CheckNetworkCubit, CheckNetworkState>(
                listener: (context, state) async {
              if (state is CheckNetworkFailure) {
                bool refresh =
                    await AppExt.pushScreen(context, NoConnectionScreen());
                if (refresh) {
                  refreshData(false);
                }
              }
            }),
            BlocListener<AppInfoCubit, AppInfoState>(
                listener: (context, state) async {
              if (state is AppInfoSuccess) {
                if (state.packageInfo.version != state.data.versionName) {
                  if (!kIsWeb) {
                    WarningAlertDialog(
                      context,
                      "Versi ${state.data.versionName} tersedia",
                      "Silahkan, perbarui aplikasi ke versi baru!",
                      "Update",
                      () {
                        AppExt.toWebUrl(context,
                            'https://play.google.com/store/apps/details?id=id.sellerpro.app');
                      },
                    );
                  }

                  print("Versi App Lama: ${state.packageInfo.version}");
                  print("Versi App Baru: ${state.data.versionName}");
                }
              }
            }),
            BlocListener(
              bloc: _fetchHomeCategoriesCubit,
              listener: (context, state) {
                if (state is FetchHomeCategoriesSuccess) {
                  categoryTemp.clear();
                  for (int i = 0; i < state.homeCategories.length + 1; i++) {
                    if (i == 0) {
                      categoryTemp.add(HomeCategory(
                          id: 0,
                          name: "Semua Kategori",
                          order: 0,
                          icon: "allcategories.png"));
                    } else {
                      categoryTemp.add(HomeCategory(
                          id: state.homeCategories[i - 1].id,
                          name: state.homeCategories[i - 1].name,
                          order: state.homeCategories[i - 1].order,
                          icon: state.homeCategories[i - 1].icon));
                    }
                  }
                }
              },
            ),
          ],
          child: GestureDetector(
            onTap: () => AppExt.hideKeyboard(context),
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: AppColor.textPrimaryInverted,
              body: BlocBuilder(
                bloc: _fetchFlashSaleCubit,
                builder: (context, fetchFlashSaleState) => BlocBuilder(
                  bloc: _fetchPromoCubit,
                  builder: (context, fetchPromoState) => BlocBuilder(
                    bloc: _fetchBestSellCubit,
                    builder: (context, fetchBestSellState) => BlocBuilder(
                      bloc: _fetchHomeSliderCubit,
                      builder: (context, fetchSlidersState) => BlocBuilder(
                        bloc: _fetchProductsByCategoryCubit,
                        builder: (context, fetchProductCategoryState) =>
                            BlocBuilder(
                          bloc: _fetchSelectedRecipent,
                          builder: (context, fetchSelectedRecipentState) =>
                              BlocBuilder(
                            bloc: _fetchHomeCategoriesCubit,
                            builder: (context, fetchHomeCategoriesState) =>
                                BlocBuilder(
                              bloc: _fetchCategorysubCubit,
                              builder: (context, fetchCategorysubState) =>

                                  /*========== MAIN LAYOUT ==========*/
                                  NotificationListener(
                                onNotification: _scrollListener,
                                child: RefreshIndicator(
                                  onRefresh: () {
                                    return refreshData(true);
                                  },
                                  child: Stack(
                                    children: [
                                      SingleChildScrollView(
                                        padding: EdgeInsets.zero,
                                        child: Column(
                                          children: [
                                            // FOR CHANGE URL DEV
                                            UiDebugSwitcher(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 85),
                                                    Text(
                                                        "Welcome to Seller Pro 😘"),
                                                    SizedBox(height: 10),
                                                    Opacity(
                                                      opacity: 0.5,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              'Development:   '),
                                                          Expanded(
                                                            child: SelectableText(
                                                                '${_apiProvider.defaultBaseUrl}'),
                                                          ),
                                                          GestureDetector(
                                                            child: Icon(
                                                              Icons.copy,
                                                              size: 17,
                                                            ),
                                                            onTap: () =>
                                                                _handleCopy(
                                                              _apiProvider
                                                                  .defaultBaseUrl,
                                                              'Copied!',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        Text('Current:   '),
                                                        Expanded(
                                                          child: SelectableText(
                                                              '${_apiProvider.baseUrl}'),
                                                        ),
                                                        GestureDetector(
                                                          child: Icon(
                                                            Icons.copy,
                                                            size: 17,
                                                          ),
                                                          onTap: () =>
                                                              _handleCopy(
                                                            _apiProvider
                                                                .baseUrl,
                                                            'Copied!',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    TextField(
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              "Change current base URL",
                                                        ),
                                                        onSubmitted: (val) {
                                                          _apiProvider
                                                              .setBaseUrl(val);
                                                          userDataCubit
                                                              .logout();
                                                          AppExt.popUntilRoot(
                                                              context);
                                                        }),
                                                    SizedBox(height: 10),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            /*========== HERO SECTION ==========*/
                                            fetchSlidersState
                                                    is FetchHomeSliderLoading
                                                ? HeroSection(isLoading: true)
                                                : fetchSlidersState
                                                        is FetchHomeSliderSuccess
                                                    ? HeroSection(
                                                        sliders: [],
                                                        // fetchSlidersState
                                                        //     .homeSliders,
                                                        user: isUser)
                                                    : HeroSection(
                                                        useIndicator: false),
                                            const SizedBox(
                                              height: 18,
                                            ),
                                            /*========== INVITE FRIENDS ==========*/
                                            fetchCategorysubState
                                                    is FetchCategorysubLoading
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    child: GridView(
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.zero,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      gridDelegate:
                                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                                              mainAxisExtent:
                                                                  95,
                                                              maxCrossAxisExtent:
                                                                  109),
                                                      children: List.generate(
                                                          8,
                                                          (index) =>
                                                              BuildMenuItemShimmer()),
                                                    ),
                                                  )
                                                : fetchCategorysubState
                                                        is FetchCategorysubFailure
                                                    ? Center()
                                                    : fetchCategorysubState
                                                            is FetchCategorysubSuccess
                                                        ? const InviteFriendsSection()
                                                        : SizedBox.shrink(),
                                            SizedBox(height: 24),
                                            /*==========  WORK TEAM  ==========*/
                                            WorkTeamSection(),
                                            /*========== PUSH PRODUCT BANNER ==========*/
                                            PushProductBanner(
                                              onPressed: () {},
                                            ),
                                            /*========== KATALOG PRODUK ==========*/
                                            SizedBox(height: 24),
                                            Container(
                                              color: AppColor.white,
                                              padding: EdgeInsets.zero,
                                              child: fetchHomeCategoriesState
                                                      is FetchHomeCategoriesLoading
                                                  ? Center()
                                                  : fetchHomeCategoriesState
                                                          is FetchHomeCategoriesFailure
                                                      ? Center(
                                                          child: ErrorFetch(
                                                          message:
                                                              "Kategori gagal dimuat",
                                                          onButtonPressed: () =>
                                                              _fetchHomeCategoriesCubit
                                                                  .load(),
                                                        ))
                                                      : fetchHomeCategoriesState
                                                              is FetchHomeCategoriesSuccess
                                                          ? fetchHomeCategoriesState
                                                                      .homeCategories
                                                                      .length >
                                                                  0
                                                              ? ProductCatalogSection()
                                                              : SizedBox
                                                                  .shrink()
                                                          : SizedBox.shrink(),
                                            ),
                                            SizedBox(height: 8),

                                            /*========== AGENDA KEGIATAN ==========*/
                                            // fetchBestSellState
                                            //         is FetchProductsLoading
                                            //     ? ShimmerProductList()
                                            //     : fetchBestSellState
                                            //             is FetchProductsFailure
                                            //         ? Center(
                                            //             child: Text(
                                            //                 fetchBestSellState
                                            //                     .message),
                                            //           )
                                            //         : fetchBestSellState
                                            //                 is FetchProductsSuccess
                                            //             ? fetchBestSellState
                                            //                         .products
                                            //                         .length >
                                            //                     0
                                            //                 ?
                                            AgendaList(
                                              section: "Agenda Kegiatan",
                                              agendas: agendas,
                                            ),
                                            //                 : SizedBox.shrink()
                                            //             : SizedBox.shrink(),

                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                      AnimatedBuilder(
                                        animation: _colorAnimationController,
                                        builder: (BuildContext context,
                                                Widget child) =>
                                            _customAppBar(
                                                backgroundColor:
                                                    _backgroundColorTween
                                                        .value),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customAppBar({Color backgroundColor}) {
    return Container(
      color: backgroundColor,
      padding: kIsWeb
          ? const EdgeInsets.fromLTRB(10, 15, 8, 0)
          : const EdgeInsets.fromLTRB(10, 35, 8, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImg.img_seller_pro_white,
            fit: BoxFit.contain,
            height: 32,
            width: 32,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 50,
              child: EditText(
                hintText: "Cari produk",
                inputType: InputType.search,
                readOnly: true,
                onTap: () => AppExt.pushScreen(context, SearchScreen()),
              ),
            ),
          ),
          Stack(
            children: [
              IconButton(
                padding: EdgeInsets.only(left: 10, right: 10),
                constraints: BoxConstraints(),
                iconSize: 28,
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          Stack(
            children: [
              IconButton(
                padding: EdgeInsets.only(right: 10),
                constraints: BoxConstraints(),
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                iconSize: 28,
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
                },
              ),
              BlocProvider.of<UserDataCubit>(context).state.countCart != null &&
                      BlocProvider.of<UserDataCubit>(context).state.countCart >
                          0
                  ? new Positioned(
                      right: kIsWeb ? 8 : -10,
                      top: kIsWeb ? -12 : -17,
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
                          "",
                          style: AppTypo.overlineInv.copyWith(fontSize: 8),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}

class Agenda {
  final String image;
  final String judul;
  final String time;
  final String date;

  const Agenda({
    @required this.image,
    @required this.judul,
    @required this.time,
    @required this.date,
  });
}
