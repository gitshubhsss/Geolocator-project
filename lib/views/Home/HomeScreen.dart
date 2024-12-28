import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:send_location_after_10/controller/controller.dart';
import 'package:send_location_after_10/views/Splash/SpashScreen.dart';
import 'package:send_location_after_10/views/widgets/buttons/GetAllLocationsbutton.dart';
import 'package:send_location_after_10/views/widgets/buttons/StoppButton.dart';
import 'package:send_location_after_10/views/widgets/buttons/buttons.dart';
import 'package:send_location_after_10/views/widgets/snackBars/snackbar.dart';
import 'package:send_location_after_10/views/widgets/textStyles/textStyle.dart';

class Homescreen extends StatefulWidget {
  final String? title;

  const Homescreen({super.key, this.title});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    DashbordController controller = Get.put(DashbordController());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title: const Center(
          child: Text(''),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: width * 0.2, right: width * 0.2, bottom: width * 0.1),
              child: Column(
                children: [
                  Obx(() {
                    return Text("Latitude : ${controller.latitude.value},",
                        style: textStyle(Colors.black, 16));
                  }),
                  Divider(),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Obx(() {
                    return Text("Longitude : ${controller.longitude.value},",
                        style: textStyle(Colors.black, 16));
                  }),
                  Divider(),
                ],
              ),
            ),
            Center(
              child: DashboardButton(
                  onPressed: () {
                    Snackbar("Success", "Getting the current location",
                        Colors.green);
                    controller.fetchStartLatLong();
                    controller.getCurrentLocation();
                  },
                  title: "Share location"),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            Center(
              child: StoppedButton(
                  title: "Stop sharing location",
                  onPressed: () {
                    controller.stopLocationUpdates();
                  }),
            ),
            Center(
              child: Getalllocationsbutton(
                  title: "Get all locations",
                  onPressed: () {
                    Get.toNamed("/seelocations");
                  }),
            )
          ],
        ),
      ),
    );
  }
}
