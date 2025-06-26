import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:whatsapp/view/auth_screen.dart';
import 'package:whatsapp/view/home_screen.dart';
import 'package:whatsapp/view/otp_screen.dart';
import 'package:whatsapp/view/profile_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen()
    );
  }
}

