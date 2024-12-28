import 'package:get/get.dart';
import 'package:send_location_after_10/constant/constants.dart';
import 'package:send_location_after_10/model/requestModel/GpsDataModel.dart';
import 'package:send_location_after_10/model/responseModel/LocationResponseModel.dart';

class Gpsprovider extends GetConnect {
  Future<LocationResponse?> fetchGps(GpsData gpsdata) async {
    try {
      final response = await post(fetchGpsurl, gpsdata.toJson());

      if (response.statusCode == 200) {
        return LocationResponse.fromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
