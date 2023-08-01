import 'dart:io';
import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:marketplace/api/api_http_overrides.dart';
import 'package:marketplace/data/blocs/app_info/app_info_cubit.dart';
import 'package:marketplace/data/blocs/debug/ui_debug_switcher/ui_debug_switcher_cubit.dart';
import 'package:marketplace/data/blocs/fetch_subcategories/fetch_subcategories_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/check_network/check_network_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/choose_kecamatan/choose_kecamatan_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/order/order_langganan_telkom/order_langganan_telkom_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/region/fetch_google_maps_url/fetch_google_maps_url_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/change_transaction_status_supplier_cubit/change_transaction_status_supplier_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/fetch_transaction/fetch_transaction_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/fetch_transaction_detail/fetch_transaction_detail_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/fetch_transaction_new/fetch_transaction_new_bloc.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/transaksi_filter_kategori/transaksi_filter_kategori_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/transaksi_filter_kategori_search/transaksi_filter_kategori_search_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/transaksi_filter_tanggal/transaksi_filter_tanggal_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/transaksi_upload_review_photo/transaksi_upload_review_photo_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/wpp_cart/add_to_cart_offline/add_to_cart_offline_cubit.dart';
import 'package:marketplace/ui/screens/mobile/main_screen.dart';
import 'package:marketplace/ui/widgets/custom_scroll_behavior.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/repositories/repositories.dart';
import 'package:marketplace/route/beam_locations.dart';
import 'package:marketplace/ui/screens/mobile/screens.dart';
import 'package:marketplace/ui/widgets/a_app_config.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/transitions.dart' as AppTrans;
import 'package:marketplace/env/env.dart' as AppEnv;

import 'app_bloc_observer.dart';
import 'data/blocs/new_cubit/bagikan_produk/bagikan_produk_cubit.dart';
import 'data/blocs/new_cubit/cart/fetch_cart/fetch_cart_cubit.dart';
import 'data/blocs/new_cubit/kemacatan_search/kecamatan_search_cubit.dart';
import 'data/blocs/new_cubit/products/fetch_products_by_subcategory/fetch_products_by_subcategory_cubit.dart';
import 'data/blocs/new_cubit/register_supplier_reseller/register_supplier_reseller_cubit.dart';
import 'data/blocs/new_cubit/supplier/get_product_supplier/get_product_supplier_cubit.dart';
import 'data/blocs/new_cubit/supplier/post_product/post_add_product_supplier_cubit.dart';
import 'data/blocs/new_cubit/transaction/delete_bulk_transaction/delete_bulk_transaction_cubit.dart';
import 'data/blocs/new_cubit/transaction/fetch_transaction_menunggu_pembayaran/fetch_transaction_menunggu_pembayaran_bloc.dart';
import 'data/blocs/new_cubit/transaction/fetch_transaction_menunggu_pembayaran_detail/fetch_transaction_menunggu_pembayaran_detail_cubit.dart';
import 'data/blocs/new_cubit/transaction/fetch_transaction_supplier/fetch_transaction_supplier_cubit.dart';
import 'data/blocs/new_cubit/transaction/fetch_transaction_supplier_detail/fetch_transaction_supplier_detail_cubit.dart';
import 'data/blocs/new_cubit/transaction/transaksi_filter_status/transaksi_filter_status_cubit.dart';
import 'data/blocs/new_cubit/transaction/transaksi_filter_supplier_status/transaksi_filter_supplier_status_cubit.dart';
import 'data/blocs/new_cubit/transaction/transaksi_filter_supplier_tanggal/transaksi_filter_supplier_tanggal_cubit.dart';

final appKey = new GlobalKey<_MyAppState>();
final scaffoldMainKey = new GlobalKey<ScaffoldState>();

void main() async {
  setPathUrlStrategy();

  HttpOverrides.global = ApiHttpOverrides();

  // check if app run QA
  const bool isQaArgs = bool.fromEnvironment("ISQA");

  WidgetsFlutterBinding.ensureInitialized();

  bool useQaVersion = false;

  Bloc.observer = AppBlocObserver();

  if (!kIsWeb) {
    useQaVersion = isQaArgs || kDebugMode;
    if (useQaVersion)
      debugPrint(
        "!!! Running app in QA version, only for testing purposes !!!",
      );
  }

  if (kReleaseMode) {
    debugPrint = (String message, {int wrapWidth}) {};
  }

  // pass data to selected app flavor
  String appName;
  AppType appType;

  // await DotEnv.load(fileName: "lib/env/.env");
  appName = "Seller Pro";
  appType = AppType.ekomad;

  Widget configuredApp = AAppConfig(
    appName: appName,
    appType: appType,
    isQA: useQaVersion,
    child: MyApp(),
  );

  // debug app token
  // jangan di comment
  if (kDebugMode) {
    final _authRepo = AuthenticationRepository();
    await _authRepo.persistToken(
        "2081|Xn2WsGDcQb3WeBLYrKFqfFNUrqre4IYoxyTOHjgz" //token GUNTUR
        // "2121|oNzYOD9uErPeRu48LGvNzMpkBU59aRGd1jzjpqm2" // token farhan
        );
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await GetStorage.init();

  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(configuredApp));
}

class MyApp extends StatefulWidget {
  MyApp() : super(key: appKey);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RecipentRepository recipentRepo = RecipentRepository();

  /*final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;*/

  UserDataCubit userDataCubit;
  BottomNavCubit bottomNavCubit;
  AppInfoCubit appInfoCubit;
  UiDebugSwitcherCubit uiDebugSwitcherCubit;
  bool initialized;

  /*Future initDynamicLinks() async {
    dynamicLinks.onLink.listen((event) {
      // Navigator
    }).onError((error) {
      debugPrint('Error');
      debugPrint(error.message);
    });
  }*/

  @override
  void initState() {
    super.initState();

    /*initDynamicLinks();*/
    initialized = false;
    appInfoCubit = AppInfoCubit()..load();
    uiDebugSwitcherCubit = UiDebugSwitcherCubit();
    userDataCubit = UserDataCubit()..appStarted();
  }

  @override
  void didChangeDependencies() {
    if (!initialized) {
      debugPrint("initialized");

      bottomNavCubit = BottomNavCubit()..appLoaded();

      setState(() {
        initialized = true;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var config = AAppConfig.of(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => appInfoCubit),
          BlocProvider(create: (_) => uiDebugSwitcherCubit),
          BlocProvider(create: (_) => userDataCubit),
          BlocProvider(create: (_) => bottomNavCubit),
          BlocProvider(create: (ctx) => CheckNetworkCubit()),
          BlocProvider(create: (ctx) => TransaksiFilterStatusCubit()),
          BlocProvider(create: (ctx) => TransaksiFilterTanggalCubit()),
          BlocProvider(create: (ctx) => TransaksiFilterKategoriCubit()),
          BlocProvider(create: (ctx) => TransaksiFilterKategoriSearchCubit()),
          BlocProvider(create: (ctx) => TransaksiUploadReviewPhotoCubit()),
          BlocProvider(create: (ctx) => FetchTransactionCubit()),
          BlocProvider(create: (ctx) => BagikanProdukCubit()),
          BlocProvider(create: (ctx) => RegisterSupplierResellerCubit()),
          BlocProvider(create: (ctx) => KecamatanSearchCubit()),
          BlocProvider(create: (ctx) => ChooseKecamatanCubit()),
          BlocProvider(create: (ctx) => FetchSubcategoriesCubit()),
          BlocProvider(create: (ctx) => PostAddProductSupplierCubit()),
          BlocProvider(create: (ctx) => GetProductSupplierCubit()),
          BlocProvider(create: (ctx) => FetchCartCubit()),
          BlocProvider(create: (ctx) => AddToCartOfflineCubit()),
          BlocProvider(create: (ctx) => FetchTransactionDetailCubit()),
          BlocProvider(create: (ctx) => FetchTransactionSupplierCubit()),
          BlocProvider(create: (ctx) => TransaksiFilterSupplierStatusCubit()),
          BlocProvider(create: (ctx) => TransaksiFilterSupplierTanggalCubit()),
          BlocProvider(create: (ctx) => FetchTransactionSupplierDetailCubit()),
          BlocProvider(create: (ctx) => FetchTransactionNewBloc()),
          BlocProvider(
              create: (ctx) => FetchTransactionMenungguPembayaranBloc()),
          BlocProvider(
              create: (ctx) => FetchTransactionMenungguPembayaranDetailCubit()),
          BlocProvider(create: (ctx) => DeleteBulkTransactionCubit()),
          BlocProvider(create: (ctx) => ChangeTransactionStatusSupplierCubit()),
          BlocProvider(create: (ctx) => FetchProductsBySubcategoryCubit()),
          BlocProvider(create: (ctx) => FetchGoogleMapsUrlCubit()),
          BlocProvider(create: (ctx) => OrderLanggananTelkomCubit()),
        ],
        child: kIsWeb
            ? GetMaterialApp.router(
                scrollBehavior: CustomScrollBehavior(),
                routeInformationParser: BeamerParser(),
                routerDelegate: BeamerDelegate(
                  notFoundPage: BeamPage(
                      key: ValueKey('not-found'),
                      title: 'Not found',
                      child: Scaffold(
                          body:
                              Center(child: Text('Halaman Tidak Ditemukan')))),
                  locationBuilder: BeamerLocationBuilder(
                    beamLocations: [
                      HomeLocation(),
                      AuthenticationLocation(),
                      WarungPanenPublicLocation(),
                      ProductCategoryLocation(),
                      ProductDetailLocation(),
                      CartLocation(),
                      CheckoutLocation(),
                      PaymentLocation(),
                      InvoiceLocation(),
                      JoinUserLocation(),
                      TokoSayaLocation(),
                      TransactionLocation(),
                      AccountLocation(),
                    ],
                  ),
                ),
                title: config.appName,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.indigo,
                  primaryColor: AppColor.DefTheme.primary,
                  shadowColor: Color.fromRGBO(46, 67, 77, 20),
                  primaryColorBrightness: Brightness.light,
                  scaffoldBackgroundColor: AppColor.white,
                  textSelectionTheme: TextSelectionThemeData(
                      cursorColor: AppColor.DefTheme.editTextCursor),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  fontFamily: 'Poppins',
                ),
                builder: (context, child) => BlocBuilder(
                  bloc: userDataCubit,
                  builder: (context, state) =>
                      AppTrans.FadeThroughTransitionSwitcher(
                    fillColor: Color(0xFFEDF0F2),
                    child: state is UserDataInitial ? SplashScreen() : child,
                  ),
                ),
              )
            : MaterialApp(
                title: config.appName,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.indigo,
                  primaryColor: AppColor.DefTheme.primary,
                  primaryColorBrightness: Brightness.dark,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.black),
                    foregroundColor: Colors.black,
                  ),
                  textSelectionTheme: TextSelectionThemeData(
                      cursorColor: AppColor.DefTheme.editTextCursor),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  fontFamily: 'Poppins',
                ),
                builder: (context, child) {
                  return Stack(
                    children: [
                      child,
                      if (config.isQA)
                        Overlay(
                          initialEntries: [
                            OverlayEntry(
                              builder: (context) => StatefulDragArea(
                                initialPosition: Offset(
                                  Get.size.width - 50,
                                  Get.size.height / 2,
                                ),
                                child: BlocBuilder<UiDebugSwitcherCubit, bool>(
                                  bloc: uiDebugSwitcherCubit,
                                  builder: (context, statenya) {
                                    return FloatingActionButton(
                                      elevation: statenya ? 5 : 15,
                                      backgroundColor: statenya
                                          ? AppColor.warning
                                          : Colors.white,
                                      child: Text(
                                        statenya ? "🙉 " : "🙊",
                                        style: TextStyle(fontSize: 25),
                                        textAlign: TextAlign.center,
                                      ),
                                      tooltip: "Show debug component",
                                      onPressed: uiDebugSwitcherCubit.toggle,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  );
                },
                home: BlocBuilder(
                  bloc: userDataCubit,
                  builder: (context, state) =>
                      AppTrans.FadeThroughTransitionSwitcher(
                    fillColor: Colors.white,
                    child: state is UserDataInitial
                        ? SplashScreen()
                        : MainScreen(),
                  ),
                ),
              ));
  }

  @override
  void dispose() {
    userDataCubit?.close();
    bottomNavCubit?.close();
    uiDebugSwitcherCubit?.close();
    super.dispose();
  }
}

class Config {
  static final String baseUrl =
      kDebugMode ? AppEnv.BASE_URL_DEBUG : AppEnv.BASE_URL;
  static final String adsKey =
      kDebugMode ? AppEnv.ADS_KEY_DEBUG : AppEnv.ADS_KEY;
}

class StatefulDragArea extends StatefulWidget {
  const StatefulDragArea(
      {Key key, @required this.child, @required this.initialPosition})
      : super(key: key);

  final Widget child;
  final Offset initialPosition;

  @override
  _DragAreaStateStateful createState() => _DragAreaStateStateful();
}

class _DragAreaStateStateful extends State<StatefulDragArea> {
  Offset position;

  @override
  void initState() {
    super.initState();
    position = widget.initialPosition;
  }

  void updatePosition(Offset newPosition) =>
      setState(() => position = newPosition);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        maxSimultaneousDrags: 1,
        feedback: widget.child,
        childWhenDragging: SizedBox(),
        onDragEnd: (details) => updatePosition(details.offset),
        child: widget.child,
      ),
    );
  }
}
