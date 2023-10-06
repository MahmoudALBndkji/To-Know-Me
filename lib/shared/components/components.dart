import 'package:To_Know_Me/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateReplacementTo(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));

Widget defaultTextButton(
        {VoidCallback? function, String? text, isUpper = true}) =>
    TextButton(
      onPressed: function,
      child: Text(isUpper ? "$text".toUpperCase() : "$text"),
    );

Widget defaultElevatedButton({
  Color backgroundColorButton = Colors.blue,
  double? height = 50.0,
  double? width = double.infinity,
  VoidCallback? function,
  String? text,
  double? borderRadius = 0.0,
  Color? colorText = Colors.white,
}) =>
    Container(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColorButton),
        ),
        onPressed: function,
        child: Text(
          "$text".toUpperCase(),
          style: TextStyle(
            color: colorText,
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  var controller,
  var onSubmit,
  bool obscureText = false,
  TextInputType? keyboardType,
  TextInputAction? action,
  String? labelText,
  String? hintText = "",
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  var validation,
  context,
  InputBorder? borderShape,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      textInputAction: action,
      style: TextStyle(),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(),
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: Padding(
          padding: EdgeInsetsDirectional.only(end: 10.0),
          child: IconButton(
            onPressed: suffixPressed,
            icon: Icon(suffixIcon),
          ),
        ),
        border: borderShape ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
      ),
      validator: validation,
    );

void showToast({
  required String message,
  required ToastStates state,
  Toast? showDuration,
  int? showTimeForWeb,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: showDuration ?? Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: showTimeForWeb ?? 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates {
  SUCCESS,
  ERROR,
  WARNING,
}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

AppBar defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 5.0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(IconBroken.Arrow___Left_2),
      ),
      title: Text(title!),
      actions: actions,
      elevation: 0.1,
    );

Widget myDivider() => Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: 1.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200.0),
          color: Colors.blue,
        ),
      ),
    );

Widget buildIntroductionPage({
  required Color colorContainer,
  bool isLast = false,
  required String urlImage,
  String? title,
  Color? colorTitle,
  required String subTitle,
  required Color colorSubTitle,
}) =>
    Container(
      width: double.infinity,
      color: colorContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 35.0,
            ),
            child: Image.asset(
              urlImage,
              width: 300.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 40.0,
              horizontal: 20.0
            ),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorSubTitle,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );