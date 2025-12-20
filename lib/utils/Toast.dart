import 'package:flutter/material.dart';

class Toast {
  static bool showLoading = false;
  static void showToast(BuildContext context, String? msg) {
    // 移除之前的错误逻辑，确保每次都能显示toast
    Toast.showLoading = true;
    Future.delayed(Duration(seconds: 3), () {
      Toast.showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        behavior: SnackBarBehavior.floating,
        content: Text(msg ?? "加载成功", textAlign: TextAlign.center),
      ),
    );
  }
}
