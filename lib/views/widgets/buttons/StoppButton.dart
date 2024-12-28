import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:send_location_after_10/controller/controller.dart';

class StoppedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  StoppedButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    DashbordController controller = Get.put(DashbordController());
    return Obx(() {
      final isButtonEnabled = controller.isPgranted.value;
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isButtonEnabled ? Colors.orange : Colors.grey,
        ),
        onPressed: isButtonEnabled ? onPressed : () async {
          
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
