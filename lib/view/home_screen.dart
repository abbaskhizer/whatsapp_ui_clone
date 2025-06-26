import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp/view/call_screen.dart';
import 'package:whatsapp/view/chat_screen.dart';
import 'package:whatsapp/view/communties_screen.dart';

import 'package:whatsapp/controller/bottom_tab_controller.dart';
import 'package:whatsapp/view/status_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final controller = Get.put(BottomTabController());

final List<Widget> screens = const [
  ChatScreen(),
  StatusScreen(),
  CommunitiesScreen(),
  CallsScreen(),
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Obx(() => screens[controller.currentIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Update'),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Communties',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Call',
            
          ),
        ],
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeIndex,
        elevation: 5.0,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),)
    );
  }
}
