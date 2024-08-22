import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:coin_trackr/core/common/utils/styles.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthGradientButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: size.width * 0.1,
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
        child: Text(
          buttonText,
          style: TextStyles.pBody1.bold.staticColor(AppColors.whiteColor),
        ),
      ),
    );
  }
}
