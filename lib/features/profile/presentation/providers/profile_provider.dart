import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/core/common/managers/navigator_manager.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:coin_trackr/core/common/utils/styles.dart';
import 'package:coin_trackr/core/domain/usecase/get_current_user_use_case.dart';
import 'package:coin_trackr/core/domain/usecase/save_local_user_use_case.dart';
import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:coin_trackr/dependencies.dart';
import 'package:coin_trackr/features/profile/domain/usecases/update_password_use_case.dart';
import 'package:coin_trackr/features/profile/domain/usecases/update_user_use_case.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final SaveLocalUserUseCase saveLocalUserUseCase;
  final NavigationManager _navigationManager;

  ProfileProvider({
    required this.getCurrentUserUseCase,
    required this.updateUserUseCase,
    required this.updatePasswordUseCase,
    required this.saveLocalUserUseCase,
    NavigationManager? navigationManager,
  }) : _navigationManager =
            navigationManager ?? serviceLocator<NavigationManager>();

  bool _isLoadingUpdatePassword = false;
  bool get isLoadingUpdatePassword => _isLoadingUpdatePassword;

  bool _isLoadingUpdateUSer = false;
  bool get isLoadingUpdateUSer => _isLoadingUpdateUSer;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  User? _currentUser;
  User get currentUser => _currentUser!;

  void navigateTo() {
    //_navigationManager.navigatePushingTo(AppRoutes);
  }

  User? getCurrentUser() {
    final userResponse = getCurrentUserUseCase.call(NoParams());
    userResponse.fold(
      (failure) {
        _currentUser = null;
      },
      (user) {
        _currentUser = user;
      },
    );
    return _currentUser;
  }

  Future<void> updatePassword({
    required String newPassword,
  }) async {
    try {
      _isLoadingUpdatePassword = true;
      notifyListeners();
      final res = await updatePasswordUseCase.call(newPassword);
      res.fold(
        (failure) => _updatePasswordFailureHandler(failure),
        (updated) {
          _updatePasswordSuccessHandler();
        },
      );
    } catch (e) {
      _errorMessage = 'Error: ${e.toString()}';
    } finally {
      _isLoadingUpdatePassword = false;
      notifyListeners();
    }
  }

  void initPage() {
    getCurrentUser();
  }

  Future<void> updateUser({
    required String name,
    required String lastName,
    required String userName,
    required DateTime birthDate,
  }) async {
    try {
      _isLoadingUpdateUSer = true;
      notifyListeners();
      final updateUserParams = UpdateUserParams(
        userId: _currentUser!.id,
        name: name,
        lastName: lastName,
        userName: userName,
        birthDate: birthDate,
      );
      final res = await updateUserUseCase.call(updateUserParams);
      res.fold(
        (failure) => _updateUserFailureHandler(failure),
        (updated) => _updateUserSuccessHandler(updateUserParams),
      );
    } catch (e) {
      _errorMessage = 'Error: ${e.toString()}';
    } finally {
      _isLoadingUpdateUSer = false;
      notifyListeners();
    }
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

  void _updateUserFailureHandler(Failure failure) {
    _navigationManager.showSnackBar(
      Text(
        "Hubo un error al intentar actualizar tus datos.\nError: ${failure.message}",
        style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
      ),
      AppColors.errorColor,
      duration: const Duration(seconds: 3),
    );
  }

  void _updateUserSuccessHandler(UpdateUserParams updateUserParams) {
    _navigationManager.showSnackBar(
      Text(
        "Tus datos han sido actualizados!",
        style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
      ),
      AppColors.gradient2,
      duration: const Duration(seconds: 3),
    );
    _currentUser!.name = updateUserParams.name;
    _currentUser!.lastName = updateUserParams.lastName;
    _currentUser!.userName = updateUserParams.userName;
    _currentUser!.birthDate = updateUserParams.birthDate;
    saveLocalUserUseCase.call(_currentUser!);
  }

  void _updatePasswordSuccessHandler() {
    _navigationManager.showSnackBar(
      Text(
        "Tu constraseña ha sido actualizada",
        style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
      ),
      AppColors.gradient2,
      duration: const Duration(seconds: 3),
    );
  }

  void _updatePasswordFailureHandler(Failure failure) {
    _navigationManager.showSnackBar(
      Text(
        "Hubo un error al intentar actualizar Contraseña.\nError: ${failure.message}",
        style: TextStyles.pCaption.bold.staticColor(AppColors.whiteColor),
      ),
      AppColors.errorColor,
      duration: const Duration(seconds: 3),
    );
  }
}
