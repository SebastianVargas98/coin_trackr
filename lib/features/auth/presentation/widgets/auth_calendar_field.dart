import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:coin_trackr/core/common/utils/styles.dart';
import 'package:flutter/material.dart';

class AuthCalendarField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final VoidCallback onTap;
  final FormFieldValidator validator;

  const AuthCalendarField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onTap,
    required this.icon,
    required this.validator,
  });

  @override
  State<AuthCalendarField> createState() => _AuthCalendarFieldState();
}

class _AuthCalendarFieldState extends State<AuthCalendarField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.015),
      width: size.width * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor2,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextFormField(
        readOnly: true,
        style: TextStyles.pBody2.staticColor(AppColors.blackColorContent),
        controller: widget.controller,
        validator: widget.validator,
        onTap: widget.onTap,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: size.height * 0.016,
          ),
          errorStyle: const TextStyle(height: 0),
          hintStyle: TextStyles.pBody2.staticColor(AppColors.blackColorContent),
          border: InputBorder.none,
          hintText: widget.hintText,
          prefixIcon: Icon(
            widget.icon,
            color: const Color(0xff7B6F72),
          ),
        ),
      ),
    );
  }
}
