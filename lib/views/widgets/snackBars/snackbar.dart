import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void Snackbar(String status, String message, Color color) {
  Get.snackbar("${status}", "${message}",
      backgroundColor: color, colorText: Colors.white);
}
