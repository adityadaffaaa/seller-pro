import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;

class UploadFotoFrame extends StatelessWidget {
  final File image;
  final String hostedImage, hintText, imageWeb;
  final double width, height, radius;

  UploadFotoFrame({
    Key key,
    this.image,
    this.imageWeb,
    this.hostedImage,
    this.hintText,
    @required this.width,
    @required this.height,
    @required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(this.radius ?? 20)),
      child: this.imageWeb != null
          ? Image.network(this.imageWeb,
              fit: BoxFit.cover, width: this.width, height: this.height)
          : this.image != null
              ? Image.file(
                  this.image,
                  fit: BoxFit.cover,
                  width: this.width,
                  height: this.height,
                )
              : this.hostedImage != null
                  ? Image(
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            height: this.height ?? null,
                            width: this.height ?? this.width,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorBuilder: (context, object, stacktrace) => Center(
                            child: Image.asset(AppImg.img_error,
                                height: this.height ?? null,
                                width: this.height ?? this.width),
                          ),
                      image: NetworkImage(this.hostedImage),
                      height: this.height ?? null,
                      fit: BoxFit.cover,
                      width: this.width)
                  : DottedBorder(
                      color: Colors.grey[500],
                      dashPattern: [3, 8],
                      strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(this.radius ?? 20)),
                        child: Container(
                          width: this.width,
                          height: this.height,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppImg.ic_upload_drive,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      this.hintText ?? "Unggah Foto KTP",
                                      style: AppTypo.body2
                                          .copyWith(color: AppColor.blue2),
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                      "Maksimal ukuran file 2 MB",
                                      style: AppTypo.caption
                                          .copyWith(color: AppColor.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
    );
  }
}
