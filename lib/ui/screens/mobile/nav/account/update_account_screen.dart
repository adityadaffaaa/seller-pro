import 'dart:typed_data';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:beamer/beamer.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/edit_user_profile/edit_user_profile_cubit.dart';
import 'package:marketplace/data/blocs/upload_user_avatar/upload_user_avatar_cubit.dart';
import 'package:marketplace/data/blocs/user_data/user_data_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/repositories.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/constants.dart' as AppConst;
import 'package:marketplace/utils/images.dart' as AppImg;

import '../../../../widgets/custom_app_bar.dart';

class UpdateAccountScreen extends StatefulWidget {
  final User user;

  const UpdateAccountScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _UpdateAccountScreenState createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();

  UploadUserAvatarCubit _uploadUserAvatarCubit;
  EditUserProfileCubit _editUserProfileCubit;
  TextEditingController _nameController;

  bool _inputNameValidated;

  dynamic _pickedImage;

  @override
  void initState() {
    _inputNameValidated = false;
    _uploadUserAvatarCubit = UploadUserAvatarCubit(
        userDataCt: BlocProvider.of<UserDataCubit>(context));
    _editUserProfileCubit = EditUserProfileCubit(
        userDataCt: BlocProvider.of<UserDataCubit>(context));
    _nameController = TextEditingController(text: widget.user.name);
    _nameController.addListener(_checkEmpty);
    super.initState();

    _checkUser();
    _checkEmpty();
  }

  void _checkEmpty() {
    if (_nameController.text.trim().isEmpty ||
        _nameController.text == widget.user.name) {
      setState(() {
        _inputNameValidated = false;
      });
    } else
      setState(() {
        _inputNameValidated = true;
      });
  }

  void _checkUser() async {
    if (await _authenticationRepository.hasToken()) {
      await BlocProvider.of<UserDataCubit>(context).loadUser();
    }
  }

  void _handleEditProfile() {
    AppExt.hideKeyboard(context);
    LoadingDialog.show(context);
    _editUserProfileCubit.editProfile(name: _nameController.text);
  }

  @override
  void dispose() {
    _uploadUserAvatarCubit.close();
    _editUserProfileCubit.close();
    _nameController.dispose();
    super.dispose();
  }

  _pickImageFromGallery() async {
    AppExt.popScreen(context);

    try {
      final pickedFileMob = await picker.getImage(
          source: ImageSource.gallery,
          imageQuality: 40,
          maxHeight: 1000,
          maxWidth: 1000);
      if (pickedFileMob != null)
        _handleUploadAvatar(image: pickedFileMob.path.toString());
    } catch (e) {
      print(e);
    }
  }

  _pickImageFromCamera() async {
    AppExt.popScreen(context);

    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 480,
      maxWidth: 640,
    );
    if (pickedFile != null) _handleUploadAvatar(image: pickedFile);
  }

  _handleUploadAvatar({@required image}) {
    LoadingDialog.show(context);
    kIsWeb
        ? _uploadUserAvatarCubit.uploadAvatarWeb(image)
        : _uploadUserAvatarCubit.uploadAvatar(image: image);
  }

  _pickImageWeb() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 480,
      maxWidth: 640,
    );
    setState(() {
      if (pickedFile != null) {
        _pickedImage = pickedFile;
      }
    });
    _handleUploadAvatar(image: _pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final userDataCubit = BlocProvider.of<UserDataCubit>(context);

    return WillPopScope(
      onWillPop: () async {
        if (kIsWeb) {
          context.beamBack();
        } else {
          AppExt.popUntilRoot(context);
          BlocProvider.of<BottomNavCubit>(context).navItemTapped(3);
        }
        return true;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        child: GestureDetector(
          onTap: () => AppExt.hideKeyboard(context),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => _uploadUserAvatarCubit),
              BlocProvider(create: (_) => _editUserProfileCubit),
            ],
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
                child: Scaffold(
                  key: _scaffoldKey,
                  backgroundColor: Colors.white,
                  extendBody: true,
                  body: MultiBlocListener(
                    listeners: [
                      BlocListener(
                        bloc: _uploadUserAvatarCubit,
                        listener: (_, state) async {
                          if (state is UploadUserAvatarSuccess) {
                            AppExt.popScreen(context);
                            return;
                          }
                          if (state is UploadUserAvatarFailure) {
                            AppExt.popScreen(context);
                            _scaffoldKey.currentState
                              ..hideCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                backgroundColor: Colors.grey[900],
                                content: Text("Terjadi kesalahan, coba lagi"),
                                behavior: SnackBarBehavior.floating,
                              ));
                            return;
                          }
                        },
                      ),
                      BlocListener(
                        bloc: _editUserProfileCubit,
                        listener: (context, state) {
                          if (state is EditUserProfileFailure) {
                            AppExt.popScreen(context);
                            _scaffoldKey.currentState
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                new SnackBar(
                                  duration: Duration(seconds: 1),
                                  backgroundColor: AppColor.danger,
                                  content: new Text(
                                    "${state.message}",
                                  ),
                                ),
                              );
                            return;
                          }
                          if (state is EditUserProfileSuccess) {
                            if (kIsWeb) {
                              AppExt.popScreen(context);
                              BSFeedback.show(context,
                                  title: "Ubah Akun berhasil",
                                  color: AppColor.success,
                                  anotherWidget: Column(
                                    children: [
                                      RoundedButton.contained(
                                          label: "Tutup",
                                          onPressed: () {
                                            context.beamToReplacementNamed('/');
                                          })
                                    ],
                                  ));
                              BlocProvider.of<BottomNavCubit>(context)
                                  .navItemTapped(3);
                            } else {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    margin: EdgeInsets.zero,
                                    duration: Duration(seconds: 2),
                                    content: Text('Ubah data berhasil'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              AppExt.popUntilRoot(context);

                              BlocProvider.of<BottomNavCubit>(context)
                                  .navItemTapped(3);
                            }

                            return;
                          }
                        },
                      ),
                    ],
                    child: SafeArea(
                      child: Stack(
                        children: [
                          NestedScrollView(
                            headerSliverBuilder: (BuildContext context,
                                bool innerBoxIsScrolled) {
                              return <Widget>[
                                SliverAppBar(
                                  //automaticallyImplyLeading: !kIsWeb,
                                  textTheme:
                                      TextTheme(headline6: AppTypo.subtitle2),
                                  iconTheme: IconThemeData(color: Colors.black),
                                  backgroundColor: Colors.white,
                                  centerTitle: true,
                                  forceElevated: false,
                                  pinned: true,
                                  shadowColor: Colors.black54,
                                  floating: true,
                                  leading: IconButton(
                                    splashRadius: 20,
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      context.beamToReplacementNamed('/');
                                      BlocProvider.of<BottomNavCubit>(context)
                                          .navItemTapped(3);
                                    },
                                  ),
                                  title: Text(
                                    "Ubah Data Saya",
                                    style: kIsWeb
                                        ? AppTypo.subtitle2
                                            .copyWith(color: Colors.black)
                                        : TextStyle(),
                                  ),
                                  brightness: Brightness.dark,
                                ),
                              ];
                            },
                            body: SingleChildScrollView(
                              physics: new BouncingScrollPhysics(),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: _screenWidth * (5 / 100),
                                    vertical: _screenWidth * (3 / 100)),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Center(
                                      child: Stack(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                AppColor.navScaffoldBg,
                                            radius: kIsWeb
                                                ? 50
                                                : _screenWidth * (10.5 / 100),
                                            backgroundImage: userDataCubit
                                                        .state.user.avatar !=
                                                    null
                                                ? NetworkImage(
                                                    "${AppConst.STORAGE_URL}/user/avatar/${userDataCubit.state.user.avatar}")
                                                : AssetImage(
                                                    AppImg.img_default_account),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 26,
                                              height: 26,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: AppColor
                                                          .editTextField,
                                                      blurRadius: 3.0,
                                                      spreadRadius: 1.0),
                                                ],
                                              ),
                                              child: Icon(
                                                EvaIcons.editOutline,
                                                size: 16,
                                                color: AppColor.success,
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Material(
                                              type: MaterialType.transparency,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        _screenWidth *
                                                            (10.5 / 100)),
                                                onTap: kIsWeb
                                                    ? _pickImageWeb
                                                    : () =>
                                                        showSheetImage(context),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text(
                                      "Nama",
                                      style: AppTypo.caption,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    EditText(
                                      hintText: "",
                                      inputType: InputType.text,
                                      controller: this._nameController,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    RoundedButton.contained(
                                      label: "Simpan",
                                      textColor: Colors.white,
                                      isUpperCase: false,
                                      onPressed: _inputNameValidated
                                          ? () {
                                              if (_inputNameValidated) {
                                                _handleEditProfile();
                                              }
                                            }
                                          : null,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
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
        ),
      ),
    );
  }

  Future showSheetImage(BuildContext context) {
    return showModalBottomSheet(
      constraints: BoxConstraints(maxWidth: kIsWeb ? 550 : 450),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 130,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _pickImageFromGallery();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        color: AppColor.success,
                        size: 50,
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: Text(
                          "Galeri",
                          style: AppTypo.captionAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              kIsWeb
                  ? SizedBox()
                  : Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _pickImageFromCamera();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera,
                              color: AppColor.success,
                              size: 50,
                            ),
                            SizedBox(height: 5),
                            Expanded(
                              child: Text(
                                "Kamera",
                                style: AppTypo.captionAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
