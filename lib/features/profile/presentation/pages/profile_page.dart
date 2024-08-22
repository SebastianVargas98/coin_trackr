import 'package:coin_trackr/core/common/managers/navigator_manager.dart';
import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:coin_trackr/core/common/utils/loader.dart';
import 'package:coin_trackr/core/common/utils/styles.dart';
import 'package:coin_trackr/dependencies.dart';
import 'package:coin_trackr/features/auth/presentation/providers/auth_provider.dart';
import 'package:coin_trackr/features/auth/presentation/widgets/auth_calendar_field.dart';
import 'package:coin_trackr/features/auth/presentation/widgets/auth_field.dart';
import 'package:coin_trackr/core/presentation/Widgets/gradient_button.dart';
import 'package:coin_trackr/features/profile/presentation/providers/profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final ProfileProvider _profileProvider;
  final NavigationManager _navigationManager;

  ProfilePage({
    super.key,
    ProfileProvider? profileProvider,
    NavigationManager? navigationManager,
  })  : _profileProvider = profileProvider ?? serviceLocator<ProfileProvider>(),
        _navigationManager =
            navigationManager ?? serviceLocator<NavigationManager>();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _dateController = TextEditingController();
  final formUpdatePasswordKey = GlobalKey<FormState>();
  final formUpdateUserKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget._profileProvider.initPage();
    _nameController.text = widget._profileProvider.currentUser.name;
    _lastNameController.text = widget._profileProvider.currentUser.lastName;
    _userNameController.text = widget._profileProvider.currentUser.userName;
    _dateController.text = DateFormat('yyyy-MM-dd')
        .format(widget._profileProvider.currentUser.birthDate);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Perfil',
                          style: TextStyles.pHeadline4.bold
                              .staticColor(AppColors.colorBlack73),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Cambiar contraseña:',
                          style: TextStyles.pBody1
                              .staticColor(AppColors.colorBlack73),
                        ),
                      ),
                      _buildUpdatePasswordForm(),
                      _buildDivider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Actualizar datos de usuario:',
                          style: TextStyles.pBody1
                              .staticColor(AppColors.colorBlack73),
                        ),
                      ),
                      _buildUpdateProfileForm(),
                      _buildDivider(),
                      _buildLogOutButton(),
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

  Widget _buildDivider() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(80)),
        color: AppColors.greyColor,
      ),
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: double.maxFinite,
      height: 2,
    );
  }

  Widget _buildLogOutButton() {
    return GradientButton(
      buttonText: Text(
        'Cerrar Sesión',
        style: TextStyles.pBody1.bold.staticColor(AppColors.whiteColor),
      ),
      onPressed: _logOutAction,
    );
  }

  Widget _buildUpdatePasswordForm() {
    return Form(
        key: formUpdatePasswordKey,
        child: Column(
          children: [
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
            const SizedBox(height: 20),
            Consumer<ProfileProvider>(
              builder: (_, profileProvider, __) {
                return GradientButton(
                  buttonText: profileProvider.isLoadingUpdatePassword
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.whiteColor,
                          ),
                        )
                      : Text(
                          'Actualizar Constraseña',
                          style: TextStyles.pBody1.bold
                              .staticColor(AppColors.whiteColor),
                        ),
                  onPressed: _updatePasswordAction,
                );
              },
            ),
          ],
        ));
  }

  Widget _buildUpdateProfileForm() {
    return Form(
      key: formUpdateUserKey,
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
          AuthCalendarField(
            hintText: 'Fecha de nacimiento',
            controller: _dateController,
            icon: Icons.calendar_month,
            onTap: () => _selectDate(context),
            validator: _birthDateValidator,
          ),
          const SizedBox(height: 20),
          Consumer<ProfileProvider>(
            builder: (_, profileProvider, __) {
              return GradientButton(
                buttonText: profileProvider.isLoadingUpdateUSer
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.whiteColor,
                        ),
                      )
                    : Text(
                        'Actualizar Datos',
                        style: TextStyles.pBody1.bold
                            .staticColor(AppColors.whiteColor),
                      ),
                onPressed: _updateUserAction,
              );
            },
          ),
        ],
      ),
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

  ///Hide the keyboard if showed
  void _hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _logOutAction() {
    widget._profileProvider.logOut();
  }

  void _updatePasswordAction() {
    _hideKeyboard();
    if (formUpdatePasswordKey.currentState!.validate()) {
      widget._profileProvider
          .updatePassword(newPassword: _passwordController.text);
      _passwordController.text = '';
      _passwordConfirmationController.text = '';
    }
  }

  void _updateUserAction() {
    _hideKeyboard();
    if (formUpdateUserKey.currentState!.validate()) {
      DateTime birthDate = DateTime.parse(_dateController.text);
      widget._profileProvider.updateUser(
        name: _nameController.text,
        userName: _userNameController.text,
        lastName: _lastNameController.text,
        birthDate: birthDate,
      );
    }
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
    if (date != null && widget._profileProvider.isOlderThan18Years(date)) {
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
