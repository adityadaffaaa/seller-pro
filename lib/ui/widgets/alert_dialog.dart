import 'package:flutter/material.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/images.dart' as AppImg;

void AlertDialogSuccess(
  BuildContext context,
  String title,
  String content,
  String labelContinue,
  OnpressedContinue,
) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      title: Center(
        child: Column(
          children: [
            Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypo.LatoBold.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      content: Text(content,
          textAlign: TextAlign.center,
          style: AppTypo.LatoBold.copyWith(
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            fontSize: 14,
          )),
      actions: <Widget>[
        Center(
          child: Container(
            width: 248,
            child: continueButton(labelContinue, OnpressedContinue),
          ),
        ),
      ],
    ),
  );
}

void AlertDialogWarning(
  BuildContext context,
  String title,
  String content,
  String labelContinue,
  OnpressedContinue,
) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      title: Center(
        child: Column(
          children: [
            Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypo.LatoBold.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      content: Text(content,
          textAlign: TextAlign.center,
          style: AppTypo.LatoBold.copyWith(
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            fontSize: 14,
          )),
      actions: <Widget>[
        Center(
          child: Container(
            width: 248,
            child: continueButton(labelContinue, OnpressedContinue),
          ),
        ),
      ],
    ),
  );
}

Widget ConfirmAlertDialog(
    BuildContext context,
    String title,
    String content,
    String labelContinue,
    OnpressedContinue,
    String labelCancel,
    OnpressedCancel) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImg.ic_confirm_icon,
            width: 48,
            height: 48,
          ),
          SizedBox(height: 16),
          Text(title,
              textAlign: TextAlign.center,
              style: AppTypo.LatoBold.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              )),
        ],
      ),
      content: Text(content,
          textAlign: TextAlign.center,
          style: AppTypo.LatoBold.copyWith(
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            fontSize: 14,
          )),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 3,
                child: cancelButton(labelCancel, OnpressedCancel)),
            Padding(padding: EdgeInsets.all(5)),
            Container(
                width: MediaQuery.of(context).size.width / 3,
                child: continueButton(labelContinue, OnpressedContinue)),
          ],
        ),
      ],
    ),
  );
}

Widget SuccessAlertDialog(BuildContext context, String title, String content,
    String labelContinue, OnpressedContinue) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImg.ic_success_icon,
            width: 48,
            height: 48,
          ),
          SizedBox(height: 16),
          Text(title,
              textAlign: TextAlign.center,
              style: AppTypo.LatoBold.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              )),
        ],
      ),
      content: Text(content,
          textAlign: TextAlign.center,
          style: AppTypo.LatoBold.copyWith(
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            fontSize: 14,
          )),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: continueButton(labelContinue, OnpressedContinue),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget WarningAlertDialog(BuildContext context, String title, String content,
    String labelContinue, OnpressedContinue) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImg.ic_confirm_icon,
            width: 48,
            height: 48,
          ),
          SizedBox(height: 16),
          Text(title,
              textAlign: TextAlign.center,
              style: AppTypo.LatoBold.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              )),
        ],
      ),
      content: Text(content,
          textAlign: TextAlign.center,
          style: AppTypo.LatoBold.copyWith(
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            fontSize: 14,
          )),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: continueButton(labelContinue, OnpressedContinue),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget continueButton(String _label, OnpressedContinue) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: AppColor.primary,
      shape: RoundedRectangleBorder(
          //to set border radius to button
          borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: OnpressedContinue,
    child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          _label,
        )),
  );
}

Widget cancelButton(String _label, OnpressedCancel) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Colors.white, //background color of button
      side: BorderSide(width: 1, color: Colors.blue), //border width and color
      elevation: 0, //elevation of button
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: OnpressedCancel,
    child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          _label,
          style: TextStyle(color: Colors.blue),
        )),
  );
}
