import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:coin_trackr/core/common/utils/loader.dart';
import 'package:coin_trackr/core/common/utils/styles.dart';
import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/dependencies.dart';
import 'package:coin_trackr/features/auth/presentation/widgets/auth_search_bar.dart';
import 'package:coin_trackr/features/crypto/presentation/providers/crypto_provider.dart';
import 'package:coin_trackr/features/crypto/presentation/widgets/crypto_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListPage extends StatefulWidget {
  final CryptoProvider _cryptoProvider;
  CryptoListPage({
    super.key,
    CryptoProvider? cryptoProvider,
  }) : _cryptoProvider = cryptoProvider ?? serviceLocator<CryptoProvider>();

  @override
  State<CryptoListPage> createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget._cryptoProvider.initPage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _hideKeyboard,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  _buildTopSection(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await widget._cryptoProvider.refreshCryptoList();
                      },
                      child: Consumer<CryptoProvider>(
                        builder: (_, cryptoProvider, __) {
                          return ListView(
                            children: cryptoProvider.cryptoList
                                .map(
                                  (crypto) => CryptoTileWidget(
                                    crypto: crypto,
                                    onCheck:
                                        cryptoProvider.selectFavoriteCrypto,
                                    isFavorite:
                                        cryptoProvider.cryptoIsFavorite(crypto),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        _buildLoader(),
      ],
    );
  }

  ///Hide the keyboard if showed
  void _hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Widget _buildLoader() {
    return Consumer<CryptoProvider>(builder: (_, cryptoProvider, __) {
      return Loader(isVisible: cryptoProvider.isLoading);
    });
  }

  Widget _buildTopSection() {
    User? user = widget._cryptoProvider.getCurrentUser();
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
      child: Column(
        children: [
          _buildWelcomeMessage(user!),
          _buildFilterButtons(),
        ],
      ),
    );
  }

  Widget _buildWelcomeMessage(User user) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "¡Hola, ${user.name}!",
        style: TextStyles.pSubtitle2.bold.staticColor(AppColors.gradient2),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Row(
      children: [
        Expanded(
          child: AuthSearchBar(
            controller: _searchController,
            onChanged: widget._cryptoProvider.searchCrypto,
            icon: Icons.search,
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: widget._cryptoProvider.sortAscendent,
          child: const Icon(
            Icons.arrow_upward,
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: widget._cryptoProvider.sortDescendent,
          child: const Icon(
            Icons.arrow_downward,
          ),
        ),
        const SizedBox(width: 10),
        Consumer<CryptoProvider>(builder: (_, cryptoProvider, __) {
          return InkWell(
            onTap: () {
              widget._cryptoProvider.filterFavorites();
              _searchController.text = '';
            },
            child: cryptoProvider.isFilteredFavorites
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border_outlined),
          );
        }),
      ],
    );
  }
}
