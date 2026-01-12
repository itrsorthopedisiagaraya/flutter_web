import 'package:flutter/material.dart';

enum AdminPage { dashboard, users }

class AdminState extends ChangeNotifier {
  AdminPage _page = AdminPage.dashboard;

  AdminPage get page => _page;

  void go(AdminPage page) {
    _page = page;
    notifyListeners();
  }
}
