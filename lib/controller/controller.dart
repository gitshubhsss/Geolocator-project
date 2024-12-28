import 'dart:async'; // Import to use StreamSubscription
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:send_location_after_10/constant/constants.dart';
import 'package:send_location_after_10/model/responseModel/LocationModel.dart';
import 'package:send_location_after_10/provider/LocationDBHelper.dart';
import 'package:send_location_after_10/views/widgets/dialogues/permissionDialogue.dart';
import 'package:send_location_after_10/views/widgets/snackBars/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashbordController extends GetxController {
  RxBool isPgranted = false.obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;

  Location location = Location();
  StreamSubscription<LocationData>? locationSubscription;

  Future<bool> getUserPermission() async {
    final status = await Permission.location.status;
    if (status.isGranted) {
      isPgranted.value = true;
      return true;
    } else if (status.isPermanentlyDenied) {
      PermissionDialog.showPermissionDialog();
      return false;
    } else {
      final result = await Permission.location.request();
      if (result.isGranted) {
        isPgranted.value = true;
        return true;
      } else {
        isPgranted.value = false;
        return false;
      }
    }
  }

  RxString firstLattitude = "".obs;
  RxString firstLongitude = "".obs;

  void fetchStartLatLong() async {
    try {
      bool permissionGranted = await getUserPermission();
      if (permissionGranted) {
        LocationData currentLocation = await location.getLocation();
        firstLattitude.value = currentLocation.latitude!.toString();
        firstLongitude.value = currentLocation.longitude!.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(LATTITUDE, firstLattitude.value);
        prefs.setString(LONGITUDE, firstLongitude.value);
        debugPrint(
            "Start Latitude: ${firstLattitude.value}, Start Longitude: ${firstLongitude.value}");
      } else {
        debugPrint("Permission denied. Unable to fetch location.");
      }
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
  }

  final RxList<LocationModel> locations = <LocationModel>[].obs;
  final dbHelper = LocationDBHelper();
  void getCurrentLocation() async {
    locationSubscription ??=
        location.onLocationChanged.listen((LocationData currentLocation) async {
      debugPrint(
          "Location: ${currentLocation.latitude}, ${currentLocation.longitude}");
      latitude.value = currentLocation.latitude!.toString();
      longitude.value = currentLocation.longitude!.toString();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      firstLattitude.value = prefs.getString(LATTITUDE) ?? "0.0";
      firstLongitude.value = prefs.getString(LONGITUDE) ?? "0.0";
      final distance = calculateDistanceInMeter(
        double.parse(firstLattitude.value),
        double.parse(firstLongitude.value),
        currentLocation.latitude!,
        currentLocation.longitude!,
      ).round();

      debugPrint("distance  : ${distance} in meter");
      if (distance > 10) {
        firstLattitude.value = currentLocation.latitude!.toString();
        firstLongitude.value = currentLocation.longitude!.toString();
        await prefs.setString(LATTITUDE, firstLattitude.value);
        await prefs.setString(LONGITUDE, firstLongitude.value);
        debugPrint("Updated starting point to current location");
        Snackbar("Success", "Updated starting point to current location",
            Colors.green);

        if (distance > 10) {
          firstLattitude.value = currentLocation.latitude!.toString();
          firstLongitude.value = currentLocation.longitude!.toString();

          // Save to SharedPreferences
          await prefs.setString(LATTITUDE, firstLattitude.value);
          await prefs.setString(LONGITUDE, firstLongitude.value);
          debugPrint("Updated starting point to current location");
          Snackbar("Success", "Updated starting point to current location",
              Colors.green);
          // Save to SQLite

          final isInserted = await dbHelper.insertLocation(
              firstLattitude.value, firstLongitude.value);
          debugPrint("${isInserted}");
          if (isInserted == true) {
            //you need to call to the api
            fetchLocations();
            Snackbar("Success", "Inserted into sql lite", Colors.green);
          }
        }
      }
    });
  }

  Future<void> fetchLocations() async {
    final List<Map<String, dynamic>> locationMaps =
        await dbHelper.getAllLocations();
    locations.value =
        locationMaps.map((map) => LocationModel.fromJson(map)).toList();
  }

  double calculateDistanceInMeter(
    double startLat,
    double startLng,
    double currentLat,
    double currentLng,
  ) {
    const earthRadius = 6371000; // Radius of Earth in meters
    final dLat = _degreesToRadians(currentLat - startLat);
    final dLng = _degreesToRadians(currentLng - startLng);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(startLat)) *
            cos(_degreesToRadians(currentLat)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c; // Distance in meters
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  void stopLocationUpdates() async {
    if (locationSubscription != null) {
      locationSubscription?.cancel();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(LATTITUDE);
      prefs.remove(LONGITUDE);
      firstLattitude.value = "";
      firstLongitude.value = "";
      locationSubscription = null;
      latitude.value = "";
      longitude.value = "";
      debugPrint("Location updates stopped.");
    } else {
      debugPrint("No active location updates to stop.");
    }
    location.enableBackgroundMode(enable: false);
  }
}
