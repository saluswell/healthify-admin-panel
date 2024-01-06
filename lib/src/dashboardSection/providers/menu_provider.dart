import 'package:flutter/material.dart';

import '../models/menu_model.dart';

class MenuProvider extends ChangeNotifier {
  late TabController tabController;
  int? selectedIndex = 0;
  List<MenuModel> menuList = [
    MenuModel("1", "", "assets/images/1menu.svg"),
    MenuModel("1", "", "assets/images/2menu.svg"),
    MenuModel("1", "", "assets/images/3menu.svg"),
    MenuModel("1", "", "assets/images/4menu.svg"),
    MenuModel("1", "", "assets/images/5menu.svg"),
    MenuModel("1", "", "assets/images/6menu.svg"),
    MenuModel("1", "", "assets/images/2menu.svg"),
    MenuModel("1", "", "assets/images/7menu.svg"),
    MenuModel("1", "", "assets/images/8menu.svg"),
  ];

  setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // The method to switch tabs when a specific icon is clicked
  switchTab(int index) {
    tabController.index = index;
    notifyListeners();
  }
}
