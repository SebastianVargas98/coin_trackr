import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:coin_trackr/core/common/utils/styles.dart';
import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final IconData icon;
  final FormFieldValidator validator;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    required this.icon,
    required this.validator,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool passwordVisible = false;

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
        style: TextStyles.pBody2.staticColor(AppColors.blackColorContent),
        controller: widget.controller,
        validator: widget.validator,
        textInputAction: TextInputAction.next,
        obscureText: widget.isPassword ? !passwordVisible : false,
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
          suffixIcon: widget.isPassword
              ? InkWell(
                  onTap: () =>
                      setState(() => passwordVisible = !passwordVisible),
                  child: passwordVisible
                      ? const Icon(
                          Icons.visibility_off_outlined,
                          color: Color(0xff7B6F72),
                        )
                      : const Icon(
                          Icons.visibility_outlined,
                          color: Color(0xff7B6F72),
                        ),
                )
              : null,
        ),
      ),
    );
  }
}
