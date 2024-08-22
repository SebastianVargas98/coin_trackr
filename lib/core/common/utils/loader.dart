import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:coin_trackr/core/common/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Widget that creates the global loader.
class Loader extends StatelessWidget {
  final bool isVisible;
  final double opacity;

  const Loader({
    required this.isVisible,
    this.opacity = 0.7,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Visibility(
      visible: isVisible,
      child: Opacity(
        opacity: opacity,
        child: Container(
          color: staticColor(AppColors.colorBlack73)!,
          child: Center(
            child: Lottie.asset(
              'assets/animations/loader_animation.json',
              width: size.width * 0.35,
              height: size.width * 0.35,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
