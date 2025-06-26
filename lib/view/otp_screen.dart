import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp/controller/auth_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
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
              Icon(Icons.sms, size: size.width * 0.2, color: Colors.teal),
              const SizedBox(height: 24),
              Text('Verify your number',
                  style: TextStyle(fontSize: size.width * 0.055, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Obx(() => Text('Waiting to automatically detect an SMS sent to +92 ${auth.phoneController.text}',
                  textAlign: TextAlign.center, style: const TextStyle(fontSize: 15))),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.teal.shade300),
                ),
                child: TextField(
                  controller: auth.otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: const TextStyle(letterSpacing: 4, fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(counterText: '', border: InputBorder.none, hintText: '______'),
                  onSubmitted: (_) => auth.verifyOtp(),
                ),
              ),
              const SizedBox(height: 30),
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: auth.isLoading.value ? null : auth.verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: auth.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Verify', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  )),
              const SizedBox(height: 20),
              Obx(() => auth.secondsRemaining.value > 0
                  ? Text('Resend code in ${auth.secondsRemaining.value}s',
                      style: TextStyle(color: Colors.grey.shade600))
                  : TextButton(
                      onPressed: auth.resendOtp,
                      child: const Text('Resend OTP', style: TextStyle(color: Colors.teal)),
                    )),
              const Spacer(flex: 2),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Wrong number?", style: TextStyle(color: Colors.redAccent)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
