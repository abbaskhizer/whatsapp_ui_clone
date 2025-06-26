import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp/controller/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.put(AuthController());
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              Icon(Icons.message, size: size.width * 0.2, color: Colors.teal),
              const SizedBox(height: 20),
              Text('Verify your phone number',
                  style: TextStyle(fontSize: size.width * 0.055, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              const Text('WhatsApp will send an SMS message to verify your phone number.',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.teal.shade300),
                ),
                child: Row(
                  children: [
                    const Text("+92", style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: auth.phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: "Enter phone number",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: auth.isLoading.value ? null : auth.sendOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: auth.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Next', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  )),
              const Spacer(flex: 2),
              const Text("Carrier SMS charges may apply.", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
