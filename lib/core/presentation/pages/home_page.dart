import 'package:coin_trackr/core/presentation/providers/navigation_provider.dart';
import 'package:coin_trackr/dependencies.dart';
import 'package:coin_trackr/features/crypto/presentation/pages/crypto_list_page.dart';
import 'package:coin_trackr/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final NavigationProvider _navigationProvider;

  HomePage({
    super.key,
    NavigationProvider? navigationProvider,
  }) : _navigationProvider =
            navigationProvider ?? serviceLocator<NavigationProvider>();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onTabSelected(int index) {
    widget._navigationProvider.setTab(HomeTab.values[index]);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: _buildCurrentScreen(),
        bottomNavigationBar: _buildNavigationBar(),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    return Consumer<NavigationProvider>(
      builder: (_, navigationProvider, __) {
        switch (navigationProvider.currentTab) {
          case HomeTab.cryptoList:
            return CryptoListPage();
          case HomeTab.profile:
            return ProfilePage();
          default:
            return CryptoListPage();
        }
      },
    );
  }

  Widget _buildNavigationBar() {
    return Consumer<NavigationProvider>(
      builder: (_, navigationProvider, __) {
        return BottomNavigationBar(
          currentIndex: navigationProvider.currentTab.index,
          onTap: _onTabSelected,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on),
              label: 'Crypto',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_4_outlined),
              label: 'Perfil',
            ),
          ],
        );
      },
    );
  }
}
