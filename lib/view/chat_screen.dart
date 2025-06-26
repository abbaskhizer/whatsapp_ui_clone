import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp/controller/tab_bar_controller.dart';
import 'package:whatsapp/view/chat_detail_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatTabController chatTabController = Get.put(ChatTabController());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp", style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.teal),
        elevation: 1,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt)),
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
          ),
        ],
        bottom: TabBar(
          controller: chatTabController.tabController,
          tabs: chatTabController.tabs,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.teal,
          isScrollable: true,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.015,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search or start new chat",
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: chatTabController.tabController,
              children: chatTabController.tabs.map((tab) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => ListTile(onTap: () => Get.to(ChatDetailScreen()),
                    leading: CircleAvatar(
                      radius: width * 0.06,
                      backgroundColor: Colors.teal,
                      child: Text(
                        '${tab.text![0]}$index',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text('${tab.text} User $index'),
                    subtitle: const Text('Hey there! I’m using WhatsApp.'),
                    trailing: Text('${11 + index}:${index}0 AM'),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),

     
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.chat),
      ),
    );
  }
}
