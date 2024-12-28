import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDialog {
  static void showPermissionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Permission Required"),
        content: const Text(
            "Location permission is required for this feature. Please enable it in app settings."),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              openAppSettings(); // Open app settings
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }
}
