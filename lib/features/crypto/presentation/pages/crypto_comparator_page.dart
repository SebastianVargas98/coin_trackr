import 'package:coin_trackr/core/common/managers/navigator_manager.dart';
import 'package:coin_trackr/dependencies.dart';
import 'package:coin_trackr/features/crypto/presentation/providers/crypto_provider.dart';
import 'package:flutter/material.dart';

class CryptoComparatorPage extends StatefulWidget {
  final CryptoProvider _cryptoProvider;
  final NavigationManager _navigationManager;
  CryptoComparatorPage({
    super.key,
    CryptoProvider? cryptoProvider,
    NavigationManager? navigationManager,
  })  : _cryptoProvider = cryptoProvider ?? serviceLocator<CryptoProvider>(),
        _navigationManager =
            navigationManager ?? serviceLocator<NavigationManager>();

  @override
  State<CryptoComparatorPage> createState() => _CryptoComparatorPageState();
}

class _CryptoComparatorPageState extends State<CryptoComparatorPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text("Comparator page")),
    );
  }
}
