import 'package:coin_trackr/core/data/entities/crypto.dart';
import 'package:coin_trackr/core/common/managers/navigator_manager.dart';
import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/core/domain/usecase/get_current_user_use_case.dart';
import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:coin_trackr/features/crypto/domain/usecases/delete_favorite_crypto_use_case.dart';
import 'package:coin_trackr/features/crypto/domain/usecases/get_crypto_list_use_case.dart';
import 'package:coin_trackr/features/crypto/domain/usecases/get_favorites_cryptos_use_case.dart';
import 'package:coin_trackr/features/crypto/domain/usecases/set_favorite_crypto_use_case.dart';
import 'package:flutter/material.dart';

class CryptoProvider extends ChangeNotifier {
  final DeleteFavoriteCryptoUseCase deleteFavoriteCryptoUseCase;
  final GetCryptoListUseCase getCryptoListUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetFavoritesCryptosUseCase getFavoritesCryptosUseCase;
  final SetFavoriteCryptoUseCase setFavoriteCryptoUseCase;

  CryptoProvider({
    required this.deleteFavoriteCryptoUseCase,
    required this.getCryptoListUseCase,
    required this.getCurrentUserUseCase,
    required this.getFavoritesCryptosUseCase,
    required this.setFavoriteCryptoUseCase,
    NavigationManager? navigationManager,
  });

  List<Crypto> _cryptoList = [];
  List<Crypto> get cryptoList {
    return _isFilteredFavorites || _isFilteredSearch
        ? _cryptoListFiltered
        : _cryptoList;
  }

  bool _isFilteredSearch = false;

  List<Crypto> _cryptoListFiltered = [];

  List<String> _favoritesCryptos = [];
  List<String> get favoritesCryptos => _favoritesCryptos;

  bool _isFilteredFavorites = false;
  bool get isFilteredFavorites => _isFilteredFavorites;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _currentUser;

  void searchCrypto(String searchText) {
    if (searchText.isEmpty || searchText.length < 3) {
      _isFilteredSearch = false;
    } else {
      _isFilteredSearch = true;
      _isFilteredFavorites = false;
      _cryptoListFiltered = _cryptoList.where((crypto) {
        return crypto.name.toLowerCase().contains(searchText.toLowerCase());
      }).toList();
    }
    notifyListeners();
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

  void _sortCryptoListAscendent() {
    _cryptoList.sort((a, b) => a.price.compareTo(b.price));
  }

  void _sortCryptoListDescendent() {
    _cryptoList.sort((a, b) => b.price.compareTo(a.price));
  }

  void filterFavorites() {
    if (_isFilteredFavorites == false) {
      _cryptoListFiltered = _cryptoList
          .where(
            (crypto) => cryptoIsFavorite(crypto),
          )
          .toList();
    } else {
      _cryptoListFiltered = List.from(_cryptoList);
    }
    _isFilteredFavorites = !_isFilteredFavorites;
    notifyListeners();
  }

  void sortAscendent() {
    _sortCryptoListAscendent();
    notifyListeners();
  }

  void sortDescendent() {
    _sortCryptoListDescendent();
    notifyListeners();
  }

  void selectFavoriteCrypto(Crypto crypto) {
    cryptoIsFavorite(crypto)
        ? deleteFavoriteCrypto(crypto)
        : setFavoriteCrypto(crypto);
  }

  void setFavoriteCrypto(Crypto crypto) {
    _favoritesCryptos.add(crypto.id);
    final params = SetFavoriteCryptoParams(
      cryptoId: crypto.id,
      userId: _currentUser!.id,
    );
    setFavoriteCryptoUseCase.call(params);
    notifyListeners();
  }

  void deleteFavoriteCrypto(Crypto crypto) {
    _favoritesCryptos.remove(crypto.id);
    final params = DeleteFavoriteCryptoParams(
      cryptoId: crypto.id,
      userId: _currentUser!.id,
    );
    deleteFavoriteCryptoUseCase.call(params);
    notifyListeners();
  }

  bool cryptoIsFavorite(Crypto crypto) {
    return _favoritesCryptos.contains(crypto.id);
  }

  void _setIsLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> refreshCryptoList() async {
    _setIsLoading(true);
    await fetchCryptoList();
    _setIsLoading(false);
  }

  Future<void> initPage() async {
    _setIsLoading(true);
    await Future.wait([
      getFavoritesCryptos(),
      fetchCryptoList(),
    ]);
    _setIsLoading(false);
  }

  Future<void> fetchCryptoList() async {
    final failureOrCryptoList = await getCryptoListUseCase(NoParams());

    failureOrCryptoList.fold(
      (failure) {},
      (cryptoList) {
        _cryptoList = cryptoList;
        _sortCryptoListDescendent();
      },
    );
  }

  Future<void> getFavoritesCryptos() async {
    final favoritesCryptos = await getFavoritesCryptosUseCase(_currentUser!.id);

    favoritesCryptos.fold(
      (failure) {},
      (favoritesCryptosList) {
        _favoritesCryptos = favoritesCryptosList;
      },
    );
  }
}
