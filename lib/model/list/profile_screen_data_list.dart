import 'package:dark_and_light_mode_2_module/model/bottom_navigation_item_model.dart';
import 'package:dark_and_light_mode_2_module/model/profile_progress_model.dart';
import 'package:dark_and_light_mode_2_module/model/settings_model.dart';
import 'package:flutter/material.dart';

class DataList{
  List<ProgressModel> progressList = [
    ProgressModel(title: 'Income', progress: 20,color: Colors.blue.shade500),
    ProgressModel(title: 'Deposit Income', progress: 31,color: Colors.green.shade400),
    ProgressModel(title: 'Spend', progress: 42,color: Colors.red.shade400)
  ];

  List<SettingModel> settingList = [
    SettingModel(label: 'Low ballance alert', isSelected: true),
    SettingModel(label: 'Show blocked cards', isSelected: false),
    SettingModel(label: 'Dark Mode', isSelected: true),
    SettingModel(label: 'Touch ID', isSelected: true),
  ];

  List<BottomNavigationBarItemModel> bottomNavigationBarItem = [
    BottomNavigationBarItemModel(
      icon: Icons.account_balance_wallet,
      isSelected: false,
      ),
    BottomNavigationBarItemModel(
      icon: Icons.ac_unit,
      isSelected: false,
      ),
    BottomNavigationBarItemModel(
      icon: Icons.person,
      isSelected: false,
      ),
    BottomNavigationBarItemModel(
      icon: Icons.drag_handle_outlined,
      isSelected: false,
      ),
  ];
}