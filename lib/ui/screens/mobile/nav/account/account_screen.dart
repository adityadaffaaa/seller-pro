import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/check_network/check_network_cubit.dart';
import 'package:marketplace/data/blocs/upload_user_avatar/upload_user_avatar_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/authentication_repository.dart';
import 'package:marketplace/ui/screens/mobile/join_user/join_user_screen.dart';
import 'package:marketplace/ui/screens/mobile/nav/account/update_account_screen.dart';
import 'package:marketplace/ui/screens/mobile/nav/account/update_address_screen.dart';
import 'package:marketplace/ui/screens/mobile/nav/account/widget/account_info_item.dart';
import 'package:marketplace/ui/screens/mobile/nav/account/widget/account_role_item.dart';
import 'package:marketplace/ui/screens/mobile/no_connection/no_connection_screen.dart';
import 'package:marketplace/ui/screens/mobile/producer_dashboard/producer_dashboard_screen.dart';
import 'package:marketplace/ui/widgets/bs_confirmation.dart';
import 'package:marketplace/ui/widgets/rounded_button.dart';
import 'package:marketplace/ui/widgets/ui_debug_switcher.dart';
import 'package:marketplace/utils/responsive_layout.dart';

import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:websafe_svg/websafe_svg.dart';
import 'widget/account_profile_header.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AuthenticationRepository _authRepo = AuthenticationRepository();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();

  bool isUser, condition1, condition2, condition3;

  UploadUserAvatarCubit _uploadUserAvatarCubit;
  List<RoleItem> _roleItem = [];

  @override
  void dispose() {
    _uploadUserAvatarCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    context.read<CheckNetworkCubit>().checker();
    _uploadUserAvatarCubit = UploadUserAvatarCubit(
        userDataCt: BlocProvider.of<UserDataCubit>(context));
    checkUser();
    super.initState();
  }

  void checkUser() async {
    if (await _authRepo.hasToken()) {
      await BlocProvider.of<UserDataCubit>(context).loadUser();
    }
  }

  void handleCopy(String text, String message) {
    Clipboard.setData(new ClipboardData(text: text));
    ScaffoldMessenger.of(_scaffoldKey.currentContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        new SnackBar(
          elevation: 0.6,
          duration: Duration(seconds: 1),
          content: new Text(message),
          backgroundColor: Colors.grey[900],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final users = BlocProvider.of<UserDataCubit>(context).state.user != null
        ? BlocProvider.of<UserDataCubit>(context).state.user
        : null;

    final userData = BlocProvider.of<UserDataCubit>(context);
    isUser = userData.state.user?.reseller == null &&
        userData.state.user?.supplier == null;
    condition1 = userData.state.user?.reseller != null &&
        userData.state.user?.supplier == null;
    condition2 = userData.state.user?.reseller != null &&
        userData.state.user?.supplier != null;
    condition3 = userData.state.user?.reseller == null &&
        userData.state.user?.supplier != null;

    if (isUser)
      _roleItem = [
        RoleItem(
            onTap: () {
              kIsWeb
                  ? context.beamToNamed('/joinsupplier')
                  : AppExt.pushScreen(
                      context, JoinUserScreen(userType: UserType.supplier));
            },
            icon: kIsWeb
                ? WebsafeSvg.asset(
                    AppImg.ic_supplier,
                    height: 40,
                    width: 40,
                  )
                : SvgPicture.asset(
                    AppImg.ic_supplier,
                    height: 40,
                    width: 40,
                  ),
            title: "Supplier",
            subtitle: "Tawarkan produk anda ke Ekomad"),
      ];
    else if (condition1) {
      _roleItem = [];
      _roleItem.add(
        RoleItem(
          onTap: () {
            kIsWeb
                ? context.beamToNamed('/joinsupplier')
                : AppExt.pushScreen(
                    context, JoinUserScreen(userType: UserType.supplier));
          },
          icon: SvgPicture.asset(
            AppImg.ic_supplier,
            height: 40,
            width: 40,
          ),
          title: "Supplier",
          subtitle: "Tawarkan produk anda ke Ekomad",
        ),
      );
    } else if (condition2) {
      _roleItem = [];
      _roleItem.add(
        RoleItem(
          onTap: () {
            kIsWeb
                ? context.beamToNamed('/dashboard/supplier')
                : AppExt.pushScreen(
                    context,
                    ProducerDashboardScreen(
                      isSupplier: true,
                    ));
          },
          icon: SvgPicture.asset(
            AppImg.ic_supplier,
            height: 40,
            width: 40,
          ),
          title: "Supplier",
          subtitle: "Tawarkan produk anda ke Ekomad",
        ),
      );
    } else {
      _roleItem = [];
      _roleItem.add(
        RoleItem(
          onTap: () {
            kIsWeb
                ? context.beamToNamed('/dashboard/supplier')
                : AppExt.pushScreen(
                    context,
                    ProducerDashboardScreen(
                      isSupplier: true,
                    ));
          },
          icon: SvgPicture.asset(
            AppImg.ic_supplier,
            height: 40,
            width: 40,
          ),
          title: "Supplier",
          subtitle: "Tawarkan produk anda ke Ekomad",
        ),
      );
    }

    // TODO: implement build
    return BlocListener<CheckNetworkCubit, CheckNetworkState>(
      listener: (context, state) async {
        if (state is CheckNetworkFailure) {
          AppExt.pushScreen(context, NoConnectionScreen());
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        child: GestureDetector(
          onTap: () => AppExt.hideKeyboard(context),
          child: ResponsiveLayout(
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: AppColor.textPrimaryInverted,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20)
                      .copyWith(bottom: 0),
                  child: Column(
                    children: [
                      AccountProfileHeader(
                        user: userData.state.user,
                      ),
                      // UiDebugSwitcher(
                      //   child: Column(
                      //     children: [
                      //       SizedBox(height: 10),
                      //       Text('user_id: ${userData.state.user.id}'),
                      //       Text('role_id: ${userData.state.user.roleId}'),
                      //       SizedBox(height: 5),
                      //       Text('token:'),
                      //       FutureBuilder(
                      //         future: AuthenticationRepository().getToken(),
                      //         builder: (context, snapshot) {
                      //           if (snapshot.hasData) {
                      //             return Column(
                      //               children: [
                      //                 SelectableText(snapshot.data),
                      //                 OutlinedButton.icon(
                      //                   onPressed: () => handleCopy(
                      //                     snapshot.data,
                      //                     'Copied!',
                      //                   ),
                      //                   icon: Icon(Icons.copy),
                      //                   label: Text("Copy token"),
                      //                 ),
                      //               ],
                      //             );
                      //           }
                      //           return SelectableText('-');
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 24),
                      AccountInfoItem(user: userData.state.user),
                      // Column(
                      //   children: List.generate(
                      //       _roleItem.length, (index) => _roleItem[index]),
                      // ),
                      SizedBox(height: 24),
                      ListTile(
                        title: Text(
                          'Ubah Data Saya',
                          style: AppTypo.subtitle1,
                        ),
                        trailing:
                            Icon(Icons.chevron_right, color: AppColor.success),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        onTap: () {
                          if (kIsWeb) {
                            context.beamToNamed(
                                '/profile?dt=${AppExt.encryptMyData(jsonEncode(userData.state.user))}');
                          } else {
                            AppExt.pushScreen(context,
                                UpdateAccountScreen(user: userData.state.user));
                          }
                        },
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                      ),
                      Divider(height: 0),
                      ListTile(
                        title: Text(
                          'Daftar Alamat',
                          style: AppTypo.subtitle1,
                        ),
                        trailing:
                            Icon(Icons.chevron_right, color: AppColor.success),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        onTap: () => kIsWeb
                            ? context.beamToNamed('/addressuser')
                            : AppExt.pushScreen(context, UpdateAddressScreen()),
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                      ),
                      Divider(height: 0),
                      ListTile(
                        title: Text(
                          'Ketentuan Layanan',
                          style: AppTypo.subtitle1,
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: AppColor.success,
                        ),
                        onTap: () => AppExt.toWebUrl(
                          context,
                          "https://admasolusi.com/privacy",
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                      ),
                      Divider(height: 0),
                      ListTile(
                        title: Text(
                          'Kebijakan Privasi',
                          style: AppTypo.subtitle1,
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: AppColor.success,
                        ),
                        onTap: () => AppExt.toWebUrl(
                          context,
                          "https://admasolusi.com/privacy",
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                      ),
                      Divider(height: 0),
                      ListTile(
                        title: Text(
                          'Pusat Bantuan',
                          style: AppTypo.subtitle1,
                        ),
                        trailing:
                            Icon(Icons.chevron_right, color: AppColor.success),
                        onTap: () => AppExt.toWebUrl(
                          context,
                          "https://api.whatsapp.com/send?phone=6281132271374&text=Halo%20 Ekomad",
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                      ),
                      Divider(
                        height: 0,
                      ),
                      ListTile(
                        title: Text(
                          'Saran',
                          style: AppTypo.subtitle1,
                        ),
                        trailing:
                            Icon(Icons.chevron_right, color: AppColor.success),
                        onTap: () {},
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                      ),
                      Divider(
                        height: 0,
                      ),
                      SizedBox(height: screenSize.width * (7 / 100)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: RoundedButton.outlined(
                          key: const Key(
                              'signInScreen_continueWithGoogle_roundedButton'),
                          label: "Keluar",
                          onPressed: () {
                            BsConfirmation().show(
                                context: context,
                                onYes: () {
                                  AppExt.popScreen(context);
                                  userData.logout();
                                  BlocProvider.of<BottomNavCubit>(context)
                                      .navItemTapped(0);
                                },
                                title: "Apakah anda yakin ingin keluar?");
                          },
                          isUpperCase: false,
                          color: AppColor.danger,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
