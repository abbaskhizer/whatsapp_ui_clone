import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final messageController = TextEditingController();
  final messages = <Map<String, dynamic>>[].obs;
  final scrollController = ScrollController();

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    messages.add({
      'text': text,
      'isMe': true,
      'time': TimeOfDay.now().format(Get.context!),
    });
    messageController.clear();

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.minScrollExtent);
      }
    });

    // Simulate a reply
    Future.delayed(const Duration(milliseconds: 800), () {
      messages.add({
        'text': 'Reply to: $text',
        'isMe': false,
        'time': TimeOfDay.now().format(Get.context!),
      });

      Future.delayed(const Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.minScrollExtent);
        }
      });
    });
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
