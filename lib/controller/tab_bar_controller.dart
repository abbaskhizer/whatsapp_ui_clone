import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> tabs = const [
    Tab(text: "All"),
    Tab(text: "Unread"),
    Tab(text: "Groups"),
    Tab(text: "Favourites"),
    Tab(text: "+",)
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
