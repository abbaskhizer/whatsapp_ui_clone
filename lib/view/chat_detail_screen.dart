import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp/controller/chat_controller.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 1,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            const CircleAvatar(backgroundColor: Colors.amber, radius: 18),
            SizedBox(width: width * 0.03),
            Text('Khizer', style: TextStyle(fontSize: width * 0.045)),
          ],
        ),
        actions: const [
          IconButton(icon: Icon(Icons.videocam), onPressed: null),
          IconButton(icon: Icon(Icons.call), onPressed: null),
          IconButton(icon: Icon(Icons.more_vert), onPressed: null),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: Obx(() => ListView.builder(
              controller: chatController.scrollController,
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
              itemCount: chatController.messages.length,
              itemBuilder: (context, index) {
                final message = chatController.messages[chatController.messages.length - 1 - index];
                final isMe = message['isMe'] as bool;

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: height * 0.005),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: height * 0.012,
                    ),
                    constraints: BoxConstraints(maxWidth: width * 0.75),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.teal.shade100 : Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                        bottomLeft: isMe ? const Radius.circular(15) : Radius.zero,
                        bottomRight: isMe ? Radius.zero : const Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['text'],
                          style: TextStyle(fontSize: width * 0.038),
                        ),
                        SizedBox(height: height * 0.005),
                        Text(
                          message['time'] ?? '',
                          style: TextStyle(fontSize: width * 0.03, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
          ),

          // Input bar
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.008),
              child: Row(
                children: [
                  Icon(Icons.emoji_emotions_outlined, color: Colors.grey, size: width * 0.07),
                  SizedBox(width: width * 0.02),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: chatController.messageController,
                        decoration: const InputDecoration(
                          hintText: 'Message',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => chatController.sendMessage(),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  Icon(Icons.attach_file, color: Colors.grey, size: width * 0.065),
                  SizedBox(width: width * 0.02),
                  GestureDetector(
                    onTap: chatController.sendMessage,
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.send, color: Colors.white, size: width * 0.06),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
