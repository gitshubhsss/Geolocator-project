import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:send_location_after_10/constant/constants.dart';
import 'package:send_location_after_10/controller/controller.dart';

class Spashscreen extends StatefulWidget {
  const Spashscreen({super.key});

  @override
  State<Spashscreen> createState() => _SpashscreenState();
}

DashbordController controller = Get.put(DashbordController());

class _SpashscreenState extends State<Spashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      //will chekc the permission
      //then will go to home
      checkPermission();
    });
  }

  checkPermission() async {
    final isGranted = await controller.getUserPermission();
    if (isGranted == true) {
      controller.fetchStartLatLong(); //fist will fetch the start vala latlong
      controller.getCurrentLocation(); //then will get the current vala latlong
    }
    Get.toNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SizedBox.expand(
        child: Image.asset(
          splashScreenImage,
          fit: BoxFit.cover,
        ),
      )),
    );
  }
}
