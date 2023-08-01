import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/check_network/check_network_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/delete_bulk_transaction/delete_bulk_transaction_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/fetch_transaction_menunggu_pembayaran/fetch_transaction_menunggu_pembayaran_bloc.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/fetch_transaction_new/fetch_transaction_new_bloc.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/transaksi_filter_kategori/transaksi_filter_kategori_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/transaksi_filter_status/transaksi_filter_status_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/transaksi_filter_tanggal/transaksi_filter_tanggal_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/ui/screens/mobile/credentials/sign_in_screen.dart';
import 'package:marketplace/ui/screens/mobile/nav/transaksi/transaksi_menunggu_pembayaran_screen.dart';
import 'package:marketplace/ui/screens/mobile/nav/transaksi/widgets/filter_list.dart';
import 'package:marketplace/ui/screens/mobile/nav/transaksi/widgets/transaksi_item.dart';
import 'package:marketplace/ui/screens/mobile/cart_screen/cart_screen.dart';
import 'package:marketplace/ui/screens/mobile/no_connection/no_connection_screen.dart';
import 'package:marketplace/ui/screens/mobile/search/search_screen.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/ui/widgets/fetch_conditions.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({Key key}) : super(key: key);

  @override
  _TransaksiScreenState createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CheckNetworkCubit>().checker();
    context.read<TransaksiFilterStatusCubit>().resetStatus();
    context.read<TransaksiFilterKategoriCubit>().reset();
    context.read<TransaksiFilterTanggalCubit>().reset();
    context.read<FetchTransactionNewBloc>().add(TransactionFetched());
    context
        .read<FetchTransactionMenungguPembayaranBloc>()
        .add(TransactionMenungguPembayaranFetched());
    _scrollController.addListener(_onScroll);
  }

  Future<void> reshDatDataa(bool useNetworkChecker) async {
    if (useNetworkChecker) {
      context.read<CheckNetworkCubit>().checker();
    }
    final status = context.read<TransaksiFilterStatusCubit>().state.index;
    final kategori = context.read<TransaksiFilterKategoriCubit>().state;
    final tanggal = context.read<TransaksiFilterTanggalCubit>().state;
    context.read<FetchTransactionNewBloc>().add(TransactionFetched(
        status: status,
        kategoriId: kategori.kategoriId,
        tanggalIndex: tanggal.indexStatus,
        from: tanggal.startDate,
        to: tanggal.endDate));
    context
        .read<FetchTransactionMenungguPembayaranBloc>()
        .add(TransactionMenungguPembayaranFetched());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom())
      context.read<FetchTransactionNewBloc>().add(TransactionLoadedNext());
  }

  bool _isBottom() {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  bool _isExpired(DateTime orderDate) {
    final expired = orderDate.add(const Duration(days: 1));
    final now = DateTime.now();
    return now.isAfter(expired);
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<FetchTransactionMenungguPembayaranBloc,
            FetchTransactionMenungguPembayaranState>(
          listener: (context, state) {
            if (state is FetchTransactionMenungguPembayaranSuccess) {
              Map<int, DateTime> payments = {};
              List<int> expiredId = [];
              for (var order in state.order) {
                payments[order.id] = order.createdAt;
              }
              for (var index = 0; index < payments.keys.length; index++) {
                if (_isExpired(payments.values.toList()[index])) {
                  expiredId.add(payments.keys.elementAt(index));
                }
              }
              debugPrint("paymentId $expiredId");
              context
                  .read<DeleteBulkTransactionCubit>()
                  .delete(paymentId: expiredId);
            }
          },
        ),
        BlocListener<DeleteBulkTransactionCubit, DeleteBulkTransactionState>(
          listener: (context, state) {
            if (state is DeleteBulkTransactionSuccess) {
              context.read<FetchTransactionMenungguPembayaranBloc>().add(
                  TransactionMenungguPembayaranLoadedAfterDelete(
                      order: state.order));
            }
          },
        ),
        BlocListener<CheckNetworkCubit, CheckNetworkState>(
            listener: (context, state) async {
          if (state is CheckNetworkFailure) {
            bool refresh =
                await AppExt.pushScreen(context, NoConnectionScreen());
            if (refresh) {
              reshDatDataa(false);
            }
          }
        }),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 10,
          title: Container(
            height: 50,
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.center,
            child: EditText(
              hintText: "Cari Transaksi",
              inputType: InputType.search,
              readOnly: true,
              onTap: () => AppExt.pushScreen(context, SearchScreen()),
            ),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                    padding: EdgeInsets.only(left: 5, top: 10, right: 10),
                    constraints: BoxConstraints(),
                    icon: Icon(EvaIcons.bell, color: Colors.black),
                    iconSize: 28,
                    splashRadius: 2,
                    onPressed: () {
                      // AppExt.pushScreen(
                      //   context,
                      //   BlocProvider.of<UserDataCubit>(context).state.user != null
                      //       ? CartScreen()
                      //       : SignInScreen(),
                      // );
                    }),
              ],
            ),
            Stack(
              children: [
                IconButton(
                    padding: EdgeInsets.only(top: 10, right: 14),
                    constraints: BoxConstraints(),
                    icon: Icon(
                      EvaIcons.shoppingCart,
                      color: Colors.black,
                    ),
                    iconSize: 28,
                    onPressed: () {
                      kIsWeb
                          ? BlocProvider.of<UserDataCubit>(context)
                                      .state
                                      .user !=
                                  null
                              ? context.beamToNamed('/cart')
                              : context.beamToNamed('/signin')
                          : AppExt.pushScreen(
                              context,
                              BlocProvider.of<UserDataCubit>(context)
                                          .state
                                          .user !=
                                      null
                                  ? CartScreen()
                                  : SignInScreen(),
                            );
                    }),
                BlocProvider.of<UserDataCubit>(context).state.countCart !=
                            null &&
                        BlocProvider.of<UserDataCubit>(context)
                                .state
                                .countCart >
                            0
                    ? new Positioned(
                        right: kIsWeb ? 12 : -8,
                        top: kIsWeb ? 0 : -8,
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
                            // "${BlocProvider.of<UserDataCubit>(context).state.countCart}",
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: FilterList(),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: BlocBuilder<
                            FetchTransactionMenungguPembayaranBloc,
                            FetchTransactionMenungguPembayaranState>(
                          builder: (context, state) {
                            if (state
                                is FetchTransactionMenungguPembayaranFailure) {
                              return Text(
                                  "Tidak dapat mendapatkan data transaksi");
                            }
                            if (state
                                is FetchTransactionMenungguPembayaranSuccess) {
                              return _buildMenungguPembayaranItem(
                                  context, state.order.length);
                            }
                            if (state
                                is FetchTransactionMenungguPembayaranSuccessAfterDelete) {
                              return _buildMenungguPembayaranItem(
                                  context, state.order.length);
                            }
                            return SizedBox();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: BlocBuilder<FetchTransactionNewBloc,
                            FetchTransactionNewState>(
                          builder: (context, state) {
                            if (state.status ==
                                    FetchTransactionNewStatus.success ||
                                state.status ==
                                    FetchTransactionNewStatus.empty ||
                                state.status ==
                                    FetchTransactionNewStatus.loadingNext) {
                              if (state.order.isEmpty) {
                                return Center(
                                  child: EmptyData(
                                    title: "Transaksi anda kosong",
                                    subtitle:
                                        "Silahkan pilih produk yang anda inginkan untuk mengisinya",
                                    labelBtn: "Mulai Belanja",
                                    onClick: () {
                                      AppExt.popUntilRoot(context);
                                      BlocProvider.of<BottomNavCubit>(context)
                                          .navItemTapped(0);
                                    },
                                  ),
                                );
                              }
                              return RefreshIndicator(
                                color: AppColor.success,
                                backgroundColor: AppColor.white,
                                onRefresh: () => reshDatDataa(true),
                                child: ListView.separated(
                                  controller: _scrollController,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: state.order.length,
                                  itemBuilder: (context, index) {
                                    return TransaksiItem(
                                      item: state.order[index],
                                    );
                                  },
                                  separatorBuilder: (context, _) => SizedBox(
                                    height: 16,
                                  ),
                                ),
                              );
                            }
                            if (state.status ==
                                FetchTransactionNewStatus.failure) {
                              return Center(
                                child: ErrorFetch(
                                  message: state.message,
                                  onButtonPressed: () {
                                    context
                                        .read<FetchTransactionNewBloc>()
                                        .add(TransactionFetched());
                                  },
                                ),
                              );
                            }
                            if (state.status ==
                                FetchTransactionNewStatus.loading) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return SizedBox();
                          },
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<FetchTransactionNewBloc,
                      FetchTransactionNewState>(
                    builder: (context, state) {
                      if (state.status ==
                          FetchTransactionNewStatus.loadingNext) {
                        return Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
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
      ),
    );
  }

  ListTile _buildMenungguPembayaranItem(BuildContext context, int totalOrder) {
    return ListTile(
      onTap: () {
        kIsWeb
            ? context.beamToNamed('/transactionwaiting')
            : AppExt.pushScreen(context, TransaksiMenungguPembayaranScreen());
      },
      title: Text(
        "Menunggu Pembayaran",
        style: AppTypo.caption,
      ),
      leading: Image.asset("images/icons/ic_menunggu_pembayaran.png",
          alignment: Alignment.center, width: 18, height: 18),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color(0xFFE7366B),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              totalOrder.toString(),
              style:
                  AppTypo.caption.copyWith(color: Colors.white, fontSize: 10),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 18,
          )
        ],
      ),
    );
  }
}
