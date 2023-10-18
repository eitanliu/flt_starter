import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 展示消息
void toast(String? message) {
  if (message == null) return;
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color(0xff333333),
    textColor: Colors.white,
    fontSize: 14.0,
  );
}
