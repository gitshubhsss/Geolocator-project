import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:send_location_after_10/controller/controller.dart';

class DashboardButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  DashboardButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    DashbordController controller = Get.put(DashbordController());
    return Obx(() {
      final isButtonEnabled = controller.isPgranted.value;
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isButtonEnabled ? Colors.orange : Colors.grey,
        ),
        onPressed: isButtonEnabled
            ? onPressed
            : () async {
                final isGrated = await controller.getUserPermission();
                debugPrint("${isGrated} priting the value of isgranted");
              },
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
