import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:coin_trackr/core/common/utils/styles.dart';
import 'package:flutter/material.dart';

class AuthSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final IconData icon;

  const AuthSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.015),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor2,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyles.pBody2.staticColor(AppColors.blackColorContent),
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: size.height * 0.016,
          ),
          errorStyle: const TextStyle(height: 0),
          hintStyle: TextStyles.pBody2.staticColor(AppColors.blackColorContent),
          border: InputBorder.none,
          hintText: "Buscar",
          suffixIcon: Icon(
            icon,
            color: const Color(0xff7B6F72),
          ),
        ),
      ),
    );
  }
}
