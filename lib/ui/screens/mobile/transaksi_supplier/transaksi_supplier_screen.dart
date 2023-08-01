import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beamer/beamer.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/change_transaction_status_supplier_cubit/change_transaction_status_supplier_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/fetch_transaction_supplier/fetch_transaction_supplier_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/transaksi_filter_supplier_status/transaksi_filter_supplier_status_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/ui/screens/mobile/credentials/sign_in_screen.dart';
import 'package:marketplace/ui/screens/mobile/transaksi_supplier/widgets/filter_supplier_list.dart';
import 'package:marketplace/ui/screens/mobile/cart_screen/cart_screen.dart';
import 'package:marketplace/ui/screens/mobile/search/search_screen.dart';
import 'package:marketplace/ui/screens/mobile/transaksi_supplier/widgets/transaksi_supplier_item.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/ui/widgets/fetch_conditions.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class TransaksiSupplierScreen extends StatefulWidget {
  const TransaksiSupplierScreen({Key key, this.statusOrder = 0})
      : super(key: key);

  final int statusOrder;

  @override
  _TransaksiSupplierScreenState createState() =>
      _TransaksiSupplierScreenState();
}

class _TransaksiSupplierScreenState extends State<TransaksiSupplierScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.statusOrder != 0) {
      context.read<FetchTransactionSupplierCubit>().fetchFilterTransaction(
          status: widget.statusOrder, tanggalIndex: 0, from: null, to: null);
      ;
    } else {
      context.read<FetchTransactionSupplierCubit>().fetch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeTransactionStatusSupplierCubit,
        ChangeTransactionStatusSupplierState>(
      listener: (context, state) {
        AppExt.popScreen(context);
        if (state is ChangeTransactionStatusSupplierLoading) {
          LoadingDialog.show(context);
        }
        if (state is ChangeTransactionStatusSupplierSuccess) {
          if (state.status.toLowerCase() == "diproses") {
            context
                .read<TransaksiFilterSupplierStatusCubit>()
                .chooseStatus("Sedang diproses", 2);
            context
                .read<FetchTransactionSupplierCubit>()
                .fetchFilterTransaction(
                    status: 3, tanggalIndex: 0, from: null, to: null);
          }
          if (state.status.toLowerCase() == "dikirim") {
            context
                .read<TransaksiFilterSupplierStatusCubit>()
                .chooseStatus("Sedang dikirim", 3);
            context
                .read<FetchTransactionSupplierCubit>()
                .fetchFilterTransaction(
                    status: 4, tanggalIndex: 0, from: null, to: null);
          }
          if (state.status.toLowerCase() == "ditolak") {
            context
                .read<TransaksiFilterSupplierStatusCubit>()
                .chooseStatus("Ditolak", 7);
            context
                .read<FetchTransactionSupplierCubit>()
                .fetchFilterTransaction(
                    status: 7, tanggalIndex: 0, from: null, to: null);
          }
          BSFeedback.show(context,
              title: "Ubah Status Berhasil",
              color: AppColor.success,
              anotherWidget: Column(
                children: [
                  RoundedButton.contained(
                      label: "Tutup",
                      onPressed: () {
                        AppExt.popScreen(context);
                      })
                ],
              ));
        }
        if (state is ChangeTransactionStatusSupplierFailure) {
          debugPrint(state.message);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                margin: EdgeInsets.zero,
                duration: Duration(seconds: 1),
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
        }
      },
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: kIsWeb ? 425 : 600,
          ),
           child: Scaffold(
            appBar: AppBar(
              brightness: Brightness.dark,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColor.black),
                onPressed: () {
                  AppExt.popScreen(context);
                }
              ),
              elevation: 0,
              centerTitle: false,
              titleSpacing: 0,
              title: Container(
                height: 50,
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
                        padding: EdgeInsets.only(left: 5, top: 10, right: 12),
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.notifications, color: Colors.black),
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
                        padding: EdgeInsets.only(top: 10, right: 10),
                        constraints: BoxConstraints(),
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
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
                            right: 6,
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
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: FilterSupplierList(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: BlocBuilder<FetchTransactionSupplierCubit,
                          FetchTransactionSupplierState>(
                        builder: (context, state) {
                          if (state is FetchTransactionSupplierSuccess) {
                            if (state.order.isEmpty) {
                              return Center(
                                child: EmptyData(
                                  title: "Transaksi anda kosong",
                                  subtitle:
                                      "Silahkan pilih produk yang anda inginkan untuk mengisinya",
                                  labelBtn: "Mulai Belanja",
                                  onClick: () {
                                    BlocProvider.of<BottomNavCubit>(context)
                                        .navItemTapped(0);
                                    AppExt.popUntilRoot(context);
                                  },
                                ),
                              );
                            }
                            return RefreshIndicator(
                              onRefresh: () async {
                                context
                                    .read<FetchTransactionSupplierCubit>()
                                    .fetch();
                              },
                              child: ListView.separated(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                physics: BouncingScrollPhysics(),
                                itemCount: state.order.length,
                                itemBuilder: (context, index) {
                                  return TransaksiSupplierItem(
                                    isSupplier: true,
                                    item: state.order[index],
                                  );
                                },
                                separatorBuilder: (context, _) => SizedBox(
                                  height: 16,
                                ),
                              ),
                            );
                          }
                          if (state is FetchTransactionSupplierFailure) {
                            ErrorFetch(
                              message: state.message,
                              onButtonPressed: () {
                                context
                                    .read<FetchTransactionSupplierCubit>()
                                    .fetch();
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
