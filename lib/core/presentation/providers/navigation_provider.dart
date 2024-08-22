import 'package:flutter/material.dart';

enum HomeTab { cryptoList, profile }

class NavigationProvider with ChangeNotifier {
  HomeTab _currentTab = HomeTab.cryptoList;

  HomeTab get currentTab => _currentTab;

  void setTab(HomeTab tab) {
    _currentTab = tab;
    notifyListeners();
  }
}
