import 'package:coin_trackr/core/common/theme/theme.dart';
import 'package:coin_trackr/core/common/utils/app_routes.dart';
import 'package:coin_trackr/core/presentation/pages/home_page.dart';
import 'package:coin_trackr/core/presentation/providers/navigation_provider.dart';
import 'package:coin_trackr/features/auth/presentation/pages/login_page.dart';
import 'package:coin_trackr/features/auth/presentation/pages/sign_up_page.dart';
import 'package:coin_trackr/features/auth/presentation/providers/auth_provider.dart';
import 'package:coin_trackr/features/crypto/presentation/providers/crypto_provider.dart';
import 'package:coin_trackr/features/profile/presentation/pages/profile_page.dart';
import 'package:coin_trackr/features/profile/presentation/providers/profile_provider.dart';
import 'package:coin_trackr/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initDependencies();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => serviceLocator<AuthProvider>()),
      ChangeNotifierProvider(create: (_) => serviceLocator<CryptoProvider>()),
      ChangeNotifierProvider(
          create: (_) => serviceLocator<NavigationProvider>()),
      ChangeNotifierProvider(create: (_) => serviceLocator<ProfileProvider>()),
    ],
    child: const CoinTrackr(),
  ));
}

class CoinTrackr extends StatelessWidget {
  const CoinTrackr({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.login,
      getPages: [
        GetPage(name: AppRoutes.login, page: () => LoginPage()),
        GetPage(name: AppRoutes.signUp, page: () => SignUpPage()),
        GetPage(name: AppRoutes.home, page: () => HomePage()),
        GetPage(name: AppRoutes.profile, page: () => ProfilePage()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Coin Trackr',
      theme: AppTheme.appThemeMode,
      home: LoginPage(),
    );
  }
}
