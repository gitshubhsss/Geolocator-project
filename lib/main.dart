import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:send_location_after_10/routes/routes.dart';
import 'package:send_location_after_10/views/Home/HomeScreen.dart';
import 'package:send_location_after_10/views/Splash/SpashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: getPages(),
      home: const Spashscreen(),
    );
  }
}
