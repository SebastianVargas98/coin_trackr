import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/core/common/managers/navigator_manager.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:coin_trackr/core/common/utils/app_routes.dart';
import 'package:coin_trackr/core/common/utils/styles.dart';
import 'package:coin_trackr/dependencies.dart';
import 'package:coin_trackr/features/auth/domain/usecases/login_use_case.dart';
import 'package:coin_trackr/features/auth/domain/usecases/register_use_case.dart';
import 'package:coin_trackr/core/domain/usecase/save_local_user_use_case.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final SaveLocalUserUseCase saveLocalUserUseCase;
  final NavigationManager _navigationManager;

  AuthProvider({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.saveLocalUserUseCase,
    NavigationManager? navigationManager,
  }) : _navigationManager =
            navigationManager ?? serviceLocator<NavigationManager>();

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void navigateToRegister() {
    _navigationManager.navigatePushingTo(AppRoutes.signUp);
  }

  bool isOlderThan18Years(DateTime birthDate) {
    final today = DateTime.now();
    final age = today.year - birthDate.year;

    if (birthDate.month > today.month ||
        (birthDate.month == today.month && birthDate.day > today.day)) {
      return age - 1 >= 18;
    }
    return age >= 18;
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final res = await loginUseCase
          .call(LoginParams(email: email, password: password));

      res.fold(
        (failure) => _loginFailureHandler(failure),
        (user) => _loginSuccessHandler(user),
      );
    } catch (e) {
      _errorMessage = 'Error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _loginFailureHandler(Failure failure) {
    _navigationManager.showSnackBar(
      Text(
        "No se pudo iniciar sesión.\nError: ${failure.message}",
        style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
      ),
      AppColors.errorColor,
      duration: const Duration(seconds: 3),
    );
  }

  void _loginSuccessHandler(User user) {
    saveLocalUserUseCase.call(user);
    _navigationManager.navigateReplacingTo(AppRoutes.home);
  }

  void _registerFailureHandler(Failure failure) {
    _navigationManager.showSnackBar(
      Text(
        "Hubo un error al intentar hacer tu registro.\nError: ${failure.message}",
        style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
      ),
      AppColors.errorColor,
      duration: const Duration(seconds: 3),
    );
  }

  void _registerSuccessHandler(User user) {
    saveLocalUserUseCase.call(user);
    _navigationManager.navigateReplacingTo(AppRoutes.home);
  }

  Future<void> register(
    String email,
    String password,
    String name,
    String lastName,
    String userName,
    DateTime birthDate,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final registerParams = RegisterParams(
        email: email,
        password: password,
        name: name,
        lastName: lastName,
        userName: userName,
        birthDate: birthDate,
      );
      final res = await registerUseCase.call(registerParams);
      res.fold(
        (failure) => _registerFailureHandler(failure),
        (user) => _registerSuccessHandler(user),
      );
    } catch (e) {
      _errorMessage = 'Error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
