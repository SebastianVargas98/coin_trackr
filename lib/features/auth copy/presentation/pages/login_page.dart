import 'package:coin_trackr/core/common/managers/navigator_manager.dart';
import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:coin_trackr/core/common/utils/loader.dart';
import 'package:coin_trackr/core/common/utils/styles.dart';
import 'package:coin_trackr/dependencies.dart';
import 'package:coin_trackr/features/auth/presentation/providers/auth_provider.dart';
import 'package:coin_trackr/features/auth/presentation/widgets/auth_field.dart';
import 'package:coin_trackr/core/presentation/Widgets/gradient_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final AuthProvider _authProvider;
  final NavigationManager _navigationManager;

  LoginPage({
    super.key,
    AuthProvider? authProvider,
    NavigationManager? navigationManager,
  })  : _authProvider = authProvider ?? serviceLocator<AuthProvider>(),
        _navigationManager =
            navigationManager ?? serviceLocator<NavigationManager>();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PopScope(
          canPop: false,
          child: GestureDetector(
            onTap: _hideKeyboard,
            child: Scaffold(
              body: SafeArea(
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/coin_trackr_logo.png',
                          height: 125,
                        ),
                        Text(
                          'Coin Trackr',
                          style: TextStyles.qHeadline4.bold
                              .staticColor(AppColors.blackColorContent),
                        ),
                        const SizedBox(height: 50),
                        AuthField(
                          hintText: 'Correo',
                          controller: _emailController,
                          icon: Icons.email,
                          validator: _emailValidator,
                          isPassword: false,
                        ),
                        AuthField(
                          hintText: 'Contraseña',
                          controller: _passwordController,
                          icon: Icons.password,
                          validator: _passwordValidator,
                          isPassword: true,
                        ),
                        const SizedBox(height: 20),
                        GradientButton(
                          buttonText: Text(
                            'Iniciar sesión',
                            style: TextStyles.pBody1.bold
                                .staticColor(AppColors.whiteColor),
                          ),
                          onPressed: _loginAction,
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: _navigateToRegister,
                          child: RichText(
                            text: TextSpan(
                              text: '¿No tienes una cuenta? ',
                              style: TextStyles.pBody1.bold
                                  .staticColor(AppColors.blackColor),
                              children: [
                                TextSpan(
                                  text: 'Regístrate',
                                  style: TextStyles.pBody1.bold
                                      .staticColor(AppColors.gradient2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildLoader(),
      ],
    );
  }

  Widget _buildLoader() {
    return Consumer<AuthProvider>(builder: (_, authProvider, __) {
      return Loader(isVisible: authProvider.isLoading);
    });
  }

  ///Hide the keyboard if showed
  void _hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _navigateToRegister() {
    widget._authProvider.navigateToRegister();
  }

  void _loginAction() {
    if (formKey.currentState!.validate()) {
      widget._authProvider
          .login(_emailController.text, _passwordController.text);
    }
  }

  String? _emailValidator(dynamic text) {
    if (EmailValidator.validate(text)) {
      return null;
    }
    widget._navigationManager.showSnackBar(
      Text(
        'Correo inválido.',
        style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
      ),
      AppColors.errorColor,
    );
    return '';
  }

  String? _passwordValidator(dynamic text) {
    if (text!.length > 6) {
      return null;
    }
    widget._navigationManager.showSnackBar(
      Text(
        'Contraseña inválida.',
        style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
      ),
      AppColors.errorColor,
    );
    return '';
  }
}
