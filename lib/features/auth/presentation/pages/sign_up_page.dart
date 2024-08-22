import 'package:coin_trackr/core/common/managers/navigator_manager.dart';
import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:coin_trackr/core/common/utils/loader.dart';
import 'package:coin_trackr/core/common/utils/styles.dart';
import 'package:coin_trackr/dependencies.dart';
import 'package:coin_trackr/features/auth/presentation/providers/auth_provider.dart';
import 'package:coin_trackr/features/auth/presentation/widgets/auth_calendar_field.dart';
import 'package:coin_trackr/features/auth/presentation/widgets/auth_field.dart';
import 'package:coin_trackr/core/presentation/Widgets/gradient_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  final AuthProvider _authProvider;
  final NavigationManager _navigationManager;

  SignUpPage({
    super.key,
    AuthProvider? authProvider,
    NavigationManager? navigationManager,
  })  : _authProvider = authProvider ?? serviceLocator<AuthProvider>(),
        _navigationManager =
            navigationManager ?? serviceLocator<NavigationManager>();

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _hideKeyboard,
          child: Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Registro',
                        style: TextStyles.pHeadline5.bold
                            .staticColor(AppColors.colorBlack73),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            AuthField(
                              hintText: 'Nombre',
                              controller: _nameController,
                              icon: Icons.person,
                              validator: _nameValidator,
                              isPassword: false,
                            ),
                            AuthField(
                              hintText: 'Apellido',
                              controller: _lastNameController,
                              icon: Icons.person,
                              validator: _lastNameValidator,
                              isPassword: false,
                            ),
                            AuthField(
                              hintText: 'Nombre de usuario',
                              controller: _userNameController,
                              icon: Icons.account_circle_sharp,
                              validator: _userNameValidator,
                              isPassword: false,
                            ),
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
                            AuthField(
                              hintText: 'Verifique contraseña',
                              controller: _passwordConfirmationController,
                              icon: Icons.lock,
                              validator: _passwordConfirmationValidator,
                              isPassword: true,
                            ),
                            AuthCalendarField(
                              hintText: 'Fecha de nacimiento',
                              controller: _dateController,
                              icon: Icons.calendar_month,
                              onTap: () => _selectDate(context),
                              validator: _birthDateValidator,
                            ),
                            const SizedBox(height: 20),
                            GradientButton(
                              buttonText: Text(
                                'Registrar',
                                style: TextStyles.pBody1.bold
                                    .staticColor(AppColors.whiteColor),
                              ),
                              onPressed: _signUpAction,
                            ),
                          ],
                        ),
                      )
                    ],
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  void _signUpAction() {
    if (formKey.currentState!.validate()) {
      DateTime birthDate = DateTime.parse(_dateController.text);
      widget._authProvider.register(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
        _lastNameController.text,
        _userNameController.text,
        birthDate,
      );
    }
  }

  ///Hide the keyboard if showed
  void _hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  String? _nameValidator(dynamic text) {
    if (!text!.isEmpty) {
      return null;
    }
    widget._navigationManager.showSnackBar(
      Text(
        'El Nombre no puede estar vacío.',
        style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
      ),
      AppColors.errorColor,
    );
    return '';
  }

  String? _userNameValidator(dynamic text) {
    if (!text!.isEmpty) {
      return null;
    }
    widget._navigationManager.showSnackBar(
      Text(
        'El Nombre de usuario no puede estar vacío.',
        style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
      ),
      AppColors.errorColor,
    );
    return '';
  }

  String? _lastNameValidator(dynamic text) {
    if (!text!.isEmpty) {
      return null;
    }
    widget._navigationManager.showSnackBar(
      Text(
        'El Apellido no puede estar vacío.',
        style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
      ),
      AppColors.errorColor,
    );
    return '';
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
    if (text!.length > 5) {
      return null;
    }
    widget._navigationManager.showSnackBar(
      Text(
        'La contraseña debe tener al menos 6 caracteres.',
        style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
      ),
      AppColors.errorColor,
    );
    return '';
  }

  String? _passwordConfirmationValidator(dynamic text) {
    if (text == _passwordController.text) {
      return null;
    } else {
      widget._navigationManager.showSnackBar(
        Text(
          'Las contraseñas no coinciden.',
          style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
        ),
        AppColors.errorColor,
      );
    }
    return '';
  }

  String? _birthDateValidator(dynamic text) {
    DateTime? date = DateTime.tryParse(text);
    if (date != null && widget._authProvider.isOlderThan18Years(date)) {
      return null;
    } else {
      widget._navigationManager.showSnackBar(
        Text(
          'Debes tener más de 18 años para registrarte',
          style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
        ),
        AppColors.errorColor,
      );
    }
    return '';
  }
}
