import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveIndicator extends StatelessWidget {
  String os;
  Color colorIndicator;

  AdaptiveIndicator({required this.os, this.colorIndicator = Colors.blue});

  @override
  Widget build(BuildContext context) {
    if (this.os == "android")
      return CircularProgressIndicator(
        color: colorIndicator,
      );
    return CupertinoActivityIndicator(
      color: colorIndicator,
    );
  }
}
