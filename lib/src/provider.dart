import 'package:custom_side_menu/src/side_menu_display_mode.dart';
import 'package:custom_side_menu/src/side_menu_style.dart';
import 'package:flutter/material.dart';

class GProvider {
  static late PageController controller;
  static late SideMenuStyle style;
  static DisplayModeNotifier displayModeState =
      DisplayModeNotifier(SideMenuDisplayMode.auto);
}

class DisplayModeNotifier extends ValueNotifier<SideMenuDisplayMode> {
  DisplayModeNotifier(SideMenuDisplayMode value) : super(value);
  
  bool open=false;


  void change(SideMenuDisplayMode mode) {
    value = mode;
    
    notifyListeners();
  }
}