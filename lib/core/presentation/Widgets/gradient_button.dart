import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget buttonText;
  final VoidCallback onPressed;
  final double sizeWidthPercentage;
  final double sizeGeightPercentage;
  const GradientButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.sizeWidthPercentage = 0.8,
    this.sizeGeightPercentage = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * sizeWidthPercentage,
      height: size.width * sizeGeightPercentage,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.gradient1,
            AppColors.gradient2,
            AppColors.gradient3,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: AppColors.transparentColor,
          shadowColor: AppColors.transparentColor,
        ),
        child: buttonText,
      ),
    );
  }
}
