import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../view/otp_screen.dart';

class AuthController extends GetxController {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final nameController = TextEditingController();

  final isLoading = false.obs;
  final isOtpSent = false.obs;
  final secondsRemaining = 60.obs;

  String _phone = '';
  String _authToken = '';
  Timer? _timer;

  void sendOtp() async {
    final phone = phoneController.text.trim();
    if (phone.length != 10 || !RegExp(r'^[0-9]{10}\$').hasMatch(phone)) {
      Get.snackbar("Invalid", "Enter valid 10-digit phone number");
      return;
    }
    _phone = '+92$phone';
    isLoading.value = true;

    final res = await http.post(
      Uri.parse("https://your-api.com/api/auth/send-otp"),
      body: jsonEncode({"phone": _phone}),
      headers: {"Content-Type": "application/json"},
    );

    isLoading.value = false;

    if (res.statusCode == 200) {
      isOtpSent.value = true;
      startTimer();
      Get.to(() => const OtpScreen());
    } else {
      Get.snackbar("Error", "Failed to send OTP");
    }
  }

  void verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.length != 6 || !RegExp(r'^\\d{6}\$').hasMatch(otp)) {
      Get.snackbar("Invalid", "Enter 6-digit OTP");
      return;
    }

    isLoading.value = true;

    final res = await http.post(
      Uri.parse("https://your-api.com/api/auth/verify-otp"),
      body: jsonEncode({"phone": _phone, "otp": otp}),
      headers: {"Content-Type": "application/json"},
    );

    isLoading.value = false;

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      _authToken = body['token'];
      Get.to(() => const OtpScreen());
    } else {
      Get.snackbar("Error", "Invalid OTP");
    }
  }

  void submitName() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      Get.snackbar("Name Required", "Please enter your name");
      return;
    }

    isLoading.value = true;

    final res = await http.post(
      Uri.parse("https://your-api.com/api/user/set-name"),
      body: jsonEncode({"name": name}),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_authToken",
      },
    );

    isLoading.value = false;

    if (res.statusCode == 200) {
      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Error", "Failed to save name");
    }
  }

  void resendOtp() {
    secondsRemaining.value = 60;
    startTimer();
    sendOtp();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value == 0) {
        timer.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    phoneController.dispose();
    otpController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
