import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:send_location_after_10/controller/controller.dart';

class Seelocations extends StatefulWidget {
  const Seelocations({super.key});

  @override
  State<Seelocations> createState() => _SeelocationsState();
}

class _SeelocationsState extends State<Seelocations> {
  DashbordController controller = Get.put(DashbordController());

  @override
  void initState() {
    super.initState();
    // Fetch locations when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Locations'),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Obx(() {
        if (controller.locations.isEmpty) {
          return Center(child: Text('No locations available'));
        }
        return ListView.builder(
          itemCount: controller.locations.length,
          itemBuilder: (context, index) {
            final location = controller.locations[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Icon(Icons.location_on, color: Colors.orange),
                title: Text(
                  'Latitude: ${location.latitude}, Longitude: ${location.longitude}',
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text('ID: ${location.id ?? 'N/A'}'),
              ),
            );
          },
        );
      }),
    );
  }
}
