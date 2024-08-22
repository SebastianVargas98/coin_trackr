import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class in charge of handling the [navigatorKey] to perform the navigation without requiring
/// the current widget's context.
class NavigationManager {
  /// Closes the current snack bar
  void closeSnackBar() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
  }

  /// Navigates to a [route] by pushing the desired widget into the stack.
  void navigatePushingTo(String route) => Get.toNamed(
        route,
        preventDuplicates: false,
      );

  /// Navigates to a [route] by replacing the current widget in the stack.
  void navigateReplacingTo(String route) => Get.offNamed(
        route,
        preventDuplicates: false,
      );

  /// Pops the current widget from the stack.
  void pop([Object? data]) => Get.back(result: data);

  /// Pops the stack views for the [times] specified.
  void popForTimes(
    int times, {
    Object? data,
    bool closeOverlays = false,
  }) {
    for (int i = 0; i < times; i++) {
      Get.back(result: data, closeOverlays: closeOverlays);
    }
  }

  /// Pops all the views in the stack and navigates to [route]
  void popUntil(String route) {
    Get.offAllNamed(
      route,
    );
  }

  /// Creates a [dialog] with [barrierDismissible] and [barrierColor] configuration arguments
  Future<dynamic> showDialog(
    Widget dialog, {
    bool barrierDismissible = false,
    Color? barrierColor,
  }) {
    return Get.dialog(
      dialog,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
    );
  }

  /// Shows a snackbar with a [content] and [backgroundColor]
  void showSnackBar(
    Widget content,
    Color backgroundColor, {
    Icon? icon,
    Duration? duration,
  }) {
    Get.rawSnackbar(
      backgroundColor: backgroundColor,
      messageText: content,
      duration: duration ?? const Duration(seconds: 1),
      icon: icon,
    );
  }
}
